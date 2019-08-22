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
