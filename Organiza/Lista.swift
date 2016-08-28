//
//  Lista.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 27/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import Foundation
import CoreData


class Lista: NSManagedObject {
    

    class func retornaLista(contexto:NSManagedObjectContext, doCodigo codigo:Int) -> Lista?{
        
        let listaFetch = NSFetchRequest(entityName: "Lista")
        
        listaFetch.predicate = NSPredicate(format: "id == %li", codigo)
        
        do{
            
            let resultado = try contexto.executeFetchRequest(listaFetch) as? [Lista]
            
            if let listaResultado = resultado{
                
                if listaResultado.count > 0 {
                    return listaResultado[0]
                }else{
                    print("tem nada")
                }
            }
            
        }catch{
            
            fatalCoreDataError(error)
            
        }
        
        return nil
    }
    
}