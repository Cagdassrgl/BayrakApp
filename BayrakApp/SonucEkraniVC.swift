//
//  SonucEkraniVC.swift
//  BayrakApp
//
//  Created by bk mobil on 8.06.2023.
//

import UIKit

class SonucEkraniVC: UIViewController {

    @IBOutlet weak var labelSonuc: UILabel!
    
    @IBOutlet weak var labelYuzde: UILabel!
    
    var dogruSayisi: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        if let d = dogruSayisi {
            labelSonuc.text = "\(d) DOĞRU \(5-d) YANLIŞ"
            
            if d < 3 {
                labelYuzde.textColor = .systemRed
            }else if d == 3  {
                labelYuzde.textColor = .systemOrange
            } else {
                labelYuzde.textColor = .systemGreen
            }
            
            labelYuzde.text = "% \(d*100/5) Başarı"
        }

    }
    
    @IBAction func buttonTekrarDene(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
