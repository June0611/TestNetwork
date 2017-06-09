//
//  ViewController.swift
//  TestNetwork
//
//  Created by Nile on 2017/6/9.
//  Copyright © 2017年 Nile. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        NetworkService .GetRequest(url: "http://10.238.48.161:8080/SkeeterTask/test/login", params: nil) { (model:TestModel?, error:Error?) in
            if error != nil {
                print("Error")
                return
            }
            print(model?.message ?? "NoMessage")
        }
        
        NetworkService.GetRequest(url: "http://10.238.48.161:8080/SkeeterTask/test/login2", params: nil) { (modelArr:[TestModel]?, error:Error?) in
            if error != nil{
                print("Error")
                return
            }
            if let arr = modelArr{
                for item in arr{
                    print(item.message ?? "NoMessage")
                }
            }
        }

    }


}

