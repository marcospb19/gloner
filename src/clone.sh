# clone.sh

function clone_repository()
{
	if [[ "$#" == 0 ]]; then
		echoerr "No arguments given."
		exit 1

	elif [[ "$#" != 2 && "$#" != 3 ]]; then
		echoerr "gloner clone: expected 1 or 2 arguments, but received $(( $# - 1 ))."
		exit 1
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
	elif [[ ! "$http" || "$ssh" == "true" ]]; then
		clone_url="git@github.com:$user/$repository.git"

	# Else, http was chosen
	else
		clone_url="https://github.com/$user/$repository"
	fi

	clone_url="https://github.com/$user/$repository"

	# Optional flags
	local flag_R # Empty
	local flag_v # Empty
	[[ "$recursive" == "true" ]] &&	flag_R="--recursive"
	[[ "$verbose"   == "true" ]] &&	flag_v="--verbose"

	# Echo
	echo "git clone $clone_url $target $flag_R $flag_v"

	# Run
	git clone "$clone_url" $target $flag_R $flag_v
	# Note: optional arguments cannot be quoted
}
