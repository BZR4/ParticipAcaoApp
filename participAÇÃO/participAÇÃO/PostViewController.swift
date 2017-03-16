//
//  PostViewController.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/16/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Parse


class PostViewController: UIViewController, ImagePostDelegate, CLLocationManagerDelegate {

    // MARK: - Variables and Constants
    var imageSelected: UIImage?
    
    // MARK: - IBOutlet's
    @IBOutlet weak var txtFieldTitle: UITextField!
    @IBOutlet weak var txtViewTextPost: UITextView!
    
    @IBOutlet weak var btnBarItemCancel: UIBarButtonItem!
    @IBOutlet weak var btnBarItemSendPost: UIBarButtonItem!
    
    
    //locations variables
    var locationLat:String!
    var locationLong:String!
    let locationManager = CLLocationManager()
    
    //user variable of tracking
    var canBeTracked:Bool!

    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.startLocation()
        canBeTracked = true
        
        
        
    }
    
    
    // MARK: - IBAction's
    @IBAction func cancelPost(sender: AnyObject) {
        
        self.AlertCancelPost("Novo Post", msg: "Deseja cancelar um novo post?")
    }
    
    
    
    @IBAction func sendPost(sender: AnyObject) {
//        Alert.alert("Funcionando!?", msg: "Ok")
//        
//        self.savePost()
        

        let queryCategory = PFQuery(className: "Category")
        queryCategory.getObjectInBackgroundWithId("n5QptnSLys"){(object, error) -> Void in
            if error == nil {
                if let category = object as PFObject! {
                    let topic = PFObject(className: "Topic")
                    topic["subject"] = self.txtFieldTitle.text
                    topic["category"] = category
                    topic["user"] = PFUser.currentUser()
                    
                    let image = UIImageJPEGRepresentation(self.imageSelected!, 1.0)
                    let imageFile = PFFile(name: "image.jpg", data: image!) //  Adicionar username e data ao nome da imagem
                    
                    topic["image"] = imageFile

                    
                    let loc = self.locationManager.location?.coordinate
                    let latutude = loc?.latitude
                    let longitude = loc?.longitude
                    let point = PFGeoPoint(latitude: Double(latutude!), longitude: Double(longitude!))
                    topic["location"] = point
                    
                    
                    let reply = PFObject(className: "Reply")
                    reply["topic"] = topic
                    reply["content"] = self.txtViewTextPost.text
                    reply["user"] = PFUser.currentUser()
                    
                    
                    reply.saveInBackgroundWithBlock({(success, error) -> Void in
                        if error == nil {
                            print("Reply with Topic created with success!")
                        }else{
                            print("Error creating reply with topic: Error: ",error?.localizedDescription)
                        }
                    })
                }else{
                    print("Error infering category object!")
                }
            }
        }
        
        
        
        self.AlertSavePost("Novo Post", msg: "Deseja criar um novo post?")
        
    }
    
    
    //MARK: - Save post
    
    func savePost(){
        let post = PFObject(className: "Post")
        
        post["title"] = txtFieldTitle.text
        post["content"] = txtViewTextPost.text
        
        let image = UIImageJPEGRepresentation(imageSelected!, 1.0)
        let imageFile = PFFile(name: "image.jpg", data: image!) //  Adicionar username e data ao nome da imagem
        
        post["image"] = imageFile

        
        if(canBeTracked == true){
            
            let loc = locationManager.location?.coordinate
            let latutude = loc?.latitude
            let longitude = loc?.longitude
            let point = PFGeoPoint(latitude: Double(latutude!), longitude: Double(longitude!))
            post["location"] = point
            
        }else{
            
            print("can't be traking")
            
        }
        
        
        post.saveInBackgroundWithBlock { (sucess:Bool, error:NSError?) -> Void in
            if ( error != nil){
                print(error?.description)
            }else{
                print("sucesso")
            }
        }
        
    }
    
    
    
    
    // MARK: - Delegate
    func imagePostDelegate(image: UIImage) {
        imageSelected = image
    }
    
    // Set Delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueContainer" {
            let vc = segue.destinationViewController as! CameraController
            vc.delegateImage = self
        }
    }
    
    
    //MARK: - Location controller
    
    //controls of locations requests for user
    func requestAuthorizationForLocationServices(){
        switch (CLLocationManager.authorizationStatus()){
        case .NotDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            self.canBeTracked = true
            break
        case .Denied:
            self.canBeTracked = false

            
//            let alert = UIAlertController(title: NSLocalizedString("Serviço de localização", comment: "Title for alert view of location services") , message:  NSLocalizedString("Para acessar este recurso o serviço de localização deve estar ativado", comment: "Message warning user that is necessary to activate location services"), preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "message for user confirmation"), style: .Default, handler: nil)
//            alert.addAction(okAction)
//            self.presentViewController(alert, animated: true, completion: nil)
            
            //alert.
            break
        case .AuthorizedAlways:
            self.canBeTracked = true
            print("sempre autorizado")
            break
        case .AuthorizedWhenInUse:
            self.canBeTracked = true
            print("autorizado quando em uso")
            break
        default:
            break
            
        }
    }
    
    //starts the locations patterns
    func startLocation(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.requestAuthorizationForLocationServices()
        self.locationManager.requestLocation()
    }
    
    
    
    // delegate method
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
    }
    
    //delegate method
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Erro : " + error.localizedDescription)
    }
    
    
    // MARK: - Alert's
    // TODO: - Melhorar, deixar em um único método
    // Save Post
    func AlertSavePost (title: String, msg: String) {
        let newAlert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        
        let yes = UIAlertAction(title: "Sim", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
//            self.savePost()
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

}
