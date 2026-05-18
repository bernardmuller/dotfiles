_work_load_identity() {
	local slug
	slug=$(basename "$PWD")
	local id_file="$HOME/.config/projects/$slug.env"

	if [ -f "$id_file" ]; then
	  set -a
	  # shellcheck disable=SC1090
	  source "$id_file"
	  set +a
	else
	  echo "⚠  no identity file at $id_file"
	  echo "   create it with GIT_AUTHOR_NAME=... GIT_AUTHOR_EMAIL=..."
	  return 0
	fi

	export GIT_COMMITTER_NAME="${GIT_AUTHOR_NAME:-}"
	export GIT_COMMITTER_EMAIL="${GIT_AUTHOR_EMAIL:-}"
}

_work_print_banner() {
	local slug
	slug=$(basename "$PWD")

	echo ""
	echo "$slug shell ready."
	echo "  Git identity: ${GIT_AUTHOR_NAME:-NOT SET} <${GIT_AUTHOR_EMAIL:-NOT SET}>"
	if command -v gcloud >/dev/null 2>&1; then
	  echo "  gcloud:       $(gcloud --version 2>/dev/null | head -1)"
	fi
	echo ""
}

_work_load_identity
_work_print_banner
