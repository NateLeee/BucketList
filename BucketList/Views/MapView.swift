//
//  MapView.swift
//  BucketList
//
//  Created by Nate Lee on 8/4/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import Foundation
import MapKit
import SwiftUI


struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    var annotations: [MKPointAnnotation]
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView // I used 'let' before.
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        // Delegate funcs
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
        
        /*
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let identifier = "Placemark"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                // Create one!
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            } else {
                // Reuse, may have to update the annotation inside.
                annotationView?.annotation = annotation
            }
            
            return annotationView
        }
         */
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mkMapView = MKMapView()
        mkMapView.delegate = context.coordinator
        
        // MARK: - Annotation Part
        
        
        return mkMapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if annotations.count != uiView.annotations.count {
            uiView.removeAnnotations(uiView.annotations)
            uiView.addAnnotations(annotations)
        }
    }
    
}
