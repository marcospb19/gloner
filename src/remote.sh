# remote.sh

# Show the remote from local repositories
# Usage:
#     gloner geturl
#     gloner geturl <Folder> <Folder>...
function get_url()
{
	# If no folders passed, execute on current folder
	if [[ "$#" == 0 ]]; then
		get_url $(pwd)
		return
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

# Reformat the url from HTTP to SSH
# Usage:
#     gloner setssh
#     gloner setssh <Folder> <Folder>...
function set_ssh()
{
	# If no folders passed, execute on current folder
	if [[ "$#" == 0 ]]; then
		set_ssh $(pwd)
		return
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

# Reformat the url from SSH to HTTP
# Usage:
#     gloner sethttp
#     gloner sethttp <Folder> <Folder>...
function set_http()
{
	# If no folders passed, execute on current folder
	if [[ "$#" == 0 ]]; then
		set_http $(pwd)
		return
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

# List the github repositories from an user
# Usage:
#     gloner list <User>
#     gloner list <User> <User>...
# Flags supported:
#     --ssh --http [-q|--quiet]
function list_repositories()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No user argument given."
		show_help_and_exit
	fi

	for user in "$@"; do

		local request_url="https://api.github.com/users/$user/repos"
		local request_result="$(curl -s "$request_url")"
		local result_size="${#request_result}"

		if [[ "$result_size" == 4 ]]; then
			if [[ ! "quiet" ]]; then
				echoerr "The user \"$user\" don't have any repository."
			fi

		elif [[ "$result_size" == 116 ]]; then
			if [[ ! "quiet" ]]; then
				echoerr "The user \"$user\" was not found."
			fi

		elif [[ "$result_size" == 257 ]]; then
			# Api uses limit reached, should i request to the HTML page?
			if [[ ! "quiet" ]]; then
				echoerr "You exceeded the api consume limit of 60 uses per hour :("
				exit 1
			fi

		else
			if [[ "$ssh" ]]; then
				echo $request_result \
					| grep -oE "git@[^:]+:[^/]+/[^\.]+\.git"

			elif [[ "$http" ]]; then
				echo $request_result \
					| grep -oE "git@[^:]+:[^/]+/[^\.]+\.git" \
					| sed "s/\.git//g" \
					| sed -r "s/git@[^:]+:/https:\/\/github.com\//g"

			else
				echo $request_result \
					| grep -oE "git@[^:]+:[^/]+/[^\.]+\.git" \
					| sed -r "s/(git@[^:]+:|\.git)//g"
			fi
		fi

		[[ ! "$quiet" ]] && echo
	done
}
