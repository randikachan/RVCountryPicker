//
//  FileHandler.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 8/5/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

import Foundation

public class FileHandler {

    enum fileType: String {
        case PNG = ".png"
        case JPG = ".jpg"
    }
    
    enum fileExtension: String {
        case JSON = "json"
        case XML = "xml"
    }
    
    public static func getLocalFilesList(fileType: String) -> [String] {
        let bundle = Bundle.init(for: CountryListManager.self)
        let documentsInDirectory = bundle.paths(forResourcesOfType: fileType, inDirectory: nil)
        
        var documentsList: [String] = []
        for document in documentsInDirectory {
            documentsList.append((document as NSString).lastPathComponent.replacingOccurrences(of: fileType, with: ""))
        }
        
        return documentsList
    }
    
    public static func readFromJSON(fileName: String, fileExtension: String) -> [String] {
        let bundle = Bundle.init(for: CountryListManager.self)
        let fileURL = bundle.url(forResource: fileName, withExtension: fileExtension)
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
