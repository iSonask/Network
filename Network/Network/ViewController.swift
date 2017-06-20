//
//  ViewController.swift
//  Network
//
//  Created by Akash on 20/06/17.
//  Copyright © 2017 Akash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let urlToRequest = "https://itunes.apple.com/in/rss/newapplications/limit=10/json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let param: APIParameters = [
            "category_id": "271"
        ]

        let urlstring = URL(string: "")!
        Network.POSTRequest(using: urlstring, param: param, completionHandler: { jsonResponse in
            print(jsonResponse)
        })
        
        let urlstr = URL(string: "https://itunes.apple.com/in/rss/newapplications/limit=10/json")!
        Network.GETRequest(using: urlstr, onCompletion: { json in
            print(json)
            
        })
        
        
    }

    
    
    
}

