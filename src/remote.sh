# remote.sh

# Show the remote URL from current folder
# Example: gloner geturl
#
# If arguments given, show the remote from the folders passed
# Example: gloner geturl folder1/ folder2/
function get_url()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		exit 1
	fi

	# Check if the arguments are valid directories, and exit if they aren't
	check_directories     "$@"
	check_git_directories "$@"

	# Path to return after every cd travel
	local return_path=$(pwd)

	for i in "$@"; do
		cd "$i"

		if [[ "$verbose" ]]; then
			echo "$i"
			git remote -v
			echo
		else
			git remote -v | \
			head -1 | sed -r "s/^[^\t]+\t([^ ]+) .*$/\1/g"
		fi

		cd "$return_path"
	done
}

function set_ssh()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		exit 1
	fi

	# Check if the arguments are valid directories, and exit if they aren't
	check_directories     "$@"
	check_git_directories "$@"

	# Path to return after every cd travel
	local return_path=$(pwd)

	new_remote=$()
}
