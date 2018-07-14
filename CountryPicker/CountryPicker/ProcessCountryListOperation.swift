//
//  ProcessCountryListOperation.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

class ProcessCountryListOperation: Operation {
    var countries: [Country]
    let countryListManager: CountryListManager
    
    init(countryListManager: CountryListManager) {
        self.countries = []
        self.countryListManager = countryListManager
        
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
