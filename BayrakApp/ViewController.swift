//
//  ViewController.swift
//  BayrakApp
//
//  Created by bk mobil on 8.06.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDataBase()
    }
    
    func createDataBase() {
        let bundleYolu = Bundle.main.path(forResource: "bayrakquiz", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı önceden oluşturulmuş")
        } else {
            do {
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            
            }
            catch {
                print(error)
            }
        }
    }


}

