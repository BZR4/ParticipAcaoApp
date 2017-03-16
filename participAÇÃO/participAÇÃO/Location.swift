//
//  Location.swift
//  ParticipACAO
//
//  Created by Evandro Henrique Couto de Paula on 26/11/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import CoreLocation
import Parse


class Location: UIViewController, CLLocationManagerDelegate {
    
    //locations variables
    var locationLat:String!
    var locationLong:String!
    let locationManager = CLLocationManager()
    var city: String!
    var street: String!
    var status: Bool!
    
    
    
    
    //MARK: - Location controller
    
    //controls of locations requests for user
    func requestAuthorizationForLocationServices(){
        switch (CLLocationManager.authorizationStatus()){
        case .NotDetermined:
            //            PFUser.currentUser()!["isTracked"] = true
            //            PFUser.currentUser()?.saveInBackground()
            self.locationManager.requestWhenInUseAuthorization()
            self.status = true
            break
        case .Denied:
            
            //            PFUser.currentUser()!["isTracked"] = false
            //            PFUser.currentUser()?.saveInBackground()
            
            self.status = false
            break
            
        case .AuthorizedAlways:
            self.status = true
            
            //            PFUser.currentUser()!["isTracked"] = true
            //            PFUser.currentUser()?.saveInBackground()
            
            
            //self.canBeTracked = true
            print("sempre autorizado")
            break
        case .AuthorizedWhenInUse:
            //
            //            PFUser.currentUser()!["isTracked"] = true
            //            PFUser.currentUser()?.saveInBackground()
            
            
            self.status = true
            //self.canBeTracked = true
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
    //    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //
    //        print(locations)
    //    }
    //
    //    //delegate method
    //    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    //        print("Erro : " + error.localizedDescription)
    //    }
    
    
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        self.locationLat = "\(locValue.latitude)"
        self.locationLong = "\(locValue.longitude)"
        
        //let positionToLoad = CLLocationCoordinate2D (latitude: locValue.latitude, longitude: locValue.longitude)
        
        
        
        
        print("locations = latitude = \(locValue.latitude), logitude = \(locValue.longitude)")
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: { (placemarks, error) -> Void in
            if error != nil{
                print("Erro: " + error!.localizedDescription)
                return
            }
            
            if(placemarks!.count > 0){
                let pm = placemarks![0] //as! CLPlacemark
//                self.displayLocationInfo(pm)
            }
        })
    }
    
    //Show the user location if  is  connected on internet
    func displayLocationInfo(placemark: CLPlacemark){
        self.locationManager.stopUpdatingLocation()
        
        //informaçoes de teste
        print("Cidade: " + placemark.locality!)
        print("Rua Avenida: " + placemark.thoroughfare!)
        print(placemark.postalCode)
        print("Estado: " + placemark.administrativeArea!)
        print(placemark.country)
        
        self.city = placemark.locality
        self.street = placemark.thoroughfare
        
        
    }
    //delegate method to show errors
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Erro : " + error.localizedDescription)
    }
    
    
    
    
    
    
    //MARK: - user preferences
    func readTrackingOptions()->Bool{
        let user = PFUser.currentUser()
        print("current USer \(user)")
        print("Tracked?: ",user?["isTracked"])
        
        if((user?.valueForKey("isTracked"))! as! NSObject == 1){
            return true
        }else{
            return false
        }
        
    }
    
    
    
    
    
    
}