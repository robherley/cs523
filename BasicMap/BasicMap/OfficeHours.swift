//
//  OfficeHours.swift
//  BasicMap
//
//  Created by Robert Herley on 3/4/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

// Most of the code in this file was based on Pokestop.swift that was provided in Canvas as the MapKitTest.zip example
import Foundation
import MapKit
import Contacts

class OfficeHours: NSObject, MKAnnotation {
    let ta : String
    let locationName: String
    let course: String
    let coordinate: CLLocationCoordinate2D
    let pinTintColor = MKPinAnnotationView.purplePinColor()
    
    var title: String? {
        return "\(ta) - \(course)"
    }
    
    var subtitle: String? {
        return locationName
    }
    
    init(ta: String, locationName: String, course: String, coordinate: CLLocationCoordinate2D) {
        self.ta = ta
        self.locationName = locationName
        self.course = course
        self.coordinate = coordinate
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}

