//
//  AdicionaTarefaViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 20/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit

protocol AdicionaTarefaDelegate: class {
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItemAdicionado item: ItemLista)
    func adicionadoTarefa(controller: AdicionaTarefaViewController, doItemEditado item: ItemLista)
}

class AdicionaTarefaViewController: UITableViewController {

    @IBOutlet weak var nomeTarefaTextField: UITextField!
    @IBOutlet weak var salvarBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var switchAviso: UISwitch!
    @IBOutlet weak var lblDataAviso: UILabel!
    
    weak var delegate:AdicionaTarefaDelegate?
    var itemParaEditar: ItemLista?
    
    var _calendarioVisivel: Bool!
    var _dataAtual : NSDate!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let item = itemParaEditar {
            title = "Editar Item"
            nomeTarefaTextField.text = item.texto
            salvarBarButtonItem.enabled = true
            _calendarioVisivel = false
            //_dataAtual = item.dataAviso
        } else {
            _calendarioVisivel = false
            _dataAtual = NSDate()
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
                item.checked = false
                delegate.adicionadoTarefa(self, doItemAdicionado: item)
            }
        }
    }
    
    @IBAction func cancelarTarefa() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func ativaDesativaAviso(botaoAviso: UISwitch) {
        
        if (botaoAviso.on) {
            // TODO:
            return
        }
        lblDataAviso.text = "desligado"
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        if(indexPath.section == 1 && indexPath.row == 1){
            return indexPath;
        }else{
            return nil;
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 1 && indexPath.row == 2){
            
            //let celulaCalendario: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("celulaCalendario")!
            let celulaCalendario: UITableViewCell =
                UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celulaCalendario")
            
            celulaCalendario.selectionStyle = UITableViewCellSelectionStyle.None
            
            let calendario: UIDatePicker = UIDatePicker(frame: CGRectMake(0.0, 0.0, 320.0, 216.0) )
            calendario.tag = 100
            
            celulaCalendario.contentView.addSubview(calendario)
            
            calendario.addTarget(self, action: #selector(AdicionaTarefaViewController.dataAlterada), forControlEvents: UIControlEvents.ValueChanged)
            
            return celulaCalendario
            
        }
        
        return super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("passe 2")
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if (indexPath.section == 1 && indexPath.row == 1) {
            
            if (_calendarioVisivel == false) {
                exibirCalendario()
                return
            }
            escondeCalendario()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(section == 1 && _calendarioVisivel == true){
            return 3;
        }else{
            
            //caso contrario, somente mantem o numero atual de linhas na secao
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if(indexPath.section == 1 && indexPath.row == 2){
            return 217.0;
        }
        
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
       
    }
    
    override func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        
        if(indexPath.section == 1 && indexPath.row == 2){
            
            
            //enganando o tableView, forçando o retorno para linha 0. Poderia ser a 1 também.
            let novoIndice: NSIndexPath = NSIndexPath(forRow: 1, inSection: indexPath.section)
            
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: novoIndice)
        }else{
            return super.tableView(tableView, indentationLevelForRowAtIndexPath: indexPath)
        }
    }
    
    
    func dataAlterada(calendario: UIDatePicker) -> Void {
        
        _dataAtual = calendario.date
        self.atualizaCampoData()
        
    }
    
    func atualizaCampoData() -> Void {
        
        let formatacaoData: NSDateFormatter = NSDateFormatter()
        formatacaoData.dateStyle = NSDateFormatterStyle.MediumStyle
        formatacaoData.timeStyle = NSDateFormatterStyle.ShortStyle
        self.lblDataAviso.text = formatacaoData.stringFromDate(_dataAtual)
    }
    
    func exibirCalendario() -> Void {
        _calendarioVisivel = true
        
        let indiceLinha: NSIndexPath = NSIndexPath(forRow: 1, inSection: 1)
        let indiceCalendario: NSIndexPath = NSIndexPath(forRow: 2, inSection: 1)
        
        let celulaCalendario: UITableViewCell = self.tableView.cellForRowAtIndexPath(indiceLinha)!
        celulaCalendario.detailTextLabel?.textColor = celulaCalendario.detailTextLabel?.tintColor
        
        self.tableView.beginUpdates()
        
        self.tableView.insertRowsAtIndexPaths([indiceCalendario], withRowAnimation: .Fade)
        self.tableView.reloadRowsAtIndexPaths([indiceLinha], withRowAnimation: .None)
        
        self.tableView.endUpdates()
        
        let linhaCalendario: UITableViewCell = self.tableView.cellForRowAtIndexPath(indiceCalendario)!
        let calendario: UIDatePicker = linhaCalendario.viewWithTag(100) as! UIDatePicker
        
        calendario.setDate(_dataAtual, animated: false)
        
    }
    
    func escondeCalendario() -> Void {
        
        if (_calendarioVisivel == true){
            
            _calendarioVisivel = false
            
            let indiceLinha: NSIndexPath = NSIndexPath(forRow: 1, inSection: 1)
            let indiceCalendario: NSIndexPath = NSIndexPath(forRow: 2, inSection: 1)
            
            let linha: UITableViewCell = self.tableView.cellForRowAtIndexPath(indiceLinha)!
            linha.detailTextLabel?.textColor = UIColor(white: 0.0, alpha: 0.5)
            
            self.tableView.beginUpdates()
            
            self.tableView.reloadRowsAtIndexPaths([indiceLinha], withRowAnimation: .None)
            self.tableView.deleteRowsAtIndexPaths([indiceCalendario], withRowAnimation: .Fade)
            
            self.tableView.endUpdates()
        }
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

