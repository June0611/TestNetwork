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

    }

    @IBAction func test1(_ sender: UIButton) {
        NetworkService .GetRequest(url: "http://192.168.1.107:8080/SkeeterTask/test/login", params: nil) { (model:TestModel?, error:Error?) in
            if error != nil {
                print("Error")
                return
            }
            print("结果为对象--->\(model?.message ?? "NoMessage")")
        }
    }

    @IBAction func test2(_ sender: UIButton) {
        
        NetworkService.GetRequest(url: "http://192.168.1.107:8080/SkeeterTask/test/login2", params: nil) { (modelArr:[TestModel]?, error:Error?) in
            if error != nil{
                print("Error")
                return
            }
            if let arr = modelArr{
                for item in arr{
                    print("结果为对象数组--->\(item.message ?? "NoMessage")")
                }
            }
        }
    }
}

