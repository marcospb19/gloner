# parse.sh

# Only receives one string variable starting with a hyphen
function parse_flags()
{
	# If second character is also a hyphen
	# Example: --help
	if [[ "${1:1:1}" ]]; then

	else
	# Only first character is a hyphen
	# Example -h
		local size="${#var}"
		local arg=""
		for (( i = 1 ; i < $size ; i++ )); do
			arg="${var:$i:1}"

			case "$arg" in
				# h) show_help
					# exit 0 ;;
				*) echo "Option '-$arg' not recognized, see gloner --help."
					exit 1 ;;
			esac

		done
	fi
}

# Receives all arguments passed to gloner
function parse_arguments()
{
	arguments=$()
	for i in "$@"; do
		# Check if first character is a hyphen
		if [[ "${i:0:1}" == "-" ]]; then
			parse_flags "$i"

		# else
			# append arguments...

		fi
	done
}
