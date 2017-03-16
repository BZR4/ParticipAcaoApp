//
//  UserViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 13/10/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
class UserViewController: UIViewController {
    
    
    // MARK: - Properties
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    
    //labels
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserNick: UILabel!
    @IBOutlet weak var lblUserEmail: UILabel!
    @IBOutlet weak var lblUserPassword: UILabel!
    
    
    //MARK: - View lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.changeLabelsText()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    // MARK: -Methods to register a ner user
    func registerNewUser(){
        let user = PFUser();
        
        user.username = nameTxtField.text
        user.password = passwordTxtField.text
        user.email    = emailTxtField.text
        
        //addtional field into parse database
        user["userName"] = userNameTxtField.text
        
        user.signUpInBackgroundWithBlock { (succeeded :Bool, error:NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                print("Error: \(errorString)")
                
            }else{
                print("User registered")
            }
        }
        
    }
    // MARK: - Actions
    @IBAction func confirmNewUser(sender: AnyObject) {
        self.registerNewUser()
    }
    
    
    // MARK: - Change texts for i10n
    func changeLabelsText(){
        //name
        self.lblName.text =         NSLocalizedString("name",value: "Nome", comment: "title for string that defines the user name")
        self.lblUserNick.text =     NSLocalizedString("nick name",value: "Login", comment: "title for string that defines the user login name")
        self.lblUserEmail.text =    NSLocalizedString("email",value: "EMAIL", comment: "title for string that defines the user email")
        self.lblUserPassword.text = NSLocalizedString("password",value: "Senha", comment: "title for string that defines the user password")
    }
    

  

}
