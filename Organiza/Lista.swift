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
                    print("Pesquisa retornou mais de um resultado")
                }
            }
            
        }catch{
            fatalCoreDataError(error)
        }
        
        return nil
    }
    
    class func retornaListas(contexto:NSManagedObjectContext) -> [Lista]{
        
        var listaResultado = [Lista]()
        let listaFetch = NSFetchRequest(entityName: "Lista")
        
        do{
            
            let resultado = try contexto.executeFetchRequest(listaFetch) as? [Lista]
            
            if let resultado = resultado{
                listaResultado = resultado
            }
            
        }catch{
            fatalCoreDataError(error)
        }
        
        return listaResultado
    }

    class func salvarLista(context: NSManagedObjectContext, lista:ListaTarefa){
        
        let novaLista = NSEntityDescription.insertNewObjectForEntityForName("Lista", inManagedObjectContext: context) as! Lista
        
        novaLista.id = indiceListaTarefa + 1
        novaLista.nome = lista.nomeLista
        novaLista.tarefas = nil
        novaLista.caminhoImagem = lista.nomeImagem
        
        do {
            try context.save()
            indiceListaTarefa = lista.id
        } catch {
            fatalCoreDataError(error)
        }

    }
    
}