//
//  PostStaticTableViewController.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 11/5/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse


class PostStaticTableViewController: UIViewController, ImagePostDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    // MARK: - Variables and Constants
    var imageSelected: UIImage?
    
    
    //user variable of tracking
    var canBeTracked:Bool!
    
    let location = Location()
    
    
    // MARK: - IBOutlet's
    @IBOutlet var newFeedTableView: UITableView!
    
    @IBOutlet weak var txtFieldTitleNewFeed: UITextField!
    @IBOutlet weak var txtFieldDescriptionNewFeed: UITextField!
    @IBOutlet weak var txtViewdDescriptionNewFeed: UITextView!
    
    
    //buttons
    var saveFeed : UIBarButtonItem!
    var cancelFeed : UIBarButtonItem!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set text field delegate
        txtFieldDescriptionNewFeed.delegate = self
        txtFieldTitleNewFeed.delegate = self
        
        self.location.startLocation()
        canBeTracked = self.location.readTrackingOptions()
        
        self.saveFeed = UIBarButtonItem(title: "Publicar", style: UIBarButtonItemStyle.Done, target: self, action: "savePost")
        self.navigationItem.rightBarButtonItem = saveFeed
        
        self.cancelFeed = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelFeedAlert")
        self.navigationItem.leftBarButtonItem = cancelFeed
        
