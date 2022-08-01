//
//  MapVC.swift
//  Foursquare
//
//  Created by Enes Kaya on 1.08.2022.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))

        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "<-Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtonClicked))
        // Do any additional setup after loading the view.
    }

    @objc func saveButtonClicked(){
        
    }
    
    @objc func backButtonClicked(){
        
        self.dismiss(animated: true)
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
