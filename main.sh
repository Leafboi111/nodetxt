read -p "Hello" filename
IFS=$'\n' read -d '' -r -a filecontents < filename
echo "${filecontents[@]}"
