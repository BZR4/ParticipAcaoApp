//
//  MyLoginViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 22/10/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import ParseUI
import Parse
import ParseFacebookUtilsV4
import Social
import Accounts
import ParseTwitterUtils


class MyLoginViewController: PFLogInViewController, PFLogInViewControllerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        // Setup the logo
        let logoView = UIImageView(image: UIImage(named: "Map Marker Filled-32"))
        self.logInView!.logo = logoView // 'logo' can be any UIView

        
        
        //MARK: - Set up screen elements
        //set the buttons
        self.logInView?.usernameField?.placeholder = NSLocalizedString("Nome completo", comment: "placeholder that describes the field name")
        self.logInView?.passwordField?.placeholder = NSLocalizedString("Senha", comment: "placeholder that describes de password field")
        self.logInView?.signUpButton?.setTitle      (NSLocalizedString("Cadastrar", comment: "Descrition for signUp button"), forState: .Normal)
        self.logInView?.logInButton?.setTitle       (NSLocalizedString("Entrar", comment: "description for login button "), forState: .Normal)
        self.logInView?.passwordForgottenButton?.setTitle(NSLocalizedString("Esqueci a senha", comment: "password forgotten button title"), forState: .Normal)
        
        if(UIAccessibilityIsVoiceOverRunning()){
            self.logInView?.dismissButton?.accessibilityLabel = NSLocalizedString("Fechar", comment: "String for accessibility dissmis button")
            self.logInView?.dismissButton?.accessibilityHint = NSLocalizedString("Clique duas vezes para fechar a view", comment: "String for accessibility dissmis button")
        }
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
       
    
    
    
}