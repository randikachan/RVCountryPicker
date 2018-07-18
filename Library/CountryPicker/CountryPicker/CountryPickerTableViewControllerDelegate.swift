//
//  CountryPickerTableViewControllerDelegate.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

public protocol CountryPickerTableViewControllerDelegate: class {
    func didSelectCountry(country: Country?)
}
