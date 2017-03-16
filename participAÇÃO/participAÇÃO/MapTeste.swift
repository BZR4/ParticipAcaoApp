//
//  MapTeste.swift
//  ParticipACAO
//
//  Created by Esdras Bezerra da Silva on 04/12/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import Parse
import MapKit

class MapTeste: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var filterView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    
    var filterViewIsVisible = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        
//        let tap = UIGestureRecognizer(target: self, action: "testTap")
//        self.containerView.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        PFGeoPoint.geoPointForCurrentLocationInBackground {
            (geoPoint: PFGeoPoint?, error: NSError?) -> Void in
            if error == nil {
                // do something with the new geoPoint
                
                let location = CLLocationCoordinate2D(latitude: (geoPoint?.latitude)!, longitude: (geoPoint?.longitude)!)
                let annotation = MyAnnotation(title: "GeoPoint", subtitle: "Subtitle GeoPoint", coordinate: location)
                
                annotation.image = UIImage(named: "custom_pin")
                
                self.mapView.addAnnotation(annotation)
                self.setCenterOfMapToLocation(location)
                
                
                
                // Create a query for places
                let query = PFQuery(className:"Topic")
                // Interested in locations near user.
//                query.whereKey("location", nearGeoPoint:geoPoint!)
                
                query.whereKeyExists("location")
                
                // Limit what could be a lot of points.
//                query.limit = 10
                // Final list of objects
                query.findObjectsInBackgroundWithBlock({ (objects, error) -> Void in
                    if error == nil {
                        for object in objects! {
                            let lat = (object.valueForKey("location")?.latitude)! as Double
                            let lon = (object.valueForKey("location")?.longitude)! as Double
                            let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                            let annotation = MyAnnotation(title: object["subject"] as! String, subtitle: "Subtitle GeoPoint", coordinate: location)
                            
                            annotation.image = UIImage(named: "custom_pin")
                            
                            
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                })
                
                
            }else{
                print("Error:",error?.userInfo)
            }
        }

    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        
        var v = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdentifier)
        if v == nil {
            v = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            v!.canShowCallout = true
        }
        else {
            v!.annotation = annotation
        }
        
//        let customPointAnnotation = annotation as! MyAnnotation
        v!.image = UIImage(named: "custom_pin")
        
        return v
    }
    
    
    @IBAction func showFilterOptions(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5) { () -> Void in
            if self.filterViewIsVisible == false {
                self.filterViewIsVisible = true
                self.filterView.alpha = 0
                
                
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.filterView.alpha = 1
                    self.filterView.hidden = false
                    
                    self.containerView.transform = CGAffineTransformMakeTranslation(0, 0)
                })
            }else{
                self.dismissFilterView()
            }
        }
        
    }
    
    func dismissFilterView(){
        UIView.animateWithDuration(1) { () -> Void in
            self.filterViewIsVisible = false
            self.filterView.alpha = 0
            self.containerView.transform = CGAffineTransformMakeTranslation(0, 600)
        }
    }
    
    @IBAction func testTap(sender: AnyObject?){
        print("Tap")
    }
    
    /* We have a pin on the map; now zoom into it and make that pin the center of the map */
    func setCenterOfMapToLocation(location: CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
        let region = MKCoordinateRegion(center: location, span: span);
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func test(sender: AnyObject) {
        print("clic!")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class MyAnnotation: NSObject, MKAnnotation {
    var title, subtitle: String?
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0.0, 0.0)
    
    var image: UIImage?
    
    init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
