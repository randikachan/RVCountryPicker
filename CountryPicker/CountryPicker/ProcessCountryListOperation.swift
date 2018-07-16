//
//  ProcessCountryListOperation.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

public class ProcessCountryListOperation: Operation {
    let countryListManager: CountryListManager
    
    init(countryListManager: CountryListManager) {
        self.countryListManager = countryListManager
        
        super.init()
        self.qualityOfService = .background
        self.queuePriority = .veryHigh
    }
    
    override public func main() {
        if isCancelled {
            return
        }
        
        if !self.countryListManager.countryListReady {
            self.countryListManager.countries = self.countryListManager.getCountries()
            print("1 Operation: \(self.self.countryListManager.countries.count)")
            self.countryListManager.countryListReady = true
        } else {
            print("2 Operation: \(self.self.countryListManager.countries.count)")
            return
        }
    }
}
