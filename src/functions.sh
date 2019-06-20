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

function show_help()
{
	echo "Usage: gloner [-h | --help] [-V | --version] [-v | --verbose]"
	echo
	echo "Use command help command and flags description:"
	echo "    gloner help [Command]"
	echo
	echo "Commands:"

	# echo "          help  <Command>
	# echo "          clone <User> [Repository] [Target]
}

function help_command()
{
	echo "This is the help command, it's pending."
	# Show described information about each command, shown when
	# gloner help <Command>

	# Format for later Usage: "gloner [Command_Here!!] [Args...]"
	# Use this format for all the help command descriptions

	# Is typed, and also when a bad usage is detected from a known command
	exit 0
}
