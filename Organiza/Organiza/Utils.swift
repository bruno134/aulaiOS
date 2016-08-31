//
//  Utils.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import Foundation



var indiceListaTarefa: Int {
    get {
        return NSUserDefaults.standardUserDefaults().integerForKey("indiceListaTarefa")
    }
    set {
        NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "indiceListaTarefa")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}

func ajustePrimeiroAcesso() {
    let indice = indiceListaTarefa
    
    if indice == 0 {
       indiceListaTarefa = 1
    }
}