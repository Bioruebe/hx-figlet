bktree (Haxe Library)
=====================

A haxe implementation of a FIGdriver, used to parse FIGlet fonts and return the formatted text. Based on the javascript version  [figlet-js by Scott González](https://github.com/scottgonzalez/figlet-js)


Installation
-------

`haxelib install figlet`


Usage
-----

```haxe
import sys.io.File;

class Main {
	static function main() {
		trace(FIGlet.write("FIGlet", File.getContent("../standard.flf")));
/*		  _____   ___    ____   _          _
		 |  ___| |_ _|  / ___| | |   ___  | |_
		 | |_     | |  | |  _  | |  / _ \ | __|
		 |  _|    | |  | |_| | | | |  __/ | |_
		 |_|     |___|  \____| |_|  \___|  \__|
*/
	}
}
```
