//
//  Extensions.swift
//  AccommodationApp
//
//  Created by Simon Bestler on 08.12.22.
//

import Foundation
import CoreData
import UIKit
import SwiftUI

@MainActor
extension Accomodation {
    

    
    //Sets ID automatically, when new Accomodation is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
        setPrimitiveValue(false, forKey: "isFavourite")
    }
    
    func toogleFavourite() {
        self.isFavourite.toggle()
        try? self.managedObjectContext?.save()
        print(self.isFavourite)
        
    }
    

    static func createNewAccommodation(viewContext : NSManagedObjectContext, title : String, description_text : String, rent_cost : String, extra_cost : String, deposit : String, agency_fee : String, isVisitPossible : Bool, appointment_date : Date, url : String, ownerName : String, ownerPhoneNumber : String, typeOfAccommodation : String){
        
        let newAccomodation = Accomodation(context: viewContext)
        newAccomodation.title = title
        newAccomodation.description_text = description_text
        newAccomodation.rent_cost = Int64(rent_cost) ?? 0
        
        if extra_cost != "", let extra_cost = Int64(extra_cost) {
            newAccomodation.extra_cost = extra_cost
        }
        
        if deposit != "", let deposit = Int64(deposit) {
            newAccomodation.deposit = deposit
        }
        
        if agency_fee != "", let agency_fee = Int64(agency_fee){
            newAccomodation.agency_fee = agency_fee
        }
        
        newAccomodation.isVisitPossible = isVisitPossible
        
        // Create new accommodation
        newAccomodation.appointment = Appointment(context: viewContext)
        newAccomodation.appointment?.date = appointment_date
        
        newAccomodation.url = URL(string: url)
        
        if ownerName != "" {
            newAccomodation.contact_name = ownerName
        }
        
        if ownerPhoneNumber != "" {
            newAccomodation.contact_phone = ownerPhoneNumber
        }
        
        newAccomodation.type = typeOfAccommodation
        
        //TODO: Replace with Loop threw Array with pictures from Form
        let img = UIImage(systemName: "photo")
        let photo = Photo(context: viewContext)
        photo.image = img?.pngData()
        newAccomodation.addToPhotos(photo)
        
        try? viewContext.save()
        
    }
    
    // Possiblity to make sure no optionals
    var wrappedTitle : String {
        title ?? ""
    }
    
    var wrappedPhotos : [Photo] {
        return Photo.toArray(self.photos)
    }
    
}

extension Appointment {
    //Sets ID automatically, when new Appointment is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
    }
}


extension Photo {
    //Sets ID automatically, when new Appointment is created
    public override func awakeFromInsert() {
        setPrimitiveValue(UUID(), forKey: "id")
    }
    
    var wrappedImage : Image {
        if let image = self.image, let uiImage =  UIImage(data: image) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "photo")
    }
    
    public static func toArray(_ photos: NSSet?) -> [Photo] {
        if let photos = photos {
            return photos.allObjects as! [Photo]
        }
        else {
            return []
        }
    }
    
}


