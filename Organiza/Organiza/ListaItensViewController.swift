//
//  ListaItensViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 18/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit
import CoreData

class ListaItensViewController: UITableViewController {
    
    var itens:[ItemLista] = []
    var managedObjectContext: NSManagedObjectContext!
   
    var listaSelecionada:Lista?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencheTabela()
    }
    
    
    //MARK: TableView Functions
    
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
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            let item = itens[indexPath.row]
            item.mudarMarcaItem()
            
            
            marcarCelula(cell, item: item)
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    //Deleta itens da tabela, com swipe para a esquerda
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        itens.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    
    //MARK: Segue Function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "adicionaItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AdicionaTarefaViewController
            controller.delegate = self
            controller.managedObjectContext = managedObjectContext
            controller.listaSelecionada = self.listaSelecionada
            
        } else if segue.identifier == "EditaItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AdicionaTarefaViewController
            controller.delegate = self
            controller.managedObjectContext = managedObjectContext
            
            if let indexPath = tableView.indexPathForCell( sender as! UITableViewCell) {
                controller.itemParaEditar = itens[indexPath.row]
            }
        }
    }
    
    //MARK: Custom Function
    func marcarCelula(cell: UITableViewCell, item: ItemLista) {
        
        let label = cell.viewWithTag(100) as! UILabel
        
        
        if item.checked {
            label.text = "✓"
        } else {
            label.text = ""
        }
    }
    
    func setTextForCell(cell: UITableViewCell, doItem item: ItemLista) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.texto
    }
    
    func preencheTabela(){
        
        itens = [ItemLista]()
        
        if let lista = listaSelecionada,
            let listaTarefa = Lista.retornaLista(managedObjectContext, doCodigo: lista.id)?.tarefas{
            
            for itemLista in listaTarefa{
                
                let tarefa = itemLista as! Tarefa
                
                let linha = ItemLista()
                linha.texto = tarefa.texto
                linha.checked = tarefa.concluido
                itens.append(linha)
            }
        }
    }
}

extension ListaItensViewController:AdicionaTarefaDelegate{
    
    //MARK: Delegate Function
    
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItemAdicionado item: ItemLista) {
        
        preencheTabela()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItemEditado item: ItemLista) {
        
        if let index = itens.indexOf(item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                setTextForCell(cell, doItem: item)
            }
        }
        
       
        
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}
