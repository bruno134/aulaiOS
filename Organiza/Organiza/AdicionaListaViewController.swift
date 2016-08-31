//
//  AdicionaListaViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit
import CoreData

protocol AdicionaListaViewControllerDelegate: class {
    func atualizaTabelaLista()
}

class AdicionaListaViewController: UITableViewController {

    @IBOutlet weak var nomeTarefaTextField: UITextField!
    @IBOutlet weak var adicionaBarButton: UIBarButtonItem!
    @IBOutlet weak var iconeImageView: UIImageView!
    
    var delegate:AdicionaListaViewControllerDelegate?
    var listaParaEditar:ListaTarefa?
    var managedObjectContext: NSManagedObjectContext!
    var nomeIcone = "Folder"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let listaTarefa = listaParaEditar {
            title = "Editar Lista Tarefa"
            nomeTarefaTextField.text = listaTarefa.nomeLista
            adicionaBarButton.enabled = true
            nomeIcone = listaTarefa.nomeImagem
            
        }

        iconeImageView.image = UIImage(named: nomeIcone)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nomeTarefaTextField.becomeFirstResponder()
    }
    
    @IBAction func adicionar(sender: UIBarButtonItem) {
        
        if let listaTarefa = listaParaEditar{
           listaTarefa.nomeLista = nomeTarefaTextField.text!
            listaTarefa.nomeImagem = nomeIcone
            
            let listaParaAtualizar = Lista.retornaLista(managedObjectContext, doCodigo: listaTarefa.id)
            
            if let _ = listaParaAtualizar{
            
                listaParaAtualizar!.nome = listaTarefa.nomeLista
                listaParaAtualizar!.caminhoImagem = listaTarefa.nomeImagem
                
                Lista.atualizarLista(managedObjectContext)
            }
            
        }else{
           let novaListaTarefa = ListaTarefa()
            novaListaTarefa.nomeLista = nomeTarefaTextField.text!
            novaListaTarefa.nomeImagem = nomeIcone
            Lista.salvarLista(managedObjectContext, lista: novaListaTarefa)
        }
        self.delegate?.atualizaTabelaLista()
        dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBAction func cancelar(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 1 {
            return indexPath
        }else{
            return nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "SeletorIcone" {
            let controller = segue.destinationViewController as! SeletorIconeTableViewController
            controller.delegate = self
        }
        
    }
    
}

extension AdicionaListaViewController:UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let velhoTexto: NSString = textField.text!
        let novoTexto: NSString = velhoTexto.stringByReplacingCharactersInRange(range, withString: string)
        adicionaBarButton.enabled = (novoTexto.length > 0)
        return true
    }

}

extension AdicionaListaViewController:SeletorIconeDelegate{
    
    func selecionaIcone(icone: String){
        nomeIcone = icone
        iconeImageView.image = UIImage(named: nomeIcone)
        navigationController?.popViewControllerAnimated(true)
    }
}