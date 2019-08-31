# clone.sh

# Clones a repository just receiving the username and repository name
# Usage: gloner clone <User> <Repository>
function clone_repository()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		show_help_and_exit

	elif [[ "$#" != 2 && "$#" != 3 ]]; then
		echoerr "gloner clone: expected 1 or 2 arguments, but received $(( $# - 1 ))."
		show_help_and_exit
	fi

	local       user="$1"
	local repository="$2"
	local     target="$3"

	# Decide which protocol to use
	local clone_url

	# If cannot use ssh, just use http
	if [[ ! -d "$HOME/.ssh" ]]; then
		clone_url="https://github.com/$user/$repository"

	# If ssh set or http unset, always choose ssh over http
	elif [[ ! "$http" || "$ssh" ]]; then
		clone_url="git@github.com:$user/$repository.git"

	# Else, http was chosen
	else
		clone_url="https://github.com/$user/$repository"
	fi

	# Optional flags
	local flag_R # Empty
	local flag_v # Empty
	[[ "$recursive" ]] && flag_R="--recursive"
	[[ "$verbose"   ]] && flag_v="--verbose"

	# Echo
	echo "git clone $clone_url $target $flag_R $flag_v"

	# Run
	git clone "$clone_url" $target $flag_R $flag_v
	# Note: optional arguments cannot be quoted here
}

# Clones multiple repositories from the same user
# Usage: gloner clonemultiple <User> <Repository1> <Repository2>...
function clone_multiple_repositories()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		show_help_and_exit

	elif [[ "$#" == 1 ]]; then
		echoerr "gloner clonemultiple: expected repository names, but only received the user."
		show_help_and_exit
	fi

	local       user="$1"

	local repositories=()
	for i in ${@:2}; do
		repositories+=("$i")
	done

	# Decide which protocol to use
	local clone_url_base

	# If cannot use ssh, just use http
	if [[ ! -d "$HOME/.ssh" ]]; then
		clone_url_base="https://github.com/$user"

	# If ssh set or http unset, always choose ssh over http
	elif [[ ! $ssh || $http ]]; then
		clone_url_base="git@github.com:$user"

	# Else, http was chosen
	else
		clone_url_base="https://github.com/$user"
	fi

	# Optional flags
	local flag_R # Empty
	local flag_v # Empty
	[[ "$recursive" ]] && flag_R="--recursive"
	[[ "$verbose"   ]] && flag_v="--verbose"

	# Echo
	echo "clone $user [${@:2}] $target $flag_R $flag_v"

	for repo in ${@:2}; do
		git clone "$clone_url_base/$repo" $target $flag_R $flag_v
	done

	# TODO, get the exit code from all the clones, and put it on an list
	# After everything was ran print what repositories reported error when trying to clone
}
