//
//  AdicionaTarefaViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 20/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit
import CoreData

protocol AdicionaTarefaDelegate: class {
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItemAdicionado item: ItemLista)
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItemEditado item: ItemLista)
}

class AdicionaTarefaViewController: UITableViewController {

    @IBOutlet weak var nomeTarefaTextField: UITextField!
    @IBOutlet weak var salvarBarButtonItem: UIBarButtonItem!
    
    weak var delegate:AdicionaTarefaDelegate?
    var itemParaEditar: ItemLista?
    var managedObjectContext: NSManagedObjectContext!
    var listaSelecionada: Lista?
    
    
    override func viewDidLoad() {
        
        if let item = itemParaEditar {
            title = "Editar Item"
            nomeTarefaTextField.text = item.texto
            salvarBarButtonItem.enabled = true
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        nomeTarefaTextField.becomeFirstResponder()
    }
    
    @IBAction func salvarTarefa() {
        
        
        
        if let delegate = delegate {
            
            if let item = itemParaEditar {
                item.texto = nomeTarefaTextField.text!
                delegate.adicionadoTarefa(self, doItemEditado: item)
            }else{
                let item = ItemLista()
                item.texto = nomeTarefaTextField.text!
                item.dataLembrete = NSDate()
                item.lembrete = true
                
                delegate.adicionadoTarefa(self, doItemAdicionado: item)
            }
        }
    }
    
    @IBAction func cancelarTarefa() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        //para que a celula com o textfield não seja selecionado
        return nil
    }
}


extension AdicionaTarefaViewController:UITextFieldDelegate{
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
       
        let textoAnterior: NSString = textField.text!
        let textoAtual: NSString = textoAnterior.stringByReplacingCharactersInRange(range, withString: string)
        
        salvarBarButtonItem.enabled = (textoAtual.length > 0)
        return true

    }
}
