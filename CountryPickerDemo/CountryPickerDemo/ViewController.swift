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

    @IBOutlet weak var countryTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        countryTxtFld.delegate = self
        print("COuntry")
    }

}

extension ViewController : CountryPickerTableViewControllerDelegate {
    
    func didSelectCountry(country: Country?) {
        self.countryTxtFld.text = country?.name
    }
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        let tableViewController = CountryPickerTableViewController(style: .plain)
        tableViewController.delegate = self
        print("Count: \(String(describing: self.navigationController?.viewControllers.count))")
        self.navigationController?.pushViewController(tableViewController, animated: true)
        print("Editing")
    }
}
