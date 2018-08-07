//
//  Country.swift
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
