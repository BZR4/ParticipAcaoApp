//
//  SaveMethods.swift
//  ParticipACAO
//
//  Created by Evandro Henrique Couto de Paula on 30/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit

class SaveMethods: NSObject {
    
    func verifyEmptyField(txtFiled:UITextField)->Bool{
        if ((txtFiled.text?.isEmpty) == true){
            return true
        }else{
            return false
        }
    }

}
