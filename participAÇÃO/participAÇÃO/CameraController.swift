//
//  CameraController.swift
//  participAÇÃO
//
//  Created by Rodrigo A E Miyashiro on 10/19/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol ImagePostDelegate {
    
    func imagePostDelegate (image: UIImage)
}

// TODO: - Inserir mudança entre os campos de texto, delegate dos campos texto, marks e comentarios
class CameraController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var newMedia: Bool?
    var imageSelected: UIImage?
    
    var delegateImage: ImagePostDelegate?
    
    @IBOutlet weak var imgCamera: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblImgPerfil: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "alert")
        gesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(gesture)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.img.image == nil {
            self.imgCamera.hidden = false
            self.lblImgPerfil.hidden = false
        }
        else {
            self.imgCamera.hidden = true
            self.lblImgPerfil.hidden = true

        }
    }
    
    
    func alert () {
        let optionMenu = UIAlertController(title: "Escolher!?", message: "Escolhe!!!!", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let camera = UIAlertAction(title: "Câmera", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.userCamera()
        }
        
        let cameraRoll = UIAlertAction(title: "Album", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.userCameraRoll()
        }
        let cancel = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
            
        }
        
        optionMenu.addAction(camera)
        optionMenu.addAction(cameraRoll)
        optionMenu.addAction(cancel)
        
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Pad){
            
            optionMenu.popoverPresentationController?.sourceView = self.view
            optionMenu.popoverPresentationController?.sourceRect = self.view.frame
            
            
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
            
        } else if (UIDevice.currentDevice().userInterfaceIdiom == .Phone){
            
            
            self.presentViewController(optionMenu, animated: true, completion: nil)
            
            
        }

        
        //self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    
    
    
    
    func userCamera () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            newMedia = true
        }
    }
    
    func userCameraRoll () {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
            newMedia = false
        }
    }
    
    // MARK: - Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType.isEqualToString(kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            img.image = image
            self.delegateImage?.imagePostDelegate(image)
            self.imageSelected = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType.isEqualToString(kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            
            let alert = UIAlertController(title: "Save Failed",
                message: "Failed to save image",
                preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            
        
            
            if(UIDevice.currentDevice().userInterfaceIdiom == .Pad){
                
                alert.popoverPresentationController?.sourceView = self.view
                alert.popoverPresentationController?.sourceRect = self.view.frame
                
                
                self.presentViewController(alert, animated: true, completion: nil)
                

            } else if (UIDevice.currentDevice().userInterfaceIdiom == .Phone){
                
                
                self.presentViewController(alert, animated: true, completion: nil)

                
            }

        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Delegate Image
    //    func imagePostDelegate() -> UIImage {
    //        return (self.imageSelected)!
    //    }
}
