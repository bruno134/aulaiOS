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
        
        listasTarefa = Lista.retornaListas(managedObjectContext)
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
          let idLista = listaSelecionada.id

          performSegueWithIdentifier("ListaItensViewController", sender: idLista)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        let navigation = segue.destinationViewController as! UINavigationController
        
        if segue.identifier == "ListaItensViewController" {
        
            let controller = navigation.viewControllers[0] as! ListaItensViewController
                controller.managedObjectContext = managedObjectContext
            
            let idLista = sender as! Int
            
            controller.codigoListaSelecionada = idLista
            
        }else{
            
        
        let controller = navigation.viewControllers[0] as! AdicionaListaViewController
        
        controller.managedObjectContext = managedObjectContext
        controller.delegate = self
        }
        
    }
    
}

extension ListaTarefasViewController: AdicionaListaViewControllerDelegate{
    
    func atualizaTabelaLista(){
        listasTarefa = Lista.retornaListas(managedObjectContext)
        tableView.reloadData()
    }

}
