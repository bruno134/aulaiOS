//
//  AdicionaTarefaViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 20/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit

protocol AdicionaTarefaDelegate: class {
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItem item: ItemLista)
}

class AdicionaTarefaViewController: UITableViewController {

    @IBOutlet weak var nomeTarefaTextField: UITextField!
    @IBOutlet weak var salvarBarButtonItem: UIBarButtonItem!
    
    weak var delegate:AdicionaTarefaDelegate?
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        nomeTarefaTextField.becomeFirstResponder()
    }
    
    @IBAction func salvarTarefa() {
        if let delegate = delegate {
            let item = ItemLista()
            item.texto = nomeTarefaTextField.text!
            item.checked = false
            delegate.adicionadoTarefa(self, doItem: item)
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
