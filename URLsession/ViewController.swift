//
//  ViewController.swift
//  URLsession
//
//  Created by Gaurav on 05/10/17.
//  Copyright © 2017 Gaurav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     var myData:Array = [[String: Any]]()
    
    // 1
    let defaultSession = URLSession(configuration: .default)
    // 2
    var dataTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.callPostMethod()
       //  self.callGetMethod()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func callGetMethod() {
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activity.center=view.center
        activity.startAnimating()
        view.addSubview(activity)
        
        // 1
        dataTask?.cancel()
        
        let url = NSURL(string: "http://apidev.accuweather.com/currentconditions/v1/202438.json?language=en&apikey=hoArfRosT1215")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
    
        dataTask = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            
                if let error = error {
                  // self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                    print(error.localizedDescription)
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    print(data)
                    
                     var errorMessage = ""
                    
                    do {
                        
                        if let objJsn = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                            print(objJsn)
                            
                            for ele in objJsn {
                                let dt = ele as? [String:Any]
                                print(dt!["EpochTime"]!);
                                
                                print(dt!["IsDayTime"]!);
                                
                                var myDic = [String:Any]()
                                myDic["time"] = dt!["EpochTime"]! as? Int
                                myDic["date"] = dt!["IsDayTime"]! as? Int
                                myDic["Link"] = dt!["Link"]! as? String
                                
                                self.myData.append(myDic)
                                
                                print(self.myData[0])
                                
                                for obj in self.myData {
                                    
                                    print(obj["time"]!)
                                    print(obj["date"]!)
                                }
                            }
                        }
                    
                        // 6
                        DispatchQueue.main.async {
                            //  completion(self.tracks, self.errorMessage)
                            activity.stopAnimating()
                            activity.removeFromSuperview()
                        }
                        
                       // print(responsedt ?? "no value")
                        
                    } catch let parseError as NSError {
                        errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
                        return
                    }
                
                }
            }
            // 7
            dataTask?.resume()
        
    }
    
    func callPostMethod() {
            
            let activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
            activity.center=view.center
            activity.startAnimating()
            view.addSubview(activity)
        
                 APIManager.sharedInstance.getData(){ (mydata) in
                        
                        if mydata != "" {
                            print(mydata)
                        } else {
                            print("no data")
                        }
                        
                        
                    }
        
        
        
        
        
        
                    DispatchQueue.main.async {
                        activity.stopAnimating()
                        activity.removeFromSuperview()
                    }
        
    }


}

