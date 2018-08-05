//
//  ViewController.swift
//  CountryPickerDemo
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit
import CountryPicker

class ViewController: UIViewController {

    let tableViewController = CountryPickerTableViewController(style: .plain)
    
    @IBOutlet weak var countryTxtFld: UITextField!
    @IBOutlet weak var countryFlagImgVw: UIImageView!
    @IBOutlet weak var countryCodeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Country Picker"

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

extension ViewController: CountryPickerTableViewControllerDelegate {
    
    func didSelectCountry(country: Country?) {
        if country != nil {
            self.countryTxtFld.text = country?.name
            self.countryFlagImgVw.image = country?.flagImage
            self.countryCodeLbl.text = "ISO Country Code: \(country!.isoCountryCode)"
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        self.navigationController?.pushViewController(tableViewController, animated: true)
    }
}
