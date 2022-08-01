//
//  AddPlaceVC.swift
//  Foursquare
//
//  Created by Enes Kaya on 1.08.2022.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    
    @IBOutlet weak var placeTypeText: UITextField!
    
    @IBOutlet weak var placeAtmosphereText: UITextField!
    
    
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        placeImageView.isUserInteractionEnabled = true
                      
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addPic))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
        
        
    }
    
    @objc func addPic(){
                
                let picker = UIImagePickerController()
                picker.delegate = self
                picker.allowsEditing = true
                picker.sourceType = .photoLibrary
                present(picker, animated: true, completion: nil)
                
                
            }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
        placeImageView.image = info[.originalImage] as? UIImage
           self.dismiss(animated: true, completion: nil)
           
       }
    
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != ""{
            if let chosenImage = placeImageView.image{
             
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeImage = chosenImage
                placeModel.placetype = placeTypeText.text!
                placeModel.placeName = placeNameText.text!
                placeModel.placeAtmosphere = placeAtmosphereText.text!
                
            }
            performSegue(withIdentifier: "toMapVC", sender: nil )
        }
        else{
            
            alertPopUp(titleInput: "Error!", messageInput: "Place / Name / Type / Atmosphere / Image ??")
            
        }
        
   
    }
    
    func alertPopUp(titleInput:String, messageInput:String){
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    
}
