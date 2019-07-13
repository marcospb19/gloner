# check.sh

# Checks if array of arguments are valid
# directories, if one of them isn't, exit
function check_directories()
{
	exit=""

	for i in "$@"; do
		# If isn't a directory
		if [[ ! -d "$i" ]]; then
			exit="true"
			echoerr "'$i' is not a directory"

		fi
	done

	# Note that this function lists every fail before exiting
	if [[ "$exit" == "true" ]]; then
		exit 1
	fi
}

# Similar to check_directories
#
# Checks if array of arguments are valid git
# directories, if one of them isn't, exit
function check_git_directories()
{
	exit=""

	for i in "$@"; do
		# If isn't a git directory
		if [[ ! $(git rev-parse --git-dir 2> /dev/null) ]]; then
			exit="true"
			echoerr "\"$(realpath "$i")\" is not a git directory"
		fi
	done

	# Note that this function lists every fail before exiting
	if [[ "$exit" == "true" ]]; then
		exit 1
	fi
}
