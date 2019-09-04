# common.sh

# Enable aliases in the script
shopt -s expand_aliases

# echo to the stderr
alias echoerr="echo >&2"

function show_version()
{
	cat <<- EOT

	          __
	    ___ _/ /__  ___  ___ ____
	   / _ \`/ / _ \/ _ \/ -_) __/
	   \_, /_/\___/_//_/\__/_/     v$version
	  /___/


	  Licensed under MIT.

	  From https://github.com/marcospb19/gloner, feel free to report your
	  issues and feature requests, as well as contributing in any other ways :]

	EOT
}
