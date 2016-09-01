//
//  ItemLista.swift
//  Organiza
//
//  Created by BRUNO DANIEL NOGUEIRA on 18/08/16.
//  Copyright © 2016 BRUNO DANIEL NOGUEIRA. All rights reserved.
//

import Foundation
import UIKit

class ItemLista:NSObject {
    
    var texto:String = ""
    var checked = false
    var codigoItem:Int8 = 0
    var dataLembrete = NSDate()
    var lembrete = false
    
    func mudarMarcaItem() {
        checked = !checked
    }
    
    func agendarNotificacao() -> Void {
        
        var existeNotificacao: UILocalNotification?
        existeNotificacao = verificaExisteNotificacao()
        
        if (existeNotificacao != nil){
            UIApplication.sharedApplication().cancelLocalNotification(existeNotificacao!)
        }
        
        if (lembrete == true && dataLembrete.compare(NSDate()) != NSComparisonResult.OrderedAscending) {
        
            let notificacao = UILocalNotification()
            notificacao.fireDate = self.dataLembrete
            notificacao.timeZone = NSTimeZone.defaultTimeZone()
            notificacao.alertBody = self.texto
            notificacao.soundName = UILocalNotificationDefaultSoundName
            notificacao.userInfo = ["codigoItem": String(self.codigoItem)]
        }
    }
    
    func verificaExisteNotificacao() -> UILocalNotification? {
        
        //resgata todas as notificações agendadas
        let todasNotificacoes:NSArray = UIApplication.sharedApplication().scheduledLocalNotifications!
        
        for notificacao in todasNotificacoes as! [UILocalNotification] {
            
            //resgata a referencia da notificação
            let codigo  = notificacao.userInfo?["codigoItem"] as? Int8
            
            if (codigo != nil && codigo == self.codigoItem){
                return notificacao
            }
        }
        
        return nil;
    }
    
    func fomatarDataParaTexto() -> String {
        
        if (self.lembrete == true) {
            
            let formatoData = NSDateFormatter()
            formatoData.dateStyle = NSDateFormatterStyle.MediumStyle
            formatoData.timeStyle = NSDateFormatterStyle.ShortStyle
            
            return formatoData.stringFromDate(self.dataLembrete)
        }
        
        return "Não existe notificação agendada"
    }
}
