//
//  ViewController.swift
//  MapKit
//
//  Created by Robert Herley on 3/4/19.
//  Copyright © 2019 Robert Herley. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// Source: https://stackoverflow.com/questions/29731857/how-to-zoom-in-or-out-a-mkmapview-in-swift
// Extended with guards to prevent runtime exception
extension MKMapView {
    func setZoomByDelta(delta: Double, animated: Bool) {
        var _region = region;
        var _span = region.span;
        _span.latitudeDelta *= delta;
        _span.longitudeDelta *= delta;
        _region.span = _span;

        // Source: https://stackoverflow.com/questions/42516836/how-to-catch-runtime-exception-on-mapview-setregion-function
        guard (-90.0 ... 90.0).contains(_span.latitudeDelta) else {
            print("Bad Latitude: \(_span.latitudeDelta)")
            return
        }
        
        guard (-180.0 ... 180.0).contains(_span.longitudeDelta) else {
            print("Bad Longitude: \(_span.longitudeDelta)")
            return
        }
        
        setRegion(_region, animated: animated)
    }
}

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = CLLocationManager()
    private var officeHours = [OfficeHours]()
    
    @IBAction func switchLayer(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybridFlyover
        default:
            break
        }
    }
    
    @IBAction func moveToUserLocation(_ sender: UIButton) {
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func zoomView(_ sender: UIButton) {
        switch sender.currentTitle! {
        case "+":
            mapView.setZoomByDelta(delta: 0.5, animated: true)
        case "-":
            mapView.setZoomByDelta(delta: 2, animated: true)
        default:
            break
        }
    }
    
    
    func insertPins() {
        officeHours.append(OfficeHours(ta: "Rob Herley", locationName: "NB 231", course: "CS-554", coordinate: CLLocationCoordinate2DMake(40.746058, -74.025203)))
        officeHours.append(OfficeHours(ta: "Andrew Chen", locationName: "NB 231", course: "CS-546", coordinate: CLLocationCoordinate2DMake(40.746048, -74.025233)))
        officeHours.append(OfficeHours(ta: "Mijeong Ban", locationName: "NB 221", course: "CS-554", coordinate: CLLocationCoordinate2DMake(40.746140, -74.025201)))
        officeHours.append(OfficeHours(ta: "Aimal Wajihuddin", locationName: "NB 227", course: "CS-615", coordinate: CLLocationCoordinate2DMake(40.746141, -74.025125)))
        officeHours.append(OfficeHours(ta: "Albert Tang", locationName: "NB 327", course: "CS-554", coordinate: CLLocationCoordinate2DMake(40.746060, -74.025227)))
        officeHours.append(OfficeHours(ta: "Khayyam Saleem", locationName: "B 118", course: "CS-284", coordinate: CLLocationCoordinate2DMake(40.7430763,-74.027017)))
        officeHours.append(OfficeHours(ta: "Ed Minnix", locationName: "X 414", course: "CS-496", coordinate: CLLocationCoordinate2DMake(40.7425122,-74.027017)))
        officeHours.append(OfficeHours(ta: "Lisp (Uncommon)", locationName: "K 360", course: "CS-516", coordinate: CLLocationCoordinate2DMake(40.743345,-74.0267216)))
        officeHours.append(OfficeHours(ta: "Jon Pavlik", locationName: "BC 221", course: "CS-385", coordinate: CLLocationCoordinate2DMake(40.7428354,-74.0268022)))
        officeHours.append(OfficeHours(ta: "Isaac Hirschfeld", locationName: "M 231", course: "CS-385", coordinate: CLLocationCoordinate2DMake(40.7430777,-74.0268022)))
        officeHours.append(OfficeHours(ta: "Bean Iofel", locationName: "E 221", course: "CS-101", coordinate: CLLocationCoordinate2DMake(40.7423494,-74.027537)))
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .authorizedWhenInUse)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        insertPins()
        mapView.addAnnotations(officeHours)
    }
    
    
    // Code Below based on ViewController.swift that was provided in Canvas as the MapKitTest.zip example
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? OfficeHours {
            let identifier = "officeHours"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            view.pinTintColor = annotation.pinTintColor
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! OfficeHours
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    
}