//        self.newFeedTableView.allowsSelection = false
        
        
        self.saveFeed.enabled = false
        
        
        if (CLLocationManager.authorizationStatus() == .Denied){
            let locationAlert = Alert()
            let locationAlertTitle = NSLocalizedString("Localização desativada", comment: "expression used for the title of location alert")
            let locationAlertContent = NSLocalizedString("Para apontar o local de sua queixa o serviço de localização do aparelho deve estar ativado", comment: "message for alert user for activate the location permission to use the feature")
            //
            self.presentViewController(locationAlert.alertOk(locationAlertTitle, msg: locationAlertContent), animated: true, completion: nil)
            
            self.canBeTracked = false
            
            
        }
        
    }
    
    
    // MARK: - Saving Feed
    func savingFeed () {
        
        let saveMethods = SaveMethods()
        var titleFieldIsEmpty: Bool!
        var descritionFieldIsEmpty:Bool!
        
        let queryCategory = PFQuery(className: "Category")
        queryCategory.getObjectInBackgroundWithId("n5QptnSLys"){(object, error) -> Void in
            if error == nil {
                if let category = object as PFObject! {
                    let topic = PFObject(className: "Topic")
                    
                    //Title of post
                    if(saveMethods.verifyEmptyField(self.txtFieldTitleNewFeed) == false){
                        topic["subject"] = self.txtFieldTitleNewFeed.text
                        titleFieldIsEmpty = false
                    }else{
                        let title = NSLocalizedString("Campo vazio", comment: "title that says there is a blank field")
                        let content = NSLocalizedString("O campo título não pode ficar vazio", comment: "Message that says to user that the subject field can't be null")
                        let alert = Alert()
                        self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
                        titleFieldIsEmpty = true
                        
                    }
                    topic["category"] = category
                    topic["user"] = PFUser.currentUser()
                    
                    
                    if(self.imageSelected != nil){
                        let image = UIImageJPEGRepresentation(self.imageSelected!, 1.0)
                        let imageFile = PFFile(name: "image.jpg", data: image!) //  Adicionar username e data ao nome da imagem
                        topic["image"] = imageFile
                    }else{
                        print("Null image")
                    }
                    
                    if (self.canBeTracked == true){
                        if let loc: CLLocationCoordinate2D = (self.location.locationManager.location?.coordinate)! as CLLocationCoordinate2D {
                            let latutude = loc.latitude
                            let longitude = loc.longitude
                            let point = PFGeoPoint(latitude: Double(latutude), longitude: Double(longitude))
                            topic["location"] = point
                            
                        }
                    }else{
                        print("cant be tracked")
                    }
                    
                    
                    let reply = PFObject(className: "Reply")
                    reply["topic"] = topic
                    
                    
                    //Content
                    if(saveMethods.verifyEmptyField(self.txtFieldDescriptionNewFeed) == false){
                        reply["content"] = self.txtFieldDescriptionNewFeed.text
                        descritionFieldIsEmpty = false
                    }else{
                        let title = NSLocalizedString("Campo vazio", comment: "title that says there is a blank field")
                        let content = NSLocalizedString("O campo mensagem não pode ficar vazio", comment: "Message that says to user that the content field can't be null")
                        let alert = Alert()
                        self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
                        descritionFieldIsEmpty = true
                        
                    }

                    
                    //reply["content"] = self.txtFieldDescriptionNewFeed.text
                    reply["user"] = PFUser.currentUser()
                    
                    if(titleFieldIsEmpty == true || descritionFieldIsEmpty == true){
                        print("campos vazios")
                    }else{
                        reply.saveInBackgroundWithBlock({(success, error) -> Void in
                            if error == nil {
                                print("Reply with Topic created with success!")
                                let alert = Alert()
                                let title = NSLocalizedString("Sucesso", comment: "Title for sucess post created")
                                let content  = NSLocalizedString("Seu post foi criado com sucesso", comment: "Mesaage that advertise the user for success in thier post created")
                                self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
                                self.txtFieldDescriptionNewFeed.text = ""
                                self.txtFieldTitleNewFeed.text = ""
                                self.imageSelected?.imageAsset
                            
                                self.saveFeed.enabled = false
                                
                            }else{
                                print("Error creating reply with topic: Error: ",error?.localizedDescription)
                                let alert = Alert()
                                let title = NSLocalizedString("Falhou", comment: "Title for fail in post creation")
                                let content  = NSLocalizedString("Seu post não pode ser criado\n Por favor tente novamente", comment: "Mesaage that advertise the user for fail in thier post creation")
                                self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
                                self.txtFieldDescriptionNewFeed.text = ""
                                self.txtFieldTitleNewFeed.text = ""
                                
                                
                            }
                        })
                    }
                    
                    

                }else{
                    print("Error infering category object!")
                }
            }
        }
    }
    
    
    // Cancel Feed
    func cancelFeedAlert() {
        self.AlertCancelPost("Novo Post", msg: "Deseja cancelar um novo post?")
    }
    

    
    
    
    
    // MARK: - Image Delegate
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
    
    
    // MARK: - Alert's
    // TODO: - Melhorar, deixar em um único método
    // Save Post
    func AlertSavePost (title: String, msg: String) {
        let newAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yes = UIAlertAction(title: "Sim", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        let no = UIAlertAction(title: "Não", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
        }
        
        newAlert.addAction(yes)
        newAlert.addAction(no)
        
        self.presentViewController(newAlert, animated: true, completion: nil)
    }
    
    
    // Cancel Post
    func AlertCancelPost (title: String, msg: String) {
        let newAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yes = UIAlertAction(title: "Sim", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            
            self.navigationController?.popViewControllerAnimated(true)
        }
        let no = UIAlertAction(title: "Não", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        
        newAlert.addAction(yes)
        newAlert.addAction(no)
        
        self.presentViewController(newAlert, animated: true, completion: nil)
    }
    
    
    //MARK: - Textfield delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        self.saveFeed.enabled = true
    }
    
    //MARK: - new save post method
    func savePost(){
        let saveMethods = SaveMethods()
        var titleFieldIsEmpty: Bool!
        var descritionFieldIsEmpty:Bool!
        
        let topic = PFObject(className: "Topic")
        
        if(saveMethods.verifyEmptyField(self.txtFieldTitleNewFeed)){
            
            let title   = NSLocalizedString("Campo vazio", comment: "title that says there is a blank field")
            let content = NSLocalizedString("O campo título não pode ficar vazio", comment: "Message that says to user that the subject field can't be null")
            
            let alert   = Alert()
            self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
            titleFieldIsEmpty = true

            
        }else{
            
            topic["subject"]    = self.txtFieldTitleNewFeed.text
            titleFieldIsEmpty   = false

        }
        
        
        //  Descomentei para testes
//        let category = PFQuery(className: "Category")
//        topic["category"] = category.getObjectInBackgroundWithId("zrRsJ0NKIf")
        
//  Descomentei para testes
        
        topic["user"]     = PFUser.currentUser()
        
        
        if(self.imageSelected != nil){
            let image = UIImageJPEGRepresentation(self.imageSelected!, 1.0)
            let imageFile = PFFile(name: "image.jpg", data: image!) //  Adicionar username e data ao nome da imagem
            topic["image"] = imageFile
        }else{
            print("Null image")
        }
        
        if (self.canBeTracked == true){
            if let loc: CLLocationCoordinate2D = (self.location.locationManager.location?.coordinate)! as CLLocationCoordinate2D {
                let latutude = loc.latitude
                let longitude = loc.longitude
                let point = PFGeoPoint(latitude: Double(latutude), longitude: Double(longitude))
                topic["location"] = point
                
            }
        }else{
            print("cant be tracked")
        }
        
        
        let reply = PFObject(className: "Reply")
        reply["topic"] = topic
        
        
        //Content
        if(saveMethods.verifyEmptyField(self.txtFieldDescriptionNewFeed) == false){
            reply["content"] = self.txtFieldDescriptionNewFeed.text
            descritionFieldIsEmpty = false
        }else{
            let title = NSLocalizedString("Campo vazio", comment: "title that says there is a blank field")
            let content = NSLocalizedString("O campo mensagem não pode ficar vazio", comment: "Message that says to user that the content field can't be null")
            let alert = Alert()
            self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
            descritionFieldIsEmpty = true
            
        }
        
        
        //reply["content"] = self.txtFieldDescriptionNewFeed.text
        reply["user"] = PFUser.currentUser()
        
        if(titleFieldIsEmpty == true || descritionFieldIsEmpty == true){
            print("campos vazios")
        }else{
            reply.saveInBackgroundWithBlock({(success, error) -> Void in
                if error == nil {
                    print("Reply with Topic created with success!")
                    let alert = Alert()
                    let title = NSLocalizedString("Sucesso", comment: "Title for sucess post created")
                    let content  = NSLocalizedString("Seu post foi criado com sucesso", comment: "Mesaage that advertise the user for success in thier post created")
                    self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
                    self.txtFieldDescriptionNewFeed.text = ""
                    self.txtFieldTitleNewFeed.text = ""
                    self.imageSelected?.imageAsset
                    
                    self.saveFeed.enabled = false
                    
                }else{
                    print("Error creating reply with topic: Error: ",error?.localizedDescription)
                    let alert = Alert()
                    let title = NSLocalizedString("Falhou", comment: "Title for fail in post creation")
                    let content  = NSLocalizedString("Seu post não pode ser criado\n Por favor tente novamente", comment: "Mesaage that advertise the user for fail in thier post creation")
                    self.presentViewController(alert.alertOk(title, msg: content), animated: true, completion: nil)
                    self.txtFieldDescriptionNewFeed.text = ""
                    self.txtFieldTitleNewFeed.text = ""
                    
                    
                }
            })
        }

        
        
    }
}
