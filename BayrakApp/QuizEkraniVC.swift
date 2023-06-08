//
//  QuizEkraniVC.swift
//  BayrakApp
//
//  Created by bk mobil on 8.06.2023.
//

import UIKit

class QuizEkraniVC: UIViewController {

    @IBOutlet weak var labelYanlis: UILabel!
    
    @IBOutlet weak var labelDogru: UILabel!
    
    @IBOutlet weak var labelSoruSayisi: UILabel!
    
    @IBOutlet weak var imageViewBayrak: UIImageView!
    
    @IBOutlet weak var buttonA: UIButton!
    
    @IBOutlet weak var buttonB: UIButton!
    
    @IBOutlet weak var buttonC: UIButton!
    
    @IBOutlet weak var buttonD: UIButton!
    
    var sorular = [Bayraklar]()
    var yanlisSecenekler = [Bayraklar]()
    var dogruSecenek = Bayraklar()

    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
    
    var secenekler = [Bayraklar]()
    var seceneklerKaristirmaListesi = Set<Bayraklar>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        sorular = BayraklarDao().getRandom5Flag()
                
        soruYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC = segue.destination as! SonucEkraniVC
        gidilecekVC.dogruSayisi = dogruSayac
    }
    
    func soruYukle() {
        labelSoruSayisi.text = "\(soruSayac+1). SORU"
        labelDogru.text = "Doğru : \(dogruSayac)"
        labelYanlis.text = "Doğru : \(yanlisSayac)"
        
        dogruSecenek = sorular[soruSayac]
        
        if let resim = dogruSecenek.bayrak_resim {
            imageViewBayrak.image = UIImage(named: resim)
        }
        
        if let id = dogruSecenek.bayrak_id {
            yanlisSecenekler = BayraklarDao().getRandom3Wrong(bayrak_id: id)
        }
        
        seceneklerKaristirmaListesi.removeAll()
        
        seceneklerKaristirmaListesi.insert(dogruSecenek)
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[0])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[1])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[2])
        
        secenekler.removeAll()
        
        for s in seceneklerKaristirmaListesi {
            secenekler.append(s)
        }
        
        if let ad = secenekler[0].bayrak_ad {
            buttonA.setTitle(ad, for: .normal)
        }
        if let ad = secenekler[1].bayrak_ad {
            buttonB.setTitle(ad, for: .normal)
        }
        if let ad = secenekler[2].bayrak_ad {
            buttonC.setTitle(ad, for: .normal)
        }
        if let ad = secenekler[3].bayrak_ad {
            buttonD.setTitle(ad, for: .normal)
        }
    }
    
    func dogruKontrol(button: UIButton) {
        let buttonYazi = button.titleLabel?.text
        let dogruCevap = dogruSecenek.bayrak_ad
        
        if(dogruCevap == buttonYazi) {
            dogruSayac += 1
        } else {
            yanlisSayac += 1
        }
        
        labelDogru.text = "Doğru : \(dogruSayac)"
        labelYanlis.text = "Doğru : \(yanlisSayac)"
        
    }
    
    func soruSayacKontrol() {
        soruSayac += 1
        
        if soruSayac != 5 {
            soruYukle()
        }else {
            performSegue(withIdentifier: "toSonucEkrani", sender: nil)
        }
    }
    
    @IBAction func buttonATikla(_ sender: Any) {
        dogruKontrol(button: buttonA)
        soruSayacKontrol()
    }
    
    @IBAction func buttonBTikla(_ sender: Any) {
        dogruKontrol(button: buttonB)
        soruSayacKontrol()
    }
    
    @IBAction func buttonCTikla(_ sender: Any) {
        dogruKontrol(button: buttonC)
        soruSayacKontrol()
    }
    
    @IBAction func buttonDTikla(_ sender: Any) {
        dogruKontrol(button: buttonD)
        soruSayacKontrol()
    }
}
