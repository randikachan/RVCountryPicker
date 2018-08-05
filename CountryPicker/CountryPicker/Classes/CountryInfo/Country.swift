//
//  Country.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 7/15/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import UIKit

public class Country: NSObject {
    public var isoCountryCode: String = ""
    public var name: String = ""
    public var localeId: String = ""
    public var index: Int = -1
    public var flagImageName: String? {
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
    public var flagImage: UIImage? {
        get {
            let bundle = Bundle(for: Country.self)
            return UIImage(named: flagImageName!, in: bundle, compatibleWith: nil)
        }
        set {
        }
    }
    
    public init(countryCode: String, name: String, localeId: String) {
        self.isoCountryCode = countryCode
        self.name = name
        self.localeId = localeId
    }

    public override var description: String {
        return "\n{\n index: \(self.index),\n"
            + " country: \(self.name),\n"
            + " isoCountryCode: \(self.isoCountryCode),\n"
            + " localeId: \(self.localeId),\n"
            + " flagImageName: \(self.flagImageName!)\n}"
    }
}
