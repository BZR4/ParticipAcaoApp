//
//  Alert.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/20/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class Alert: UIViewController {
    
    // TODO: - Atualizar classe
    
    //used for OK alerts
     func alertOk (title: String, msg: String) ->UIAlertController {
        let newAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        return newAlert
    }
    
    //used for OKCancel alerts
    func alertOkCancel (title:String, msg:String, actionMsg:String) ->UIAlertController{
        let newAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        newAlert.addAction(UIAlertAction(title:actionMsg , style: UIAlertActionStyle.Default, handler: nil ))
        return newAlert
    }
    
}
