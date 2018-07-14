//
//  CountryListManager.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

public class CountryListManager {

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
            return ProcessCountryListOperation(countryListManager: self)
        }
        
        func readFromJSON(fileName: String) -> [String] {
            let bundle = Bundle.init(identifier: "com.hackerpunch.CountryPicker")
            let fileURL = bundle!.url(forResource: "omittedCountries", withExtension: "json")
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
