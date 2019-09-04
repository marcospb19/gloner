# check.sh

# Similar to check_git_directories
#
# Checks if array of arguments are valid
# directories, if one of them isn't, exit
function check_directories()
{
	# Should exit
	local should_exit

	if [[ "$recursive" ]]; then

		for i in "$@"; do
			# If isn't a directory
			for j in $(find "$i" -type d); do
				if [[ ! -d "$j" ]]; then
					should_exit="true"
					echoerr "\"$(realpath "$i")\" is not a directory"
				fi
			done
		done

	else # [[ ! "$recursive" ]]

		for i in "$@"; do
			# If isn't a directory
			if [[ ! -d "$i" ]]; then
				should_exit="true"
				echoerr "\"$(realpath "$i")\" is not a directory"
			fi
		done

	fi

	# Note that this function lists every fail before exiting
	if [[ "$should_exit" ]]; then
		exit 1
	fi
}

# Similar to check_directories
#
# Checks if array of arguments are valid git
# directories, if one of them isn't, exit
function check_git_directories()
{
	# Should exit
	local should_exit

	if [[ "$recursive" ]]; then

		for i in "$@"; do
			for j in $(find "$i" -type d); do
				if [[ ! $(git rev-parse --git-dir "$j" 2> /dev/null) ]]; then
					# If isn't a git directory
					should_exit="true"
					echoerr "\"$(realpath "$i")\" is not a git repository"
				fi
			done
		done

	else # [[ ! "$recursive" ]]

		for i in "$@"; do
			if [[ ! $(git rev-parse --git-dir "$i" 2> /dev/null) ]]; then
				# If isn't a git directory
				should_exit="true"
				echoerr "\"$(realpath "$i")\" is not a git repository"
			fi
		done

	fi

	# Note that this function lists every fail before
	# exiting, this is why we need $should_exit
	if [[ "$should_exit" ]]; then
		exit 1
	fi
}
