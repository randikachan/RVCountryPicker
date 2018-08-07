//
//  FileHandler.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 8/5/18.
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

import Foundation

public class FileHandler {

    public enum fileType: String {
        case PNG = ".png"
        case JPG = ".jpg"
    }
    
    public enum fileExtension: String {
        case JSON = "json"
        case XML = "xml"
    }
    
    // Get list of files which is packaged within the Library when the file type is given
    public static func getLocalFilesList(fileType: fileType) -> [String] {
        let bundle = Bundle.init(for: CountryListManager.self)
        let documentsInDirectory = bundle.paths(forResourcesOfType: fileType.rawValue, inDirectory: nil)
        
        var documentsList: [String] = []
        for document in documentsInDirectory {
            documentsList.append((document as NSString).lastPathComponent.replacingOccurrences(of: fileType.rawValue, with: ""))
        }
        
        return documentsList
    }
    
    // Read a locally stored JSON File
    public static func readFromJSON(fileName: String, fileExtension: fileExtension) -> [String] {
        let bundle = Bundle.init(for: CountryListManager.self)
        let fileURL = bundle.url(forResource: fileName, withExtension: fileExtension.rawValue)
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
