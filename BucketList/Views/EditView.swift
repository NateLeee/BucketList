//
//  EditView.swift
//  BucketList
//
//  Created by Nate Lee on 8/6/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
            }
            .navigationBarTitle("Edit This Place")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
