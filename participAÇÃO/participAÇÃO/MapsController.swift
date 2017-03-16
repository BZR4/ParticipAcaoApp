//
//  MapsController.swift
//  ParticipACAO
//
//  Created by Rodrigo A E Miyashiro on 11/30/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import MapKit

class MapsController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Variables and Constants
    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 500
    
    // Test
    let initialLocation = CLLocation(latitude: -23.609450, longitude: -46.607847)
    
    
    // MARK: - IBOutlet's
    @IBOutlet weak var mapView: MKMapView!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        checkLocationAuthorizationStatus()
        
        self.mapView.mapType = MKMapType.Standard
        self.mapView.showsUserLocation = true
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        
        //
        centerMapOnLocation(initialLocation)
        addAnnotation()
    }
    
    
    // MARK: - Set location on map center
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    // MARK: - location manager to authorize user location for Maps app
    func checkLocationAuthorizationStatus() {
        
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            self.locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    // MARK: - Annotations
    func addAnnotation () {
        let annotations = getMapAnnotations()
        for annotation in annotations {
            let newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = annotation.coordinate
            
            // TODO: PORQUE NAO ESTA APARECENDO O DETALHAMENTO????
            newAnnotation.title = annotation.title
            newAnnotation.subtitle = annotation.subtitle
            
            self.mapView.selectAnnotation(newAnnotation, animated: true)
            self.mapView.addAnnotation(newAnnotation)
        }
    }
    
    
    private func getMapAnnotations () -> [Annotations] {
        var annotations = [Annotations]()
        
        // TODO: RECEBE OS PONTOS ONDE DEVERAO SER MARCADOS NO MAPA
        // Test
        let example = ApagarTestAlfinetes()
        let items = example.someLocations
        for item in items {
            let lat = item["latitude"] as! Double
            let long = item["longitude"] as! Double
            let title = item["title"] as! String
            let subtitle = item["subtitle"] as! String
            let annotation = Annotations(latitude: lat, longitude: long, title: title, subtitle: subtitle)
            annotations.append(annotation)
        }
        
        return annotations
    }
    
    // MARK: - Change annotation color
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let annotationView = MKPinAnnotationView()
        
        if annotation.coordinate.latitude == initialLocation.coordinate.latitude && annotation.coordinate.longitude == initialLocation.coordinate.longitude {
            annotationView.pinTintColor = UIColor.redColor()
        }
        else{
            annotationView.pinTintColor = UIColor.blueColor()
        }
        annotationView.canShowCallout = true
        
        return annotationView
    }
    
}
