//
//  DetailsVC.swift
//  Foursquare
//
//  Created by Enes Kaya on 1.08.2022.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    
    @IBOutlet weak var detailsNameLabel: UILabel!
    
    @IBOutlet weak var detailsPlaceType: UILabel!
    
    @IBOutlet weak var detailsPlaceAtmosphere: UILabel!
    
    @IBOutlet weak var detailsMapView: MKMapView!
    
    
    var chosenId = ""
    
    var chosenLatitude = Double()
    
    var chosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        detailsMapView.delegate = self
    }
    
    func getDataFromParse(){
        
        let query = PFQuery(className: "Places")
        
        query.whereKey("objectId", equalTo:  chosenId)
        query.findObjectsInBackground { object, error in
            if error != nil{
                
                self.alertPopUp(titleInput: "Error", messageInput: error?.localizedDescription ?? "error!")
                
            } else {
                if object != nil {
                    if object!.count > 0 {
                        let chosenPlaceObject = object![0]
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String{
                            self.detailsNameLabel.text = placeName
                            
                        }
                        if let typeName = chosenPlaceObject.object(forKey: "type") as? String{
                            self.detailsPlaceType.text = typeName
                            
                        }
                        
                        if let atmosphereName = chosenPlaceObject.object(forKey: "atmosphere") as? String{
                            self.detailsPlaceAtmosphere.text = atmosphereName
                            
                        }
                        
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String{
                            if let placeLatitudeDouble = Double(placeLatitude) {
                                self.chosenLatitude = placeLatitudeDouble
                            }
                            
                        }
                        
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String{
                            if let placeLongitudeDouble = Double(placeLongitude) {
                                self.chosenLongitude = placeLongitudeDouble
                            }
                            
                        }
                        
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject{
                            imageData.getDataInBackground { data, error in
                                if error == nil {
                                    self.detailsImageView.image = UIImage(data: data!)
                                    
                                }
                            }
                        }
                        
                        
                        
                    }
                    
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                                           
                                           let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                                           
                                           let region = MKCoordinateRegion(center: location, span: span)
                                           
                                           self.detailsMapView.setRegion(region, animated: true)
                                           
                                           let annotation = MKPointAnnotation()
                                           annotation.coordinate = location
                                           annotation.title = self.detailsNameLabel.text!
                                           annotation.subtitle = self.detailsPlaceType.text!
                                           self.detailsMapView.addAnnotation(annotation)
                                           
                    
                    
                }
                
            }
            
            
        }
        
    }
    
    func alertPopUp(titleInput:String, messageInput:String){
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    
    

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                    
                }
            }
            
        }
    }
   

}
