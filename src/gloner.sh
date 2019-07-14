# gloner.sh

# If no arguments given
if [[ "$#" == "0" ]]; then
	echoerr "No arguments given."
	show_help
	exit 1

# If running with sudo
elif [[ "$USER" == "root" ]]; then
	echoerr "You're running gloner as root, be careful with permission errors between users."
	# echoerr "For help with solving that, type 'gloner help root'"
fi

# Process all arguments given and assign flag values
# (some flags may cause exiting here)
#
# Returns $arguments, $number_of_arguments and $command
parse_arguments "$@"

# Number of arguments + 1 for the command
number_of_arguments="${#arguments[@]}"

# If no command is given
if [[ "$number_of_arguments" == 0 ]]; then
	echo "No arguments given."
	show_help_and_exit
fi

case "$command" in
	geturl) get_url          "${arguments[@]}" ;;
	clone)  clone_repository "${arguments[@]}" ;;
	help)   help_command     "${arguments[@]}" ;;

	*)  echo "Command \"$command\" not recognized"
		show_help_and_exit ;;
esac

exit 0
