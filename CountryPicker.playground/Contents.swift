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

class TableViewController : UITableViewController {
    
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
    }
    
}

let tableViewController = TableViewController(style: .plain)

PlaygroundPage.current.liveView = tableViewController


