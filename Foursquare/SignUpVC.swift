//
//  ViewController.swift
//  Foursquare
//
//  Created by Enes Kaya on 28.07.2022.
//

import UIKit
import Parse


class SignUpVC: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     /*
        let parseObject = PFObject(className: "Fruit")
        parseObject["Name"] = "Banana"
        parseObject["Calories"] = 150
        parseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print("uploaded")
            }
            
        }
        
       
        
        let query = PFQuery(className: "Fruit")
        
        //query.whereKey("Name", contains: "Apple")
        query.whereKey("Calories", lessThan: 130)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else{
                print(objects)
            }
        }
      
      */
        
        
    
        
        
        
    }
    
    
    func alertPopUp(titleInput:String, messageInput:String){
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
    

    @IBAction func loginButton(_ sender: Any) {
        
        
        if usernameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameText.text!, password: passwordText.text!) { user, error in
                
                
                if error != nil{
                    self.alertPopUp(titleInput: "Error!", messageInput: error?.localizedDescription ??  "Error")
                }else {
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                    
                    
                }
                
                
            }
            
            
            
            
            
        }else{
            
            alertPopUp(titleInput: "Error", messageInput: "Username / password Error!!!")
            
        }
        
        
    }
        
        
        
    
    
    
    @IBAction func signupButton(_ sender: Any) {
        
        if usernameText.text != "" && passwordText.text != "" {
            
           let user = PFUser()
            
            user.username = usernameText.text
            user.password = passwordText.text
            
            user.signUpInBackground { [self] success , error in
                if error != nil{
                    self.alertPopUp(titleInput: "Error!", messageInput: error?.localizedDescription ??  "Error")
                }else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
                
            }
            
            
        }else{
            
            alertPopUp(titleInput: "Error", messageInput: "Username / password Error!!!")
            
        }
        
    }
}
    
    
    


