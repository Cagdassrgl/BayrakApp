//
//  Bayraklardao.swift
//  BayrakApp
//
//  Created by bk mobil on 8.06.2023.
//

import Foundation

class BayraklarDao {
    
    
    let db: FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let veritabaniUrl = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.sqlite")
        
        db = FMDatabase(path: veritabaniUrl.path)
    }
    
    func getRandom5Flag() -> [Bayraklar] {
        
        var liste = [Bayraklar]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM bayraklar ORDER BY RANDOM() LIMIT 5", values: nil)
            
            while rs.next() {
                let bayrak = Bayraklar(
                    bayrak_id: Int(rs.string(forColumn: "bayrak_id")),
                    bayrak_ad: rs.string(forColumn: "bayrak_ad"),
                    bayrak_resim: rs.string(forColumn: "bayrak_resim")
                )
                
                liste.append(bayrak)
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
        return liste
    }
    
    func getRandom3Wrong(bayrak_id: Int) -> [Bayraklar] {
        
        var liste = [Bayraklar]()
        
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM bayraklar WHERE  bayrak_id != ? ORDER BY RANDOM() LIMIT 3", values: [bayrak_id])
            
            while rs.next() {
                let bayrak = Bayraklar(
                    bayrak_id: Int(rs.string(forColumn: "bayrak_id")),
                    bayrak_ad: rs.string(forColumn: "bayrak_ad"),
                    bayrak_resim: rs.string(forColumn: "bayrak_resim")
                )
                
                liste.append(bayrak)
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
        
        return liste
    }
}
