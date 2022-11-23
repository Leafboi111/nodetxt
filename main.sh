clear
cd docs

str1="Back"
str2="Add_file"
str3="Remove_file/directory"
str4="Add_directory"
str5="Go_to_directory"
filename=""
filearr=()

function addfile {
  read -p "Name of file: " filename
  touch $filename
}

function removefile {
  read -p "Name of file: " filename
  rm -rf $filename
}

function addirectory {
  read -p "Name of directory: " dirname
  mkdir $dirname
}

function gotodirectory {
  read -p "Name of directory: " cddir
   cd $cddir
}

function selectfile {

  while true
  do
    teststr="$str1 $str2 $str3 $str4 $str5 $("ls")"
    clear
    select input in $teststr
    do
      if [ "$input" == "Back" ];
      then
        cd ..
      elif [ "$input" == "Add_file" ];
      then
        addfile
      elif [ "$input" == "Remove_file/directory" ];
      then
        removefile
      elif [ "$input" == "Add_directory" ];
      then
        addirectory
      elif [ "$input" == "Go_to_directory" ];
      then
        gotodirectory
      else
        filename="$input";
        return 0
      fi
      break
    done
  done
}

function readfile {

  x=0

  while read -r line || [[ -n "$line" ]]; do
    filearr[x]=$line
    let x++
  done <$filename

}

function editfile {
  while true
  do
    clear
    cat -n $filename; echo
    read -p "add, replace or remove line or press enter to exit: "  addrm
    if [ "$addrm" == "add" ];
    then
      read -p "Contents of file: " contents
      echo $contents >> $filename
    elif [ "$addrm" == "replace" ];
    then
      read -p "Line Number: " lnn
      read -p "Contents of file: " contents
      filearr[(($lnn-1))]=$contents
      printf "%s\n" "${filearr[@]}" > $filename
    elif [ "$addrm" == "remove" ];
    then
      sed -i '$d' $filename
    else
      return 0
    fi
  done
}

tput setaf 214
selectfile
readfile
tput setaf 39
editfile
for value in "${filearr[@]}"; do echo "$value" >> $filename; done
