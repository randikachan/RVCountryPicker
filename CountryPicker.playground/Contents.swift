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
    var countryListReady: Bool
    // Some countries have to be omitted because they don't have Flags
    var ommitedCountriesArr: [String] = []
    
    init() {
        self.countryListReady = false
        self.ommitedCountriesArr = self.readFromJSON(fileName: "ommitedCountries")
    }
    
    func getCountries() -> [Country] {
        var countries: [Country] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Error: Country not found for code: \(code)"
            
            // Check if the country should be omitted
            if self.ommitedCountriesArr.contains(name) {
                continue;
                // else add it to the final result list
            } else {
                let country = Country(countryCode: code, name: name, localeId: id)
                
                // Check if the image file name is available
                if country.flagImage != nil {
                    countries.append(country)
                } else {
                    print("Error: Couldn't find a Flag Image for the Country: \(name)")
                }
            }
        }
        
        // Sort countries array in Alphabetical order
        countries = countries.sorted(by: {$0.name < $1.name})

        // Add index according to the sorted array positioning
        var flagIndex: Int = 0
        for country in countries {
            country.index = flagIndex
            flagIndex += 1
        }
        return countries
    }
    
    func processCountriesList() -> ProcessCountryListOperation {
        return ProcessCountryListOperation(countryManager: self)
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

class ProcessCountryListOperation: Operation {
    var countries: [Country]
    let countryListManager: CountryManager
    
    init(countryManager: CountryManager) {
        self.countries = []
        self.countryListManager = countryManager
        
        super.init()
        self.qualityOfService = .background
        self.queuePriority = .veryHigh
    }
    
    override func main() {
        if isCancelled {
            return
        }
        
        if !self.countryListManager.countryListReady {
            countries = self.countryListManager.getCountries()
            self.countryListManager.countryListReady = true
        } else {
            return
        }
    }
}

protocol CountryPickerTableViewControllerDelegate: class {
    func didSelectCountry(country: Country?)
}

class CountryPickerTableViewController : UITableViewController {
    
    weak var delegate: CountryPickerTableViewControllerDelegate?
    
    let countriesObj = CountryManager()
    var countriesArr: [Country] = []
    
    override func viewDidLoad() {
        print("ViewDidLoad")
//        self.countriesArr = countriesObj.getCountries()
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        self.view.bringSubview(toFront: activityIndicator)
        let processCountriesListOp = self.countriesObj.processCountriesList()

        processCountriesListOp.completionBlock = {
            self.countriesArr = processCountriesListOp.countries
            
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                
                self.tableView.reloadData()
            }
        }
        
        let queue = OperationQueue()
        queue.addOperation(processCountriesListOp)
        
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
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

let tableViewController = CountryPickerTableViewController(style: .plain)

let navigationController = UINavigationController()

class HomeViewController : UIViewController, CountryPickerTableViewControllerDelegate {
    
    var countryTxtFld: UITextField = UITextField()
    
    override func viewDidLoad() {
        
        var countryTxtFldLbl: UILabel = UILabel(frame: CGRect(x: 25, y: 55, width: 300, height: 40))
        countryTxtFldLbl.text = "Pick your country"
        countryTxtFldLbl.textColor = #colorLiteral(red: 0.4980392157, green: 0.2509803922, blue: 0.2431372549, alpha: 1)
        view.addSubview(countryTxtFldLbl)
        
        countryTxtFld = UITextField(frame: CGRect(x: 25, y: 95, width: 300, height: 40))
        countryTxtFld.backgroundColor = #colorLiteral(red: 0.9745097756, green: 0.4546509981, blue: 0.4343925714, alpha: 1)
        countryTxtFld.delegate = self
        view.addSubview(countryTxtFld)
        
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func didSelectCountry(country: Country?) {
        print("Selected Country: \(country!.name) | Index: \(country!.index)")
        self.countryTxtFld.text = country!.name
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

