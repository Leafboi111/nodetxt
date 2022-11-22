read -p "Hello" filename
IFS=$'\n' read -d '' -r -a filename < /bin/bash
echo "${filename[@]}"
