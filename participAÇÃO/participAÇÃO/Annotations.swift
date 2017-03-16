//
//  Annotations.swift
//  ParticipACAO
//
//  Created by Rodrigo A E Miyashiro on 11/30/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import UIKit
import MapKit

class Annotations: NSObject, MKAnnotation {

    var title: String?
    var subtitle: String?
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    init(latitude: Double, longitude: Double, title: String, subtitle: String) {
        self.latitude = latitude
        self.longitude = longitude
        
        self.title = title
        self.subtitle = subtitle
    }
}
