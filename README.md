# countrypicker-ios-swift

Country Picker with flags for iOS iPhone Apps, written in Swift. Currently support 226 countries.

<p align="center">
<img src="https://i.imgur.com/1gnTA4z.png" width="2000" height="550" alt="Real Device iPhone6S Vs iPhone6S Simulator"/><br/>
<span> Screenshots of the demo app to show the methods </span>
</p>
</p>

## Features

* You can easily get an array of Country Objects which includes following attributes per country object instance
	* Index in alphabetical order (0 - 225)
	* Country Name,
	* ISO Country Code (Ex. for Sri Lanka - LK)
 	* Locale ID for the country (Ex. for Sri Lanka - _LK)
 	* Flag Image Name (out of the 226 flags images files included within the library)
* You can integrate above CountryPickerTableViewController with 5 lines of code (see bellow steps)

##Installation
###CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:


```bash
$ gem install cocoapods
```

To integrate **CountryPicker** into your Xcode project using CocoaPods, specify it in your Podfile as follows:

You want to add pod 'countrypicker-ios-swift', '~> 1.2' similar to the following to your Podfile:

```ruby
target '<Your App Target Name>' do
  pod 'countrypicker-ios-swift', '~> 1.2'
end
```

Then run a `pod install` inside your terminal, or from [CocoaPods.app](https://cocoapods.org/app).

##### Q: Why you should use this? 
**A:** Because, you shouldn't bother and spend time on re-inventing the wheel again, even though you could and you are smart. And CountryPicker iOS Swift library is much lightweight and much flexible just like a piece of clay where you can play with and build up to any purpose you like.

## Development Road Map
* DisplayOnlyCountriesArr
* ShowExceptCountriesArr
* Search Bar and enableSearchBar
* Indexed Scroll Bar implementation and enableIndexedScrollBar
* CountryPickerGridViewController & CountryPickerGridView
* Flag images optimization
* iOS Default Picker view customization along with a searchbar
* UI Theming options

#### Note:
    - If you found anything wrong which I have done or may be a bug or any improvements suggestion, please help me to improve this codebase.
    - You can always add up your valuable utility methods to this class which is related to the purpose of this library.
    - Don't forget to check out the Demo project simple implementation to get some more ideas.


## License
This source code is made available under the MIT License.

```sh
Copyright (c) 2016 Kasun Randika

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
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
IN THE SOFTWARE.
```
