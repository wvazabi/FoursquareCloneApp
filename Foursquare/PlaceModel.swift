//
//  PlaceModel.swift
//  Foursquare
//
//  Created by Enes Kaya on 1.08.2022.
//

import Foundation
import UIKit

class PlaceModel{
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placetype = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    
    private init (){}
}
