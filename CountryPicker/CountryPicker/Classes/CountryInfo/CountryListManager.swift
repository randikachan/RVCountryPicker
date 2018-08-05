//
//  CountryListManager.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

public class CountryListManager {
    
    // MARK: - Properties
    static public let shared = CountryListManager()
    
    // MARK: -
    var countryListReady: Bool
    var ommitedCountriesArr: [String] = []  // Some countries have to be omitted because they don't have Flags
    var countries: [Country] = []
    var countryFlagImageArr: [String] = []
    
    // Initialization
    init() {
        self.countryListReady = false
        self.ommitedCountriesArr = FileHandler.readFromJSON(fileName: "omittedCountries", fileExtension: .JSON)
        self.countryFlagImageArr = FileHandler.getLocalFilesList(fileType: .PNG)
    }
    
    func getCountries() -> [Country] {
        var countriesArr: [Country] = []
        
        for code in NSLocale.isoCountryCodes as [String] {
            let localeIdentifier = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: localeIdentifier) ?? "Error: Country not found for code: \(code)"
            
            // Check if the country should be omitted
            if self.ommitedCountriesArr.contains(name) {
                continue;
                // else add it to the final result list
            } else {
                // Create a country object
                let country = Country(countryCode: code, name: name, localeId: localeIdentifier)
                
                // Check if the image file name is available
                if countryFlagImageArr.contains(country.flagImageName!) {
                    countriesArr.append(country)
                } else {
                    print("Error: Couldn't find a Flag Image for the Country: \(name)")
                }
            }
        }
        
        // Sort countries array in Alphabetical order
        countriesArr = countriesArr.sorted(by: {$0.name < $1.name})
        
        // Add index according to the sorted array positioning
        var flagIndex: Int = 0
        for country in countriesArr {
            country.index = flagIndex
            flagIndex += 1
        }
        return countriesArr
    }


    // Explicitly initiating the Countries list before the TableViewController is initiated or loaded
    public func processCountriesList(countryListManager: CountryListManager, withCompletionBlock: @escaping (_ countriesArr: [Country]) -> Void) {
        let processCountryListOperation = ProcessCountryListOperation(countryListManager: countryListManager)
        
        processCountryListOperation.completionBlock = {
            withCompletionBlock(countryListManager.countries)
        }
        
        let queue = OperationQueue()
        queue.addOperation(processCountryListOperation)
    }
    
    // Where no completion block for processing countries list is needed, use this method
    public func processCountriesList(countryListManager: CountryListManager) {
        let processCountryListOperation = ProcessCountryListOperation(countryListManager: self)
        let queue = OperationQueue()
        queue.addOperation(processCountryListOperation)
    }
}
