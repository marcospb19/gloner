# functions.sh

# Enable aliases in the script
shopt -s expand_aliases

# echo to the stderr
alias echoerr="echo >&2"

function show_version()
{
	echo "gloner v0.0."
	echo "Licensed under MIT."
	echo "From https://github.com/marcospb19/gloner, feel free to report your"
	echo "issues and feature requests, as well as contributing in other ways :)"
}
