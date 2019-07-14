# remote.sh

# Show the remote URL from current folder
# Example: gloner geturl
#
# If arguments given, show the remote from the folders passed
# Example: gloner geturl folder1/ folder2/
function get_url()
{
	# If no folders passed, execute on current folder
	if [[ "$#" == 0 ]]; then
		1="."
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

	for i in "$@"; do
		cd "$i"

		local old_remote=$(git remote -v | \
			tr " \t" "\n\n" | head -2 | tail -1)

		# If it was http
		if [[ ${old_remote:0:4} == "http" ]]; then
			local new_remote=$(echo "$old_remote" | sed -r \
				"s/^.+\.com\/([^\/]+)\/(.+)$/git@github.com:\1\/\2.git/g")
			git remote set-url origin "$new_remote" # Swapped

		elif [[ ${old_remote:0:4} == "git@" ]]; then
			echo "\"$(pwd)\", There's nothing to do."

		else
			echoerr "Unknown url format at $(pwd), cannot transform"
			exit 2
		fi

		cd "$return_path"
	done
}

function set_http()
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

		local old_remote=$(git remote -v | \
			tr " \t" "\n\n" | head -2 | tail -1)

		# If it was ssh
		if [[ ${old_remote:0:4} == "git@" ]]; then
			local new_remote=$(echo "$old_remote" | sed -r \
				"s/^.+\.com:([^\/]+)\/(.+)\.git$/https:\/\/github.com\/\1\/\2/g")
			git remote set-url origin "$new_remote" # Swapped

		elif [[ ${old_remote:0:4} == "http" ]]; then
			echo "\"$(pwd)\", There's nothing to do."

		else
			echoerr "Unknown url format at $(pwd), cannot transform"
			exit 2
		fi

		cd "$return_path"
	done
}
