# remote.sh

# Show the remote URL from current folder
# Example: gloner geturl
#
# If arguments given, show the remote from the folders passed
# Example: gloner geturl folder1/ folder2/
function get_url()
{
	# Boolean to enable printing every directory that failed before exiting
	local exit=""

	# Check if all the arguments are valid directories
	for i in "$@"; do
		if [[ ! -d "$i" ]]; then
			exit="true"
			echoerr "'$i' is not a directory"

		fi
	done

	if [[ "$exit" ]]; then
		exit 2
	fi

	# Path to return after every cd
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
