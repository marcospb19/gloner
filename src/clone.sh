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

	clone_url="https://github.com/$user/$repository"

	# Flags can't be quoted here, because they're optional
	echo "git clone $clone_url $target $flagR $flagv"
	git clone $clone_url $target $flagR $flagv
}
