//
//  ItemLista.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 18/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import Foundation

class ItemLista:NSObject {
    
    var texto = ""
    var checked = false
    var dataLembrete = NSDate()
    var lembrete = false
    
    func mudarMarcaItem() {
        checked = !checked
    }
}
