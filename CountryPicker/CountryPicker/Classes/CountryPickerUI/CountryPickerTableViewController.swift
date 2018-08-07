//
//  CountryPickerTableViewController.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2018 Kasun Randika
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit

public class CountryPickerTableViewController: UITableViewController {
    
    public enum PresentationMethod {
        case MODAL
        case PUSHED
        case UNKNOWN
    }
    
    public var presentationMethod: PresentationMethod = PresentationMethod.UNKNOWN
    
    weak public var delegate: CountryPickerTableViewControllerDelegate?
    
    var countriesArr: [Country] = []
    
    override public func viewWillAppear(_ animated: Bool) {
        if CountryListManager.shared.countryListReady {
            self.countriesArr = CountryListManager.shared.countries
            self.tableView.reloadData()
        } else {
            let countryListManager = CountryListManager.shared
            
            let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
            self.view.bringSubview(toFront: activityIndicator)
            
            countryListManager.processCountriesList(countryListManager: countryListManager) { countriesArr in
                self.countriesArr = countriesArr

                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countriesArr.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        let country: Country = self.countriesArr[indexPath.row]
        cell.textLabel?.text = country.name
        cell.imageView?.image = country.flagImage
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Please select the country you live in"
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry: Country = self.countriesArr[indexPath.row]
        print("\(selectedCountry.name)")
        delegate?.didSelectCountry(country: selectedCountry)
        
        if presentationMethod == .MODAL {
            self.dismiss(animated: true, completion: nil)
        } else if presentationMethod == .PUSHED || presentationMethod == .UNKNOWN {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

