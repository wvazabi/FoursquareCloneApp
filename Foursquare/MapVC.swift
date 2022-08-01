//
//  MapVC.swift
//  Foursquare
//
//  Created by Enes Kaya on 1.08.2022.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    
    var locationManager = CLLocationManager()
       
       var annotationTitle = ""
       var annotationSubtitle = ""
       var annotationLongitude = ""
       var annotationLatitude = ""
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
              mapView.delegate = self
              locationManager.delegate = self
              locationManager.desiredAccuracy = kCLLocationAccuracyBest
              locationManager.requestWhenInUseAuthorization()
              locationManager.startUpdatingLocation()
              
              let gesterRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gesterRecognizer:)))
              gesterRecognizer.minimumPressDuration = 2
              mapView.addGestureRecognizer(gesterRecognizer)
        
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "<-Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        // Do any additional setup after loading the view.
    }

    @objc func saveButtonClicked(){
        
        let object = PFObject(className: "Places")
        
        let placeModel = PlaceModel.sharedInstance
        
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placetype
        object["atmosphere"] = placeModel.placeAtmosphere
        object["longitude"] = self.annotationLongitude
        object["latitude"] = self.annotationLatitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
            
            object.saveInBackground { success, error in
                if error != nil {
                    
                }
                else{
                    self.performSegue(withIdentifier: "toSaveAddPlace", sender:  nil)
                }
            }
        }
        
        
        
    }
    
    @objc func backButtonClicked(){
        
        self.dismiss(animated: true)
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = CLLocationCoordinate2D(latitude:locations[0].coordinate.latitude , longitude: locations[0].coordinate.longitude)
        let span     = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region   = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func chooseLocation(gesterRecognizer : UILongPressGestureRecognizer){
        
        if gesterRecognizer.state == .began {
            
            let touchPoint = gesterRecognizer.location(in: self.mapView)
            let touchCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            
           
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placetype
            self.mapView.addAnnotation(annotation)
            
            self.annotationLatitude = String(touchCoordinates.latitude)
            self.annotationLongitude = String(touchCoordinates.longitude)
            
            
            
        }
        
        
        
    }
    
}
