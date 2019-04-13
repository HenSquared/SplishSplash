# SplishSplash

SplishSplash is an unofficial iOS client for Unsplash. 

## Installation

 1. Clone the repository

``` 
git clone https://github.com/VidaHasan/SplishSplash

```
2. Install pods  with <code>pod install </code>
3. Open the project using <code>.xcworkspace</code> file
4. Add API Key


### Adding your API Key
Create a file named <code> ApiKeys.plist </code>in the same directory as Info.plist with the following code
```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>API_CLIENT_ID</key>
	<string>SOME_KEY</string>
</dict>
</plist>
```
Replace "SOME_KEY" with your unsplash API Key.

The application will automatically use this value in requests that require an API Key. 



## Screenshots
![Alt Text](https://i.ibb.co/WFf0P1W/demo.gif)
![alt text](https://i.imgur.com/nzZx9Ln.jpg "Main page screenshot")
![alt text](https://i.imgur.com/1PMss8e.jpg "preview wallpaper page screenshot")
![alt text](https://i.imgur.com/1PMss8e.jpg "preview wallpaper page screenshot")


## Thank you
[Brandon Lam](https://b-lam.github.io/) - Developer of [Resplash](https://github.com/b-lam/Resplash), for allowing me to copy his application design. 

[/r/iOSProgramming](https://reddit.com/r/iosprogramming) for lots of support in my learning journey. 

[Maxim Skryabin](https://github.com/moridaffy/) for screenshots and source code which enabled the "Preview as Wallpaper" feature. 

## Contributing
SplishSplash is not looking for code contributions. However, if you're interested in critiquing source code, you can message me or open a PR with your comments. Critiques would be appreciated.

## Other notes
SplishSplash was denied an API limit increase which prevents the application from being released on the app store. Because of this, there is no longer any work planned for SplishSplash. 

## License
MIT License

Copyright (c) 2017 Brandon Lam

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.