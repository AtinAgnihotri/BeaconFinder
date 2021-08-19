//
//  ViewController.swift
//  BeaconFinder
//
//  Created by Atin Agnihotri on 19/08/21.
//

import CoreLocation
import UIKit




class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var distanceLabel: UILabel!
    var locationManager: CLLocationManager?
    var locationState: LocationStates! {
        didSet {
            let location = locationState.rawValue
            distanceLabel.text = location.name
            view.backgroundColor = location.color
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
        locationState = .unknown
    }
    
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .authorizedAlways {
            
        }
    }
    
}

