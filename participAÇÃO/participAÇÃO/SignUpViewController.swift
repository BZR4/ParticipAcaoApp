//
//  SignUpViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 22/10/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class SignUpViewController: PFSignUpViewController, PFSignUpViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //setup image
        self.view.backgroundColor = UIColor.darkGrayColor()

        
//        let logoView = UIImageView(image: UIImage(named: "logo.png"))
//        self.signUpView.logo = logoView // 'logo' can be any UIView
        //MARK - setup screen elements
        
        self.signUpView?.usernameField?.placeholder =   NSLocalizedString("Nome de usuário", comment: "discribes the placeholder used in user name tex tfield")
        self.signUpView?.emailField?.placeholder =      NSLocalizedString("Email", comment: "email placeholder")
        self.signUpView?.passwordField?.placeholder =   NSLocalizedString("Senha", comment: "password placeholder")
        self.signUpView?.additionalField?.placeholder = NSLocalizedString("Nome completo", comment: "addtional field complete name place holder")
        self.signUpView?.signUpButton?.setTitle(NSLocalizedString("Cadastrar", comment: "title for signUp button"), forState: .Normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    
    


    

}
