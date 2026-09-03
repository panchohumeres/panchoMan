# Graphical Interface for RClone[](https://doc.cc.in2p3.fr/en/Software/rclone-gui.html#graphical-interface-for-rclone "Link to this heading")

**Sources**:
	- https://doc.cc.in2p3.fr/en/Software/rclone-gui.html

## Native Web Interface

RClone install includes a native web interface. 

### Launching the Web Interface

Once RClone is [installed and configured](https://doc.cc.in2p3.fr/en/Software/rclone.html#rclone), run in your terminal:

rclone rcd --rc-web-gui

- This command will automatically download the required files from GitHub.
    
- The interface opens in your default browser at `http://127.0.0.1:5572`
    
- The first launch may take a few seconds as the files are downloaded.


### RClone UI
Independent project for desktop UI on top of rclone install (not rclone official GUI)
- https://github.com/rclone-ui/rclone-ui
- https://rcloneui.com/docs/ui/setup
- https://rcloneui.com/
