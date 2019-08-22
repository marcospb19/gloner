# parse.sh

# Only receives one string variable starting with a hyphen
# representing a flag (Example: --help or -h)
function parse_flags()
{
	local input="$1"

	if [[ "${input:1:1}" == "-" ]]; then
		# If second character is also a hyphen
		# Example: --help

		local arg="${input:2}"

		case "$arg" in

			help)    show_help    ; exit 0 ;;
			version) show_version ; exit 0 ;;

			recursive) recursive="true" ;;
			verbose)   verbose="true"   ;;
			quiet)     quiet="true"     ;;
			http*)     http="true"      ;;
			ssh)       ssh="true"       ;;

			*) echoerr "Option '--$arg' not recognized, see gloner --help."
				exit 1 ;;
		esac
	else
		# Only first character is a hyphen
		# Example -h
		local size="${#1}"
		local arg=""

		# For each letter after the hyphen, process the flags
		# Example: "-hv", process flags 'h' and 'v'
		for (( i = 1 ; i < $size ; i++ )); do
			arg="${input:$i:1}"

			case "$arg" in
				h) show_help    ; exit 0 ;;
				V) show_version ; exit 0 ;;

				R) recursive="true" ;;
				v) verbose="true"   ;;
				q) quiet="true"     ;;

				*) echoerr "Unknown option '-$arg', see gloner --help."
					exit 1 ;;
			esac

		done
	fi
}

# Receives all arguments passed to gloner and filter flags
# Returns $arguments, $number_of_arguments and $command
function parse_arguments()
{
	# Temporary variable, will transfer to $arguments at the end
	local args=()

	for i in "$@"; do
		# Check if first character is a hyphen
		if [[ "${i:0:1}" == "-" ]]; then
			parse_flags "$i"
		else
			args+=("$i")
		fi
	done

	number_of_arguments="${#args[@]}"

	# If no command is given
	if [[ "$number_of_arguments" == 0 ]]; then
		echoerr "No command given."
		show_help
		exit 1
	fi

	# Pop first argument from $args to $command
	command="${args[0]}"
	arguments=("${args[@]:1}")
}
