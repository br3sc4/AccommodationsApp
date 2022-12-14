//
//  MapView.swift
//  AccommodationApp
//
//  Created by Lorenzo Brescanzin on 08/12/22.
//

import SwiftUI
import CoreData
import CoreLocation

struct MapView: View {
    @StateObject private var vm: MapViewModel = MapViewModel()
    @State private var showAddPoISheet: Bool = false
    
    @FetchRequest(sortDescriptors: [])
    private var accommodations: FetchedResults<Accomodation>
    
    @FetchRequest(sortDescriptors: [])
    private var pointsOfInterest: FetchedResults<PointOfInterest>
    
    var body: some View {
        NavigationStack {
            MapViewRepresentable(region: $vm.region,
                                 accommodations: Array(accommodations),
                                 pointsOfInterest: Array(pointsOfInterest),
                                 selectedAccommodation: $vm.selectedAccommodation,
                                 locationManager: vm.locationManager)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddPoISheet.toggle()
                    } label: {
                        Label("Add Point of Interest", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddPoISheet) {
                        AddPoIView()
<<<<<<< HEAD
=======
                            .presentationDetents([.medium])
>>>>>>> 4f3ddae (Project renaming)
                    }
                }
            }
            .alert(vm.alertContent.title, isPresented: $vm.showAlert) {
                Button("Cancel", role: .cancel) {
                    vm.showAlert.toggle()
                }
            } message: {
                Text(vm.alertContent.message)
            }
            .sheet(item: $vm.selectedAccommodation) { accommodation in
<<<<<<< HEAD
                AccommodationSheetView(accommodation: accommodation,
                                       userLocation: vm.userLocation)
=======
                AccommodationSheetView(accommodation: accommodation, userLocation: vm.userLocation)
>>>>>>> 4f3ddae (Project renaming)
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .previewDevice("iPhone 14 Pro")
        
        MapView()
            .previewDevice("iPad Air (5th generation)")
    }
}
<<<<<<< HEAD
=======

struct AccommodationSheetView: View {
    private let accommodation: Accomodation
    private let userLocation: CLLocation
    
    @FetchRequest(sortDescriptors: [])
    private var pointsOfInterest: FetchedResults<PointOfInterest>
    
    init(accommodation: Accomodation, userLocation: CLLocation) {
        self.accommodation = accommodation
        self.userLocation = userLocation
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    if let image = accommodation.card_cover, let uiImage = UIImage(data: image) {
                        VStack{
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                        }.frame(width: 180, height: 150)
                            .clipShape(Rectangle())
                            .shadow(radius: 2)
                            .cornerRadius(14)
                    } else {
                        
                        VStack{
                            Image("ph1")
                                .resizable()
                                .scaledToFill()
                        }.frame(width: 180, height: 150)
                            .clipShape(Rectangle())
                            .shadow(radius: 2)
                            .cornerRadius(14)
                    }
                    
                    VStack{
                        VStack {
                            Text("Type")
                                .font(.headline)
                            Text(accommodation.type?.capitalized ?? "No type provided")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        VStack {
                            Text("Rent price")
                                .font(.headline)
                            Text(accommodation.rent_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        VStack {
                            Text("Extra costs")
                                .font(.headline)
                            Text(accommodation.extra_cost.formatted(.currency(code: "EUR").precision(.fractionLength(.zero))))
                                .font(.subheadline)
                        }
                    }
                    
                }.padding([.leading, .trailing], 10)
                
                
                
                VStack(alignment: .leading) {
                    Text("Distance from:")
                        .font(.headline)
                        .padding([.leading, .top], 15)
                    
                    List {
                        HStack {
                            Text("Current user location -")
                                .font(.subheadline)
                            Text(accommodation.distance(from: userLocation).formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: .number.precision(.fractionLength(.zero)))))
                                .font(.subheadline)
                        }
                        
                        ForEach(pointsOfInterest, id: \.id) { point in
                            HStack {
                                if let name = point.name {
                                    Text(name + " -")
                                        .font(.subheadline)
                                    Text(accommodation.distance(from: CLLocation(latitude: point.latitude, longitude: point.longitude)).formatted(.measurement(width: .abbreviated, usage: .road, numberFormatStyle: .number.precision(.fractionLength(.zero)))))
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .padding([.trailing,], 15)
                }
            }
            .frame(maxWidth: .infinity)
            .navigationTitle(accommodation.wrappedTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
>>>>>>> 4f3ddae (Project renaming)
