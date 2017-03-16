//
//  ApagarTestAlfinetes.swift
//  ParticipACAO
//
//  Created by Rodrigo A E Miyashiro on 12/1/15.
//  Copyright © 2015 Evandro Henrique Couto de Paula. All rights reserved.
//

import Foundation
import MapKit

class ApagarTestAlfinetes {
    
    var someLocations: [NSDictionary] = []
    
    init () {
        // Test - Alguns endereços...
        let me         = ["latitude": -23.609450, "longitude": -46.607847, "title" : "Eu", "subtitle": "sei la"]
        let ofina      = ["latitude": -23.609268, "longitude": -46.609338, "title" : "oficna", "subtitle": "sei la"]
        let escola     = ["latitude": -23.607292, "longitude": -46.608072, "title" : "escola", "subtitle": "sei la"]
        let motos      = ["latitude": -23.611854, "longitude": -46.607858, "title" : "motos", "subtitle": "sei la"]
        let lanchonete = ["latitude": -23.609224, "longitude": -46.610792, "title" : "lachonete", "subtitle": "sei la"]
        let mercado    = ["latitude": -23.607184, "longitude": -46.609939, "title" : "mercado", "subtitle": "sei la"]
        
        someLocations.append(me)
        someLocations.append(ofina)
        someLocations.append(escola)
        someLocations.append(motos)
        someLocations.append(lanchonete)
        someLocations.append(mercado)
    }
    
    func getLocations () -> [NSDictionary] {
        return someLocations
    }
}
