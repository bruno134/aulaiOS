//
//  ListaTarefasViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit
import CoreData

class ListaTarefasViewController: UITableViewController, UINavigationControllerDelegate {

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
        
        var celula: UITableViewCell!
        
        if let novaCelula = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) {
            
            celula = novaCelula
            
        } else {
            celula = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        celula.textLabel?.text = lista.nome
        celula.accessoryType = .DetailDisclosureButton
        celula.imageView?.image = UIImage(named: lista.caminhoImagem!)
        
        return celula
        
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
