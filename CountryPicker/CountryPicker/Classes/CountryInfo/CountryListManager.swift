//
//  CountryListManager.swift
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

public class CountryListManager {
    
    // MARK: - Properties
    static public let shared = CountryListManager()
    
    // MARK: -
    var countryListReady: Bool
    var ommitedCountriesArr: [String] = []  // Some countries have to be omitted because they don't have Flags
    public var countries: [Country] = []
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
