//
//  ListaItensViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 18/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit

class ListaItensViewController: UITableViewController {
    
    var itens:[ItemLista]
    
    required init?(coder aDecoder: NSCoder) {
        itens = [ItemLista]()
        
        for x in 1...10{
            let linha = ItemLista()
            linha.texto = "Tarefa " + String(x)
            linha.checked = false
            itens.append(linha)
        }
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itens.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemListaCell", forIndexPath: indexPath) as! ItemListaCell
        
        cell.textoTarefaLabel.text = itens[indexPath.row].texto
        
        marcarCelula(cell, item: itens[indexPath.row])
        
        return cell;
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            let item = itens[indexPath.row]
            item.mudarMarcaItem()
            
            marcarCelula(cell, item: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    func marcarCelula(cell: UITableViewCell, item: ItemLista) {
        if item.checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }

}
