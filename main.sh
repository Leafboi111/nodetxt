clear
cd docs

str1="Back"
str2="Add_file"
str3="Remove_file/directory"
str4="Add_directory"
str5="Go_to_directory"
str6="Edit_file"
filename=""
filearr=()

function addfile {
  read -p "Name of file: " filename
  touch $filename
}

function removefile {
  read -p "Name of file/directory: " filename
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


function gotofile {
  read -p "Name of file: " filename
   cd $cddir
}

function selectfile {

  while true
  do
    teststr="$str1 $str2 $str3 $str4 $str5 $str6"
    clear
    tput setaf 7
    echo "Welcome to nodetxt! Select the file to edit over here."; echo
    tput setaf 214
    echo "Files/Directories:"
    ls
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
        gotofile
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
    printf '%s\n' "${filearr[@]}"; echo
    read -p "add, replace or remove line or press enter to exit: "  addrm
    
    if [ "$addrm" == "add" ];
    then
    
      read -p "Contents of file: " contents
      filearr+=($contents)
      
    elif [ "$addrm" == "replace" ];
    then
    
      read -p "Line Number: " lnn
      read -p "Contents of file: " contents
      filearr[(($lnn-1))]=$contents
      printf "%s\n" "${filearr[@]}" > $filename
      
    elif [ "$addrm" == "remove" ];
    then
    
      unset filearr[-1]
      
    else
      return 0
    fi
    
  done
}

selectfile
readfile
tput setaf 39
editfile

rm $filename
touch $filename
for value in "${filearr[@]}"; do echo "$value" >> $filename; done
