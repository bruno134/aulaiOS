//
//  Tarefa.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import Foundation
import CoreData


class Tarefa: NSManagedObject {

    class func salvar(itemLista:ItemLista, daLista lista:Lista, context:NSManagedObjectContext){
        
        let tarefa = NSEntityDescription.insertNewObjectForEntityForName("Tarefa", inManagedObjectContext: context) as! Tarefa
        
        
        tarefa.texto = itemLista.texto
        tarefa.concluido = itemLista.checked
        tarefa.dataLembrete = itemLista.dataLembrete
        tarefa.lembrete = itemLista.lembrete
        
        let tarefas = lista.tarefas?.mutableCopy() as! NSMutableOrderedSet
        
        tarefas.addObject(tarefa)
        
        lista.tarefas = tarefas.copy() as? NSOrderedSet
        
        do{
            try context.save()
        }catch{
            print("Erro ao salvar tarefas: \(error)")
        }
    }
    
    class func excluir(tarefa:Tarefa, daLista lista:Lista, context:NSManagedObjectContext){
        
        do{
            let tarefaParaRemover = tarefa
            let tarefas = lista.tarefas?.mutableCopy() as! NSMutableOrderedSet
            let index = tarefas.indexOfObject(tarefaParaRemover)
            
            tarefas.removeObject(index)
            
            lista.tarefas = (tarefas.copy() as! NSOrderedSet)
            
            context.deleteObject(tarefaParaRemover)
            
            try context.save()
            
        }catch{
            fatalCoreDataError(error)
        }

    }
    
    class func atualizarTarefa(context:NSManagedObjectContext){
        
        do{
            try context.save()
        }catch{
            fatalCoreDataError(error)
        }
        
    }
    
}

    