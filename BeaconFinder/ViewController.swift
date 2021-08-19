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
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    print("Start Scanning")
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        // It's pretty safe to force unwrap this as this is known Apple test UUID
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        
        let beaconRegion = CLBeaconRegion(uuid: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(satisfying: beaconRegion.beaconIdentityConstraint)
    }
    
    func update(distance: CLProximity) {
        UIView.animate(withDuration: 1) { [weak self] in
            switch distance {
            case .unknown:
                self?.locationState = .unknown
                
            case .far:
                self?.locationState = .far
                
            case .near:
                self?.locationState = .near
                
            case .immediate:
                self?.locationState = .rightHere
                
            default:
                self?.locationState = .unknown
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRange beacons: [CLBeacon], satisfying beaconConstraint: CLBeaconIdentityConstraint) {
        print("Recieving Notifs: \(beacons)")
        
        if let beacon = beacons.first {
            print("Found beacon: \(beacon)")
            update(distance: beacon.proximity)
        } else {
            update(distance: .unknown)
        }
    }
    
}

