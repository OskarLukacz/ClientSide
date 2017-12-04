//
//  GET.swift
//  ClientSide
//
//  Created by Oskar Lukacz on 11/28/17.
//  Copyright © 2017 Oskar Lukacz. All rights reserved.
//

import Foundation

func getJSONData(urlString:String)
{
    
    let url = URL(string: urlString)!
    let request = URLRequest(url: url)
    
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: [])
        
        jsonToString(json: json as AnyObject)
        
        //self.jsonToString(json: data as AnyObject)
        
        
        
    }
    
    task.resume()
    
    
}

func jsonToString(json: AnyObject){
    do {
        let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
        let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
        print(convertedString!)
        
        
    } catch let myJSONError {
        print(myJSONError)
    }
    
}

