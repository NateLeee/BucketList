//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Nate Lee on 8/6/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown Title"
        }
        
        set {
            self.title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown Title"
        }
        
        set {
            self.subtitle = newValue
        }
    }
}
