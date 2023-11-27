# doc2comment.sh

## Introduction

This script is designed to extract comments from Word and LibreOffice documents, and format them in a .md file, with the date of the day and the name of the original document as a filename.

Running the script...
```bash
./doc2comment.sh your_document.docx
```
...gives you:
```bash
/your/folder/of/choice/2023-11-22_2311_your_document.md
#The comments you've made in your_document.docx will be listed in this .md file
```

I regularly review both DOCX and ODT files, and make numerous comments within those documents. However, it's a pain to keep track of these comments and use them for future reference. 
This script simplifies and automates the process of extracting comments from DOCX and ODT documents. Organizing them into a single Markdown file per document, it's then way easier to revisit them later.

## Features

- **Compatibility:** The script supports both DOCX and ODT file formats.
- **Automatic Processing:** It automatically identifies the document type and extracts comments accordingly.
- **Markdown Output:** The extracted comments are formatted into Markdown files, providing a clean and readable output. There is a little bit of tidying up to do, although it's really minimal.
- **Custom Output Folder:** You can specify the output folder to organize and store your extracted comment Markdown files.

## How to Use

1. **Download the Script:** Obtain the script file named `doc2comment.sh`.

2. **Make it Executable:** Run the following command in your terminal to make the script executable:
    ```bash
    chmod +x doc2comment.sh
    ```

3. **Run the Script:** Execute the script by providing the path to your document file as an argument. For example:
    ```bash
    ./doc2comment.sh your_document.docx
    ```

4. **Output Folder:** The script will generate a Markdown file with extracted comments and move it to the specified output folder. Adjust the `output_folder` variable in the script to set your desired location.

## Additionnal notes

- This script is designed to be non-destructive. It only extracts information and does not modify your original documents.
- The script creates a temporary folder during processing, which is removed after extracting comments. Only the output Markdown file is preserved.
