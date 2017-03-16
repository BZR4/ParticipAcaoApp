//
//  PerfilViewController.swift
//  participAÇÃO
//
//  Created by Evandro Henrique Couto de Paula on 19/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse


class PerfilViewController: UIViewController, ImagePostDelegate, UITextFieldDelegate {
    
    //MARK: - properties
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var cityTextField:     UITextField!
    @IBOutlet weak var aboutMeTextView:   UITextView!
    
    @IBOutlet weak var container: UIView!
    
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBOutlet weak var tempSpinner: UIActivityIndicatorView!
    
    @IBOutlet weak var btnSaveUpdate: UIButton!
    
    var imageSelected: UIImage!
    var city: String?
    var userName : String?
    var aboutMe : String?
    


    //MARK: - view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if imageSelected == nil {
            
            self.container.alpha = 1.0
            
        }else {
            
            self.container.alpha = 0.02
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
   
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // A magica acontecendo aqui
        self.userImgView.layer.masksToBounds = true
        self.userImgView.layer.cornerRadius = 35
        
        self.container.layer.masksToBounds = true
        self.container.layer.cornerRadius = 35
        
        if (city == nil){
            
            self.cityTextField.placeholder = NSLocalizedString("Cidade", comment: "Placeholder for city")
        }else {
            
            self.cityTextField.text        = city
        }
        
        if (userName == nil){
            
            self.userNameTextField.placeholder    = NSLocalizedString("Nome do usuário", comment: "Placeholder for user name")
            
        } else {
            
            self.userNameTextField.text = userName
        }
        
        if ( aboutMe == nil) {
            
            self.aboutMeTextView.text = NSLocalizedString("Fale sobre você", comment: "Default text for about me")
            
        } else {
            
            self.aboutMeTextView.text = aboutMe
        }
        
        
        if  (imageSelected == nil) {
            
            self.userImgView.image = UIImage(named: "Camera-64.png")
            
            
        } else{
    
            
            self.userImgView.image = imageSelected
            
        }
        
        
    }
    
    
    
    // MARK: - Delegate
    func imagePostDelegate(image: UIImage) {
        print("Entrou")
        imageSelected = image
    }
    
    // Set Delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueContainer" {
            let vc = segue.destinationViewController as! CameraController
            vc.delegateImage = self
        }
    }

    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func saveButton(sender: AnyObject) {
        
        self.tempSpinner.hidden = false
        self.tempSpinner.startAnimating()
        self.btnSaveUpdate.enabled = false
        
        let user = PFUser.currentUser()
        
        if (self.imageSelected == nil){
            
            user?.username =      self.userNameTextField.text
            user?["additional"] = self.cityTextField.text
            user?["aboutMe"] =    self.aboutMeTextView.text
            
            
            //save method
            user?.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
                if error == nil {
            
                    let alert = Alert()
                    
                    //user alert
                    self.presentViewController(alert.alertOk(NSLocalizedString("Dados atualizados", comment: "Message to tell to user that their data was updated"), msg: NSLocalizedString("Seu cadastro foi atualizado.", comment: "comfirmation message")), animated: true, completion: nil)
                    
                    self.tempSpinner.hidden = true
                    self.tempSpinner.stopAnimating()
                    self.btnSaveUpdate.enabled = true


                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }else{
                    
                    print("An error occurs during the user update")
                }
            })

        }else{
            
            let image = UIImageJPEGRepresentation(imageSelected!, 1.0)
            let imageFile = PFFile(name: "image.jpg", data: image!) //  Adicionar username e data ao nome da imagem
            
            //user image
            user!["picture_profile"] = imageFile
            // user info
            user?.username =      self.userNameTextField.text
            user?["additional"] = self.cityTextField.text
            user?["aboutMe"] =    self.aboutMeTextView.text
            
            
            //save method
            user?.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
                if error == nil {
                    let alert = Alert()
                    
                    self.tempSpinner.hidden = true
                    self.tempSpinner.stopAnimating()
                    self.btnSaveUpdate.enabled = true


                    
                    //user alert
                    self.presentViewController(alert.alertOk(NSLocalizedString("Dados atualizados", comment: "Message to tell to user that their data was updated"), msg: NSLocalizedString("Seu cadastro foi atualizado.", comment: "comfirmation message")), animated: true, completion: nil)

                    
                }else{
                    
                    print("An error occurs during the user update")
                }
            })
            
        }
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.userNameTextField.resignFirstResponder()
        self.cityTextField.resignFirstResponder()
        self.aboutMeTextView.resignFirstResponder()
    }
    



}
