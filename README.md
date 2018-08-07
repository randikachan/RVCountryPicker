# RVCountryPicker iOS Swift library

Country Picker with flag images for iOS iPhone Apps, written in Swift. Currently supports 225 countries, for the ISO country codes which is found within `NSLocale.isoCountryCodes` API.

<p align="center">
<img src="https://i.imgur.com/1gnTA4z.png" width="2000" height="550" alt="Real Device iPhone6S Vs iPhone6S Simulator"/><br/>
<span> Screenshots of the demo app to show the methods </span>
</p>
</p>

### Latest Version 1.2.5

## Features

* You can easily get an array of Country Objects which includes following attributes per country object instance
	* Index in alphabetical order (0 - 225)
	* Country Name (Ex. Sri Lanka)
	* ISO Country Code (Ex. for Sri Lanka - LK)
 	* Locale ID for the country (Ex. for Sri Lanka - _LK)
 	* Flag Image Name (corresponding flag image name out of the 226 image files included within the library)
* You can integrate above `CountryPickerTableViewController` with 5 lines of code (see bellow steps)

### Development Road Map

* DisplayOnlyCountriesArr
* ShowExceptCountriesArr
* Search Bar and enableSearchBar
* Indexed Scroll Bar implementation and enableIndexedScrollBar
* CountryPickerGridViewController & CountryPickerGridView
* Flag images optimization
* iOS Default Picker view customization along with a searchbar
* UI Theming options


## Installation Guide
### Use CocoaPods
[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:


```bash
$ gem install cocoapods
```

To integrate **CountryPicker** into your Xcode project using CocoaPods, specify it in your Podfile as follows:

You can add pod 'RVCountryPicker', '~> 1.2.5' similar to the following to your Podfile:

```ruby
target '<Your App Target Name>' do
  pod 'RVCountryPicker', '~> 1.2.5'
end
```

Then run a `pod install` inside your terminal, or from [CocoaPods.app](https://cocoapods.org/app).

## How to use
In your `AppDelegate.swift` file, import the `CountryPicker` library as follows:

```ruby
import RVCountryPicker
```

And then initiate the `CountryListManager` instance as follows, within the `application(_ application: didFinishLaunchingWithOptions:` method.

```ruby
let countryListManager = CountryListManager.shared
countryListManager.processCountriesList(countryListManager: countryListManager)
```

Then you can initiate the `CountryPickerTableViewController` and push it into the `UINavigationController` view controllers stack as follows:

```ruby
import UIKit
import RVCountryPicker

class ViewController: UIViewController {

    let tableViewController = CountryPickerTableViewController(style: .plain)
    
    override func viewDidLoad() {
	    super.viewDidLoad()
	
	    // CountryPickerTableViewDelegate
	    tableViewController.delegate = self
        
        // TextFieldDelegate
        countryTxtFld.delegate = self
        
        // fetch a list of countries
        let countryListManager = CountryListManager.shared
        let countriesArr = countryListManager.countries
        print("Countries: \(String(describing: countriesArr))")
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    	 // let's keep the keyboard hidden always for this demo's purpose
        textField.resignFirstResponder()
        
        // push our CountryPickerTableViewController
        self.navigationController?.pushViewController(tableViewController, animated: true)
        
        // Or, you can modally push the CountryPickerTableViewController (as it suites for your application), if so you have to change the presentationMethod to Modal as follows, so it knows how to dismiss it
        tableViewController.presentationMethod = .MODAL
        
        // Then present it
        self.present(tableViewController, animated: true, completion: nil)
    }
}

extension ViewController: CountryPickerTableViewControllerDelegate {
    
    func didSelectCountry(country: Country?) {
        if country != nil {
            self.countryTxtFld.text = country?.name
            self.countryFlagImgVw.image = country?.flagImage
            self.countryCodeLbl.text = "ISO Country Code: \(country!.isoCountryCode)"
        }
    }
}
```
Remember you definitely will have to implement the `CountryPickerTableViewControllerDelegate` protocol's `didSelectCountry(country:)` method, in order to receive the selected Country row related information as a Country object. (check the last extension in the given example)

### Q: Why you should use this? 
**A:** Because, you shouldn't bother and spend time on re-inventing the wheel again, even though you could and you are smart. And CountryPicker iOS Swift library is much lightweight and much flexible just like a piece of clay where you can play with and build up to any purpose you like.

#### Note:
    - If you found anything wrong which I have done or may be a bug or any improvements suggestion, please help me to improve this codebase.
    - You can always add up your valuable utility methods to this class which is related to the purpose of this library.
    - Don't forget to check out the Demo project simple implementation to get some more ideas.

Flag Images Credit:
[Flag images were designed by Freepik from Flaticon](https://www.flaticon.com/authors/freepik)

## License
This source code is made available under the MIT License.

```sh
Copyright (c) 2018 Randika Vishman

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
