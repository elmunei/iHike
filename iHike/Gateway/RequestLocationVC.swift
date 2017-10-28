//
//  RequestLocationVC.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 10/26/17.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit
import CoreLocation

class RequestLocationVC: UIViewController,CLLocationManagerDelegate {

    
    var locationTxt = ""
    
    // MARK: - Location
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //MARK: Location Button
    
    @IBAction func requestLocationAccess(_ sender: UIButton) {
        
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            getLocation()

        case .notDetermined:
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            getLocation()

        case .denied:
            print("not available")

        case .restricted:
            //nothing I can do
            break
            
        }
        
    }
    
    
    // MARK: Location Functions
    func getLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    // MARK: CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            if let placemarksData = placemarks {
                let locationData = placemarksData[0]
                let city = locationData.locality!
                let country = locationData.country!
                
                let location = "\(city), \(country)"
                
                self.locationTxt = location
                print(location)
            } else {
                self.locationTxt = "location unavailable"
                print("Error: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    

}
