//
//  SeletorIconeTableViewController.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 28/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import UIKit

protocol SeletorIconeDelegate: class {
    
    func selecionaIcone(icone: String)
}

class SeletorIconeTableViewController: UITableViewController {

    var delegate: SeletorIconeDelegate?
    
    let icones = [
        "No Icon",
        "Appointments",
        "Birthdays",
        "Chores",
        "Drinks",
        "Folder",
        "Groceries",
        "Inbox",
        "Photos",
        "Trips" ]
    
    override func viewDidLoad() {
        navigationController?.title = "Selecione Ícone"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icones.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Icone", forIndexPath: indexPath)
        
        let iconName = icones[indexPath.row]
        cell.textLabel!.text = iconName
        cell.imageView!.image = UIImage(named: iconName)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let delegate = delegate {
            let nomeIcone = icones[indexPath.row]
            delegate.selecionaIcone(nomeIcone)
        }
    }

    
}
