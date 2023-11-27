#!/bin/bash

# Check if a document file is provided as an argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <document_file>"
  exit 1
fi

# Assign the document file path to a variable
document_file="$1"

# Create a temporary folder
temp_folder=$(mktemp -d)

# Function to process docx files
process_docx() {
  # Find and extract comment text from comments.xml

  comment_text=$(grep -oP '<w:t>[^<]*</w:t>' "$temp_folder/word/comments.xml" | sed 's/<[^>]*>//g' | tr -d '\n')

  # Generate a Markdown file with the comment text. Theoretically you could just change .md to .txt I your use case isn't to use markdown
  output_file="$(date +'%Y-%m-%d_%H%M')_$(basename "${document_file%.*}").md"
  echo "$comment_text" > "$output_file"

  # Specify the output folder (modify this to your desired folder)
  output_folder="/the/folder/of/your/choice"

  # Move the Markdown file to the specified output folder
  mv "$output_file" "$output_folder"

  # Inform that the process is done and where the file is located
  echo "Completed successfully. Markdown file is located at: $output_folder/$output_file"
}

# Function to process odt files
process_odt() {
  # Find and extract comment text from content.xml
  comment_text=$(grep -oP '<office:annotation[^>]*>\K.*?(?=<\/text:p><\/office:annotation>)' "$temp_folder/content.xml")

  # Clean up the comment text
  cleaned_comment=$(echo "$comment_text" | sed -E 's/<dc:creator>.*?<\/dc:creator><dc:date>.*?<\/dc:date><meta:creator-initials>.*?<\/meta:creator-initials><text:p[^>]*><text:span[^>]*>//g; s/<\/text:span><\/text:p>//g; s/<[^>]+>//g')

  # Generate a Markdown file with the cleaned comment text
  output_file="$(date +'%Y-%m-%d_%H%M')_$(basename "${document_file%.*}").md"
  echo "$cleaned_comment" > "$output_file"

  # Specify the output folder (modify this to your desired folder)
  output_folder="/the/folder/of/your/choice"

  # Move the Markdown file to the specified output folder
  mv "$output_file" "$output_folder"

  # Inform that the process is done and where the file is located
  echo "Completed successfully. Markdown file is located at: $output_folder/$output_file"

}

# Check the file extension to determine the type
file_extension="${document_file##*.}"

# Unzip the document file to the temporary folder
case "$file_extension" in
  "docx")
    unzip "$document_file" -d "$temp_folder" >/dev/null
    process_docx
    ;;
  "odt")
    unzip "$document_file" -d "$temp_folder" >/dev/null
    process_odt
    ;;
  *)
    echo "Unsupported file format. Supported formats: docx, odt"
    exit 1
    ;;
esac

# Clean up temporary files
rm -rf "$temp_folder"
