Using pandoc and specifying an output directory: 
* convert all .html files in a source directory (```/path/to/source/```) and save the .txt files to a target directory (```sudo apt install pandoc
/path/to/target/```).
```
sudo apt install pandoc #install pandoc
find /path/to/source -name "*.html" -exec sh -c 'pandoc "$0" -o "/path/to/target/$(basename "${0%.html}.txt")"' {} \; 
```
**Explanation**:
find ```/path/to/source -name "*.html"```: Finds all ```.html``` files in the ```/path/to/source directory```.

basename ```"${0%.html}.txt"```: Extracts the filename (without the ```.html``` extension) and appends ```.txt``` to create the target filename.

pandoc ```"$0" -o "/path/to/target/$(basename "${0%.html}.txt")"```: Converts each HTML file to .txt and saves it to the ```/path/to/target/ directory```.
