//
//  Country.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

class Country: NSObject {
    var isoCountryCode: String = ""
    var name: String = ""
    var localeId: String = ""
    var index: Int = -1
    var flagImageName: String? {
        get {
            let imageName = name.replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "[", with: "")
                .replacingOccurrences(of: "]", with: "")
                .replacingOccurrences(of: ".", with: "")
                .replacingOccurrences(of: "’", with: "")
                .lowercased()
            
            return imageName
        }
        set {
        }
    }
    var flagImage: UIImage? {
        get {
            return UIImage(named: flagImageName!)
        }
        set {
        }
    }
    
    init(countryCode: String, name: String, localeId: String) {
        self.isoCountryCode = countryCode
        self.name = name
        self.localeId = localeId
    }
}
