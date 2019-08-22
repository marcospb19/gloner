# help.sh

function list_available_commands()
{
	cat <<- EOT

		Available commands:

		    Help:
		        help  <Command>                      [-v|--verbose]

		    Clone:
		        clone  <User> [Repository] [Target]  [--ssh|--http] [-R|--recursive]

		    Remote:
		    	list    <User>
		        geturl  <Folders>                    [-v|--verbose] [-R|--recursive]
		        setssh  <Folders>                    [-v|--verbose] [-R|--recursive]
		        sethttp <Folders>                    [-v|--verbose] [-R|--recursive]

	EOT
}

function show_help()
{
	cat <<- EOT

		Usage: gloner <Command> [-h|--help] [-V|--version] [-v|--verbose] [-R|--recursive]

	EOT

	list_available_commands
}

# Just a function wrapper
function show_help_and_exit()
{
	show_help
	exit 1
}

# Show useful information about other command
# Usage: gloner help <Command>
function help_command()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		show_help_and_exit
	fi

	local command="$1"

	if [[ "$command" == "help" ]]; then
		cat <<- EOT
		    gloner help - Show help and usage to any gloner command

		    Usage:
		        gloner help <Command>
		EOT

	elif [[ "$command" == "clone" ]]; then
		cat <<- EOT
		    gloner clone - Clone a repository only by having the user and name

		    Usage:
		        gloner clone <User> <Repository> [Target]
		EOT

	elif [[ "$command" == "geturl" ]]; then
		cat <<- EOT
		    gloner geturl - Show the remote URL (origin) from local repositories

		    Usage:
		        gloner geturl <Folders> [--verbose]
		EOT

	elif [[ "$command" == "setssh" ]]; then
		cat <<- EOT
		    gloner setssh - Change <Folders> remote from http protocol to ssh

		    Usage:
		        gloner setssh <Folders> [--verbose]
		EOT

	elif [[ "$command" == "sethttp" ]]; then
		cat <<- EOT
		    gloner sethttp - Change <Folders> remote from ssh protocol to http

		    Usage:
		        gloner sethttp <Folders> [--verbose]
		EOT

	elif [[ "$command" == "root" ]]; then
		cat <<- EOT
		    "root help" - Just in case you clone something as root

		    Problems:
		        The repository is owned by root, and cannot be worked on.

		    Solution:
		        As your main user, run the following command
		        "sudo chown $USER $HOME --recursive"

		        This will change the ownage to your user.
		EOT

	else
		echoerr "\"$command\" command not recognized."

		list_available_commands # Slighty different from $show_help_and_exit
		exit 1
	fi

	exit 0
}

