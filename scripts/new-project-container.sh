#!/usr/bin/env bash
set -euo pipefail

slug="${1:-}"
if [ -z "$slug" ]; then
  read -rp "Project slug: " slug
fi

if [ -z "$slug" ]; then
  echo "slug required"
  exit 1
fi

flake_path="/etc/dotfiles/projects/$slug"
if [ ! -f "$flake_path/flake.nix" ]; then
  echo "error: no flake found at $flake_path"
  echo "did you run new-project on webber and 'nrs'?"
  exit 1
fi

echo "Setting up $slug inside the container."
echo ""

read -rp "Display name for banner (e.g. 'Trailhub', 'Expense Tracker'): " display_name
read -rp "Your name for git commits: " git_name
read -rp "Email for git commits: " git_email

if [ -z "$display_name" ] || [ -z "$git_name" ] || [ -z "$git_email" ]; then
  echo "all fields are required"
  exit 1
fi

read -rp "Generate a dedicated SSH key for this project? [y/N]: " gen_key
gen_key="${gen_key:-n}"

if [[ "$gen_key" =~ ^[Yy]$ ]]; then
  key_path="$HOME/.ssh/${slug}_ed25519"
  if [ -f "$key_path" ]; then
    echo "key already exists at $key_path — skipping keygen"
  else
    ssh-keygen -t ed25519 -f "$key_path" -C "$git_email" -N ""
    echo "✓ generated $key_path"
  fi
fi

mkdir -p "$HOME/.config/projects"
chmod 700 "$HOME/.config/projects"
env_file="$HOME/.config/projects/$slug.env"
cat > "$env_file" <<EOF
GIT_AUTHOR_NAME=$git_name
GIT_AUTHOR_EMAIL=$git_email
PROJECT_DISPLAY_NAME=$display_name
EOF
chmod 600 "$env_file"
echo "✓ wrote $env_file"

mkdir -p "$HOME/w/$slug"
echo "✓ created ~/w/$slug"

echo ""
echo "──────────────────────────────────────────────────────────────"
if [[ "$gen_key" =~ ^[Yy]$ ]]; then
  echo "Add this public key to $display_name's GitHub:"
  echo ""
  cat "${HOME}/.ssh/${slug}_ed25519.pub"
  echo ""
  echo "Then clone with the project alias:"
  echo "  cd ~/w/$slug"
  echo "  git clone git@github-$slug:org/repo.git"
else
  echo "Clone repos under ~/w/$slug/ using your normal SSH key:"
  echo "  cd ~/w/$slug"
  echo "  git clone git@github.com:org/repo.git"
fi
echo ""
echo "Then 'cd' into the repo and run 'dev' to activate the shell."
echo "──────────────────────────────────────────────────────────────"
