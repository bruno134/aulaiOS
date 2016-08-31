//
//  ListaTarefa.swift
//  Organiza
//
//  Created by Marlon Sousa on 8/27/16.
//  Edited  by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import Foundation



class ListaTarefa:NSObject{
    
    var id:Int = 0
    var nomeLista:String = ""
    var nomeImagem:String = ""
    var tarefas:NSOrderedSet?
    
    var quantidadeItensPendentes: Int
        {
        get
        {
            var i = 0
            
            if let _ = tarefas{
                for t in tarefas!
                {
                    if !(t.concluido)
                    {
                        i += 1;
                    }
                }
            }
            return i
        }
    }
    
    var quantidadeItens: Int
        {
        get
        {
            if let _  = tarefas {
                return tarefas!.count
            }else{
                return 0
            }
        }
    }
    
    var concluido: Bool
        {
        get
        {
            return quantidadeItensPendentes == 0
        }
    }
    
    var status: String
        {
        get
        {
            if quantidadeItens == 0
            {
                return "Vazio"
            }
            else if quantidadeItens == quantidadeItensPendentes
            {
                return "Não iniciado "
            }
            else if concluido
            {
                return "Concluído"
            }
            else
            {
                return "\(quantidadeItensPendentes) de \(quantidadeItens) concluídos"
            }
        }
    }
    
}