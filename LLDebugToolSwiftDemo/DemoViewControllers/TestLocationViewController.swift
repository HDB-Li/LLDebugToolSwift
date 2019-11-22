//
//  TestLocationViewController.swift
//  LLDebugToolSwiftDemo
//
//  Created by admin10000 on 2019/11/22.
//

import UIKit

import MapKit

import LLDebugTool

class TestLocationAnnotation: NSObject, MKAnnotation {
    public var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
}

class TestLocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    private lazy var mapView : MKMapView = {
        let view = MKMapView()
        view.showsUserLocation = true
        view.delegate = self
        return view
    }()
    
    private lazy var annotation : TestLocationAnnotation = {
        return TestLocationAnnotation()
    }()
    
    private lazy var toastLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Lat & Lng : 0, 0"
        return label
    }()
    
    private lazy var manager : CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("test.location", comment: "")
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(testMockLocation))
        
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.toastLabel)
        self.manager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let navigationBarHeight = self.navigationController!.navigationBar.frame.origin.y + self.navigationController!.navigationBar.frame.height
        self.toastLabel.frame = CGRect(x: 0, y: navigationBarHeight, width: self.view.frame.width, height: 80)
        self.mapView.frame = CGRect(x: 0, y: navigationBarHeight + 80, width: self.view.frame.width, height: self.view.frame.size.height - navigationBarHeight - 80)
    }
    
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print(#function + "\(userLocation)")
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function + "\(locations)")
        guard let location = locations.first else { return }
        self.annotation.coordinate = location.coordinate
        if (self.mapView.annotations as NSArray).contains(self.annotation) == false {
            self.mapView.addAnnotation(self.annotation)
            self.mapView.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.05, 0.05))
        } else {
            self.mapView.centerCoordinate = location.coordinate
        }
        self.toastLabel.text = String(format: "Lat & Lng : %0.6f, %0.6f", location.coordinate.latitude, location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.toastLabel.text = "Failed"
        print(#function + "\(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print(#function)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
    // MARK: - Event responses
    @objc private func testMockLocation() {
        LLDebugTool.shared().execute(.location)
    }

}
