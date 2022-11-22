IFS=$'\n' read -d '' -r -a filename < /bin/bash
echo "${filename[@]}"
