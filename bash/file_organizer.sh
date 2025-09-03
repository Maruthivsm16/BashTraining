#!/bin/bash
target_dir=${1:-.}  # Default to current directory if no argument is provided or if the argument is empty
cd "$target_dir" || exit 1 #if cd cmd fails or  a invalid folder, exit the script with error code 1.
for file in *; do
  if [ -d "$file" ]; then
      continue
  fi
  ext="${file##*.}"  #Removing the prefix from the file name, leaving only the extension.
  ext=$(echo "$ext" | tr '[:upper:]' '[:lower:]')  #Converting the extension to lowercase.
  if [ "$file" = "$ext" ] ; then   #if there is "No extension" it  moves to 'others'
     folder="others"
  else
    case "$ext" in
      jpg|jpeg|png|gif|bmp) folder="images" ;;
      pdf|doc|docx|txt|xls|xlsx|ppt|pptx) folder="documents" ;;
      mp3|wav|flac) folder="music" ;;
      mp4|avi|mkv) folder="videos" ;;
      zip|tar|rar) folder="archives" ;;
      *) folder="$ext" ;;
      esac
    fi
  mkdir -p "$folder"
  mv "$file" "$folder/"
    echo "Moved $file to $folder/"
done
echo "All files have been organized"
      




