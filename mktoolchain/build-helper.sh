require() {
	if [ "${1: -3}" = ".so" ]; then
		ldconfig -p | grep "${1: 0:-3}" > /dev/null
	else
		which $1 &> /dev/null
	fi

	if [ $? = 0 ]; then
		printf "[\e[95;1mDEPS\e[0m] Found $1\n"
	else
		printf "[\e[91;1mFAIL\e[0m] \e[31mDependency not found: $1 (fatal)\e[0m\n"
		exit 1
	fi
}

download() {
	local target=$(basename $1)

	printf "[\e[93;1mWAIT\e[0m] Download $target\n"
	curl -sL $1 -o $target
	if [ $? = 0 ]; then
		printf "\e[A\e[G\e[2K[\e[92;1mDONE\e[0m] Download $target\n"
	else
		printf "\e[A\e[G\e[2K[\e[91;1mFAIL\e[0m] Download $target\n"
		exit 1
	fi
}

run() {
	local text="$1"
	shift 1

	printf "[\e[33;1mWAIT\e[0m] %s\n" "$text"

	eval -- $@ &> /dev/null
	if [ $? = 0 ]; then
		printf "\e[A\e[G\e[2K[\e[92;1mDONE\e[0m] %s\n" "$text"
	else
		printf "\e[A\e[G\e[2K[\e[91;1mFAIL\e[0m] %s\n" "$text"
		exit 1
	fi
}
