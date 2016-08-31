//
//  ListaTarefasViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit
import CoreData

class ListaTarefasViewController: UITableViewController, UINavigationControllerDelegate{

    var managedObjectContext: NSManagedObjectContext!
    var listasTarefa = [Lista]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencheTabela()
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listasTarefa.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cellIdentifier = "Cell"
        
        let lista = listasTarefa[indexPath.row]
        let listaTarefa = ListaTarefa()
        
        listaTarefa.id = lista.id
        listaTarefa.nomeLista = lista.nome
        if let _ = lista.caminhoImagem{
            listaTarefa.nomeImagem = lista.caminhoImagem!
        }
       
        listaTarefa.tarefas = lista.tarefas
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        
        cell.textLabel!.text = listaTarefa.nomeLista
        cell.detailTextLabel!.text = listaTarefa.status
        cell.imageView!.image = UIImage(named: listaTarefa.nomeImagem)
        cell.imageView?.isAccessibilityElement = true
        cell.imageView?.accessibilityLabel = listaTarefa.nomeImagem
        cell.accessoryView?.isAccessibilityElement = true
        cell.accessoryView?.accessibilityLabel = "editar"
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
          let listaSelecionada = listasTarefa[indexPath.row]
        

          self.performSegueWithIdentifier("ListaItensViewController", sender: listaSelecionada)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        
        
        if segue.identifier == "ListaItensViewController" {
        
        
            let controller = segue.destinationViewController as! ListaItensViewController
                controller.managedObjectContext = managedObjectContext
                controller.listaSelecionada = sender as! Lista!
                controller.delegate  = self
            
        }else if segue.identifier == "editaItem" {
        
            let navigation = segue.destinationViewController as! UINavigationController
            let controller = navigation.viewControllers[0] as! AdicionaListaViewController
            
            controller.managedObjectContext = managedObjectContext
            controller.delegate = self
            
            let lista = sender as! Lista
            let listaTarefa = ListaTarefa()
            listaTarefa.id = lista.id
            listaTarefa.nomeLista = lista.nome
            listaTarefa.nomeImagem = lista.caminhoImagem!
            
            controller.listaParaEditar = listaTarefa

        
        
        }else{
    
            let navigation = segue.destinationViewController as! UINavigationController
            let controller = navigation.viewControllers[0] as! AdicionaListaViewController
            
            controller.managedObjectContext = managedObjectContext
            controller.delegate = self
                        
        }
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
           Lista.excluirLista(listasTarefa[indexPath.row], context: managedObjectContext)
        }
        
        preencheTabela()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath)
    {
        
        let listaSelecionada = listasTarefa[indexPath.row]
        
        print("lista selecionada \(listaSelecionada.nome)")
        self.performSegueWithIdentifier("editaItem", sender: listaSelecionada)
    }
    
    func preencheTabela(){
        listasTarefa = Lista.retornaListas(managedObjectContext)
    }
   
    
}

extension ListaTarefasViewController: AdicionaListaViewControllerDelegate{
    
    func atualizaTabelaLista(){
        listasTarefa = Lista.retornaListas(managedObjectContext)
        tableView.reloadData()
    }
    

}
