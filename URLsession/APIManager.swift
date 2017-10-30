//
//  APIManager.swift
//  URLsession
//
//  Created by Gaurav on 30/10/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

import Foundation

class APIManager {
    
    static let sharedInstance = APIManager()
    
    private init() {
        
    }
    
    func getData(onCompletion:@escaping (String) -> Void) {
        
        var retyrnVL:Bool? = false
        var mydata:String?
        
        
        let dict = ["key": "cb784502bffab6e"] as [String: Any]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])    {
            
            let url = NSURL(string: "http://date.jsontest.com/")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
                
                if error != nil {
                    print(error?.localizedDescription)
                    
                    retyrnVL = false
                    onCompletion("")
                }
                
                do {
                    
                    if let objJsn = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] {
                        
                        print(objJsn["time"] as! String)
                        retyrnVL = true
                        onCompletion(objJsn["time"] as! String)
                    }
                    
                } catch let error as NSError {
                    print(error)
                    retyrnVL = false
                    onCompletion("")
                }
                
            }
            
            task.resume()
            
        }
        
        //return retyrnVL!
        
    }
    
}


