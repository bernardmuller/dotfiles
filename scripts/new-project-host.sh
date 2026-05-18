#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$HOME/dotfiles"

if [ ! -d "$DOTFILES" ]; then
  echo "error: $DOTFILES not found"
  exit 1
fi

echo "Set up a new project in dotfiles."
echo ""

read -rp "Project slug (short, lowercase, no spaces, e.g. 'th' or 'expense-tracker'): " slug
if [ -z "$slug" ]; then
  echo "slug required"
  exit 1
fi

if [[ ! "$slug" =~ ^[a-z0-9-]+$ ]]; then
  echo "slug must be lowercase letters, numbers, hyphens only"
  exit 1
fi

flake_dir="$DOTFILES/projects/$slug"
if [ -d "$flake_dir" ]; then
  echo "error: $flake_dir already exists"
  exit 1
fi

mkdir -p "$flake_dir"
cat > "$flake_dir/flake.nix" <<EOF
{
  description = "Project environment";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.\${system};
    in {
      devShells.\${system}.default = pkgs.mkShell {
        name = "$slug";
        packages = with pkgs; [
          # Add your packages here.
          # Search: https://search.nixos.org/packages
        ];
        shellHook = ''
          source /etc/dotfiles/lib/project-identity.sh
        '';
      };
    };
}
EOF

echo "✓ created $flake_dir/flake.nix"

echo ""
echo "Generating flake.lock..."
( cd "$flake_dir" && nix flake lock )
echo "✓ created $flake_dir/flake.lock"

cat <<EOF

──────────────────────────────────────────────────────────────
Next steps (manual):

1. Edit the flake to add the packages this project needs:

       \$EDITOR $flake_dir/flake.nix

   Search for packages at https://search.nixos.org/packages

2. (Optional, if this project needs its own SSH key) add this
   block to ~/dotfiles/containers/dev/home.nix inside
   programs.ssh.matchBlocks:

       "github-$slug" = {
         hostname = "github.com";
         user = "git";
         identityFile = "~/.ssh/${slug}_ed25519";
         identitiesOnly = true;
       };

3. Stage the new files in git:

       cd ~/dotfiles
       git add projects/$slug containers/dev/home.nix

4. Rebuild:

       nrs

5. Inside the container, run:

       new-project $slug

──────────────────────────────────────────────────────────────
EOF
