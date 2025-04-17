#### Using pandoc:
-------------------
pandoc ignores images and other non-text content when converting from HTML to plain text by default, stripping out non-text elements like images, videos, and embedded files, leaving only the plain textual content.

**includes**:
- Textual content: It extracts the text from ```<p>, <h1>, <h2>, <ul>, <ol>, <li>```, and other text-based HTML elements.
- Links: It will convert hyperlinks to plain text, typically by displaying the link's URL.
- Headings: It keeps the headings (like ```<h1>, <h2>```, etc.) and formats them as plain text with appropriate heading markers (e.g., ```#, ##``` for markdown-style headers).
- Formatting: It preserves basic formatting like bold, italic, etc., as textual markers (e.g., ```**bold**, *italic*``` in Markdown format).

**ignores**:
- Images: ```<img>``` tags are ignored, and no image data is copied to the output.
- Embedded media: Non-text content like audio, video, or other multimedia elements are also ignored.
- CSS and JavaScript: Styles and scripts are discarded, so no layout or interactivity is preserved.
-HTML structure: It discards any HTML tags, so no ```<div>, <span>```, or other non-text tags will appear in the output.

**Typical use**
* convert all .html files in a source directory (```/path/to/source/```) and save the ```.txt``` files to a target directory (```sudo apt install pandoc
/path/to/target/```).
```
sudo apt install pandoc #install pandoc
find /path/to/source -name "*.html" -exec sh -c 'pandoc "$0" -o "/path/to/target/$(basename "${0%.html}.txt")"' {} \; 
```
**Explanation**:
find ```/path/to/source -name "*.html"```: Finds all ```.html``` files in the ```/path/to/source directory```.

basename ```"${0%.html}.txt"```: Extracts the filename (without the ```.html``` extension) and appends ```.txt``` to create the target filename.

pandoc ```"$0" -o "/path/to/target/$(basename "${0%.html}.txt")"```: Converts each HTML file to .txt and saves it to the ```/path/to/target/ directory```.

**Sources**:
- https://pandoc.org/
- https://github.com/jgm/pandoc/wiki

#### Using lynx:
-------------------
```
sudo apt install lynx #install lynx
find /path/to/source -name "*.html" -exec sh -c 'lynx -dump "$0" > "/path/to/target/$(basename "${0%.html}.txt")"' {} \;

```
Explanation:
```lynx -dump "$0"```: Converts the HTML file to plain text.

```> "/path/to/target/$(basename "${0%.html}.txt")"```: Redirects the output to a ```.txt``` file in the ```/path/to/target/``` directory, using the same name as the original HTML file.

This will save all the converted ```.txt``` files to ```/path/to/target/```.

#### Optional: Use sed or awk for additional processing
--------------------------------------------------
If you need to further clean the text or remove unwanted tags (e.g., scripts, styles), you can process the output using sed or awk.

For example, to remove extra line breaks or unwanted tags before saving:
```
find /path/to/directory -name "*.html" -exec sh -c 'lynx -dump "$0" | sed "/^$/d" > "${0%.html}.txt"' {} \;

```

