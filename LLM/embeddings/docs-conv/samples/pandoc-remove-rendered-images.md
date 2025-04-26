
## Remove images in pandoc output (html -> txt) with .lua filters
-------------------------------------------------------------------
Pandoc allows you to apply Lua filters to modify the document's abstract syntax tree (AST) during conversion. By creating a Lua filter that removes all image elements, you can ensure that no embedded images are included in the output.
Modify a pandoc conversion command to include the --lua-filter option, specifying the path to a local $.lua$ file with filters for supressing rendered images (in the html input) on the $.txt$ output.

### Example Use
-----------------------
1. create a lua file in the root folder (where a source and destination html -> txt folders), for the lua exception rules. For example $remove-images.lua$.
2. populate the file with according lua exception rules for rendered images in the html file(s). Model in
[remove-images.lua](./remove-images.lua)  

4. execute this code in the same folder (with a source and destination html -> txt folders)
```
  find ./htmls/ -name "*.html" -exec sh -c '
  pandoc "$0" --lua-filter=remove-images.lua -o "./txt/$(basename "${0%.html}.txt")"
' {} \;
```


### Sample files
-------------------------
- remove-images.lua

### Sources
-------------

- https://pandoc.org/lua-filters.html
- https://exchangetuts.com/pandoc-html-to-markdown-remove-all-attributes-1640770143836173
- https://lanceleonard.com/tips/doc/pandoc/
- https://github.com/jgm/pandoc/issues/4543
- https://pandoc.org/filters.html
- https://stackoverflow.com/questions/39956497/pandoc-convert-docx-to-markdown-with-embedded-images
- https://stackoverflow.com/questions/42070656/pandoc-html-to-markdown-remove-all-attributes
- https://stackoverflow.com/questions/63220021/can-one-extract-images-from-pandocs-self-contained-html-files
- https://stackoverflow.com/questions/41903398/how-to-avoid-img-size-tags-on-markdown-when-converting-docx-to-markdown
- https://stackoverflow.com/questions/74759201/disable-pandoc-convert-the-image-s-alt-text-to-a-paragraph-when-docx-to-markdown
