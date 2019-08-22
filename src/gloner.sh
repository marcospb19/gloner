# gloner.sh

# If no arguments given
if [[ "$#" == "0" ]]; then
	echoerr "No arguments given."
	show_help_and_exit

# If running with sudo
elif [[ "$USER" == "root" ]]; then
	echoerr "You're running gloner as root, be careful with permission errors between users."
	echoerr "For more information on this, type \"gloner help root\""
	echoerr
fi

# Process all arguments given and assign flag values
# (some flags may cause exiting here)
#
# Returns $arguments, $number_of_arguments and $command
parse_arguments "$@"

# If no command is given
if [[ "$number_of_arguments" == 0 ]]; then
	echoerr "No arguments given."
	show_help_and_exit
fi


case "$command" in
    # Help
	help)    help_command      "${arguments[@]}" ;;

    # Clone
	clone)   clone_repository  "${arguments[@]}" ;;

    # Remote
	list)    list_repositories "${arguments[@]}" ;;
	sethttp) set_http          "${arguments[@]}" ;;
	setssh)  set_ssh           "${arguments[@]}" ;;
	geturl)  get_url           "${arguments[@]}" ;;

	*)  echoerr "Invalid command: \"$command\""
		show_help_and_exit ;;
esac

exit 0
