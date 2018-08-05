//
//  FileHandler.swift
//  CountryPicker
//
//  Created by Randika Chandrapala on 8/5/18.
//  Copyright © 2018 HackerPunch. All rights reserved.
//

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
    
    public static func getLocalFilesList(fileType: fileType) -> [String] {
        let bundle = Bundle.init(for: CountryListManager.self)
        let documentsInDirectory = bundle.paths(forResourcesOfType: fileType.rawValue, inDirectory: nil)
        
        var documentsList: [String] = []
        for document in documentsInDirectory {
            documentsList.append((document as NSString).lastPathComponent.replacingOccurrences(of: fileType.rawValue, with: ""))
        }
        
        return documentsList
    }
    
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
