//
//  ViewController.swift
//  Foursquare
//
//  Created by Enes Kaya on 28.07.2022.
//

import UIKit
import Parse


class ViewController: UIViewController {

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
        
        */
        
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
    
        
        
        
    }
    
    
    


}

