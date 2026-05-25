session_root "~/w/lt/"

if initialize_session "landing-pages"; then
	run_cmd "dev"

	new_window "run"
	run_cmd "cd landing-pages-www"
	run_cmd "npm run dev"

	split_h

	run_cmd "cd strapi-cms"
	run_cmd "npm run dev"

	select_pane 0

fi

finaliza_and_go_to_session

