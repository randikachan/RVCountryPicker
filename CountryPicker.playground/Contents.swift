//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class Country {
    var isoCountryCode: String = ""
    var name: String = ""
    var localeId: String = ""
    var index: Int = -1
    var flagImageName: String? {
        get {
            let imageName = name.replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: "’", with: "")
                .lowercased()
            
            return imageName
        }
        set {
        }
    }
    var flagImage: UIImage? {
        get {
            return UIImage(named: flagImageName!)
        }
        set {
        }
    }
    
    init(countryCode: String, name: String, localeId: String) {
        self.isoCountryCode = countryCode
        self.name = name
        self.localeId = localeId
    }
}

class CountryManager {
    
    // Some countries have to be omitted because they don't have Flags
    var ommitedCountriesArr: [String] = []
    
    init() {
        self.ommitedCountriesArr = self.readFromJSON(fileName: "ommitedCountries")
    }
    
    func getCountries() -> [Country] {
        var countries: [Country] = []
        var result: [Country] = []
        
        var flagIndex: Int = 0
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            
            if self.ommitedCountriesArr.contains(name) {
                continue;
            } else {
                let country = Country(countryCode: code, name: name, localeId: id)
                if country.flagImage != nil {
                    flagIndex += 1
                    countries.append(country)
                } else {
                    print(name)
                }
            }
        }
        
        countries = countries.sorted(by: {$0.name < $1.name})
        
        flagIndex = 0
        for country in countries {
            flagIndex += 1
            country.index = flagIndex
            result.append(country)
        }
        return countries
    }
    
    func readFromJSON(fileName: String) -> [String] {
        let fileURL = Bundle.main.url(forResource: "omittedCountries", withExtension: "json")
        let content = try? Data(contentsOf: fileURL!)
        
        if content != nil {
            do {
                let json = try JSONSerialization.jsonObject(with: content!, options: []) as! [String: [String]]
                
                return json["omittedCountries"]!
            } catch let error as NSError {
                //handle error
                print(error.localizedDescription)
                return []
            }
        }
        
        return []
    }
}
//
//let countryManager = CountryManager()

//let countries = countryManager.getCountries()

//SL.index
//SL.name
//SL.flagImageName
//SL.flagImage

protocol CountryPickerTableViewControllerDelegate: class {
    func didSelectCountry(country: Country?)
}

class CountryPickerTableViewController : UITableViewController {
    
    weak var delegate: CountryPickerTableViewControllerDelegate?
    
    let countriesObj = CountryManager()
    var countriesArr: [Country] = []
    
    override func viewDidLoad() {
        self.countriesArr = countriesObj.getCountries()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let country: Country = self.countriesArr[indexPath.row]
        cell.textLabel?.text = country.name
        cell.imageView?.image = country.flagImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please select the country you live in"
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country = self.countriesArr[indexPath.row]
        print("\(selectedCountry.name)")
        delegate?.didSelectCountry(country: selectedCountry)
    }
    
}

let tableViewController = CountryPickerTableViewController(style: .plain)

let navigationController = UINavigationController()

class HomeViewController : UIViewController, CountryPickerTableViewControllerDelegate {
    
    override func viewDidLoad() {
        
        let countryTxtFldLbl: UILabel = UILabel(frame: CGRect(x: 25, y: 55, width: 300, height: 40))
        countryTxtFldLbl.text = "Pick your country"
        countryTxtFldLbl.textColor = #colorLiteral(red: 0.4980392157, green: 0.2509803922, blue: 0.2431372549, alpha: 1)
        view.addSubview(countryTxtFldLbl)
        
        let countryTxtFld: UITextField = UITextField(frame: CGRect(x: 25, y: 95, width: 300, height: 40))
        countryTxtFld.backgroundColor = #colorLiteral(red: 0.9745097756, green: 0.4546509981, blue: 0.4343925714, alpha: 1)
        countryTxtFld.delegate = self
        view.addSubview(countryTxtFld)
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func didSelectCountry(country: Country?) {
        print("Selected Country: \(country!.name)")
    }
}

extension HomeViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        tableViewController.delegate = self
        navigationController?.pushViewController(tableViewController, animated: true)
        print("Editing")
    }
}


let homeViewController = HomeViewController()
navigationController.pushViewController(homeViewController, animated: true)

PlaygroundPage.current.liveView = navigationController


