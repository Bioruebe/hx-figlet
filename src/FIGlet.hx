/*
Copyright (c) 2010 Scott González http://github.com/scottgonzalez/figlet-js

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

package;
using StringTools;

/**
 * A haxe implementation of a FIGdriver, based on the javascript version figlet-js from
 * https://github.com/scottgonzalez/figlet-js
 * 
 * @author Bioruebe
 */
class FIGlet {
	public static var font:FIGletFont;
	
	/**
	 * Format given string with the font passed as parameter fontDefinition
	 * 
	 * The definition must be passed as a string, file names are not supported. Use File.GetContent("folt.flf") to read the font file 
	 * or take advantage of haxe's macro system to read it at compile time and include it as a string.
	 * 
	 * The font definition has to be passed only once, subsequent calls use the last loaded font.
	 * If the first call omits the fontDefinition parameter, an exception is thrown.
	 * 
	 * @param	string
	 * @param	fontDefinition
	 */
	public static function write(string:String, ?fontDefinition:String) {
		if (font == null) {
			if (fontDefinition == null || fontDefinition.indexOf("flf2a") != 0) throw "Invalid font definition, string must start with flf2a";
			parseFont(fontDefinition);
		}
		
		var chars = [], result = "";
		
		for (i in 0...string.length) {
			chars[i] = getChar(string.charCodeAt(i));
		}
		
		for (i in 0...chars[0].length) {
			result += "\n";
			for (j in 0...string.length) {
				result += chars[j][i];
			}
		}
		
		return result;
	}
	
	private static function parseFont(defn:String) {
		var lines = defn.split("\n");
		var header = lines[0].split(" ");
		
		font = {
			defn: lines.slice(Std.parseInt(header[5]) + 1),
			hardblank: header[0].charAt(header[0].length - 1),
			height: Std.parseInt(header[1]),
			char: new Map<Int, Array<String>>()
		};
	}
	
	private static function getChar(char:Int) {
		if (font.char.exists(char)) return font.char.get(char);
		
		var height = font.height, start = (char - 32) * height, charDefn = [];
		
		for (i in 0...height) {
			charDefn[i] = font.defn[start + i].replace("@", "").replace(font.hardblank, " ");
		}
		
		font.char.set(char, charDefn);
		
		return charDefn;
	}
}

typedef FIGletFont = {
	var defn:Array<String>;
	var hardblank:String;
	var height:Int;
	var char:Map<Int, Array<String>>;
}