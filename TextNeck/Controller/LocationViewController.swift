//
//  LocationViewController.swift
//  TextNeck
//
//  Created by Jinwook Huh on 2021/05/03.
//

import UIKit
import CoreLocation
import MapKit

class LocationViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var recentLocations: [MKPointAnnotation] = []
    
    private lazy var locationManager: CLLocationManager = {
      let manager = CLLocationManager()
      manager.desiredAccuracy = kCLLocationAccuracyBest
      manager.delegate = self
      manager.requestAlwaysAuthorization()
      manager.allowsBackgroundLocationUpdates = true
      return manager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      guard let mostRecentLocation = locations.last else {
        return
      }
      
      // Add another annotation to the map.
      let annotation = MKPointAnnotation()
      annotation.coordinate = mostRecentLocation.coordinate
      
      // Also add to our map so we can remove old values later
      self.recentLocations.append(annotation)
      
      // Remove values if the array is too big
        while self.recentLocations.count > 50 {
        let annotationToRemove = self.recentLocations.first!
        self.recentLocations.remove(at: 0)
        
        // Also remove from the map
        mapView.removeAnnotation(annotationToRemove)
      }
      
        
      if UIApplication.shared.applicationState == .active {
        mapView.showAnnotations(self.recentLocations, animated: true)
      } else {
        print("App is backgrounded. New location is %@", mostRecentLocation)
      }
    }
}
