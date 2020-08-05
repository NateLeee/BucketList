//
//  MKPointAnnotation.swift
//  BucketList
//
//  Created by Nate Lee on 8/5/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation
import MapKit


extension MKPointAnnotation {
    static var example: MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.title = "London"
        annotation.subtitle = "Home to the 2012 Summer Olympics."
        annotation.coordinate = CLLocationCoordinate2D(latitude: 51.5, longitude: -0.13)
        
        return annotation
    }
}
