//
//  CountryPickerTableViewController.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

public class CountryPickerTableViewController: UITableViewController {
    
    weak public var delegate: CountryPickerTableViewControllerDelegate?
    
    let countriesObj = CountryListManager()
    var countriesArr: [Country] = []
    
    override public func viewDidLoad() {
        print("ViewDidLoad")
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
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

