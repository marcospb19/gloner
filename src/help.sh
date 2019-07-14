# help.sh

function list_available_commands()
{
	cat <<- "EOT"

		Available commands:

		    Help:
		        help  <Command>                      [-v|--verbose]

		    Clone:
		        clone  <User> [Repository] [Target]  [--ssh|--http] [-R|--recursive]

		    Remote:
		        geturl  <Folders>                    [-v|--verbose] [-R|--recursive]

	EOT
}

function show_help()
{
	cat <<- "EOT"

		Usage: gloner <Command> [-h|--help] [-V|--version] [-v|--verbose] [-R|--recursive]

	EOT

	list_available_commands
}

# Just a function wrapper
function show_help_and_exit()
{
	echo
	show_help
	exit 1
}

# Show described information about other command, called when
# "gloner help <Command>" is typed, or when a bad usage is detected
# inside of an command function
function help_command()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		exit 1
	fi

	local command="$1"

	if [[ "$command" == "help" ]]; then
		echo "gloner help - Show help and usage to any gloner command"
		echo
		echo "Usage:"
		echo "    gloner help <Command>"

	elif [[ "$command" == "clone" ]]; then # Pending
		echo "gloner clone - Clone a repository only by having the user and name"
		echo
		echo "Usage:"
		echo "    gloner clone <User> <Repository> [Target]"

	elif [[ "$command" == "geturl" ]]; then
		echo "gloner geturl - Show the remote URL (origin) from local repositories"
		echo
		echo "Usage:"
		echo "    gloner geturl <Folders> [--verbose]"

	else
		echoerr "\"$command\" command not recognized."
		list_available_commands
		exit 1
	fi

	exit 0
}
