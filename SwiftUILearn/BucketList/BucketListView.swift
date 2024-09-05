//
//  BucketListView.swift
//  SwiftUILearn
//
//  Created by QinY on 2/9/2024.
//

import SwiftUI
import MapKit
import LocalAuthentication
struct BucketListView: View {
    
    
    @State private var loadingState = LoadingState.loading
    
    @State  private var position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30, longitude: 108), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta:    1)))
    
    @State private var isUnlocked = false
    
    @State private var locations = [Location]()
    static let example = Location(id: UUID(), name: "Chongqing", description: "山城", latitude: 30.899, longitude: 108.3922)
    
    
    @State private var selectedPlace:Location?
    var body: some View {
        
        
        let startPoint = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)))
        
        
        
        MapReader { proxy in
            Map(initialPosition: startPoint){
                ForEach(locations) { location in
                    
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.yellow)
                            .frame(width: 44,height: 44)
                            .background(.white)
                            .clipShape(.circle)
                            .onLongPressGesture{
                                selectedPlace = location
                                
                            }
                    }
//                    Marker(location.name,coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
            }.sheet(item: $selectedPlace, content: { place in
                EditView(location: place) { newLocation in
                    if let index = locations.firstIndex(of: place) {
                        locations[index] = newLocation
                    }
                }
            })
                .onTapGesture {position in
                    if let coordinate = proxy.convert(position, from: .local){
                        let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        locations.append(newLocation)
                    }
                }
            
        }
        
        
//        let locations = [
//            Location(name: "Buckingham Palace", corrdinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
//            Location(name: "Tower of London", corrdinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),]
        
//        VStack{
//            
//            if isUnlocked {
//                Text ("Unlocked")
//            } else {
//                Text ("Locked")
//            }
//            
//            
//            Map(position: $position){
//                ForEach(locations){location in
//                    
//                    Annotation(location.name, coordinate: location.corrdinate) {
//                        Text(location.name)
//                            .font(.headline)
//                            .padding()
//                            .background(.red)
//                            .foregroundStyle(.white)
//                            .clipShape(.capsule)
//                    }
//                    
////                    Marker(location.name,coordinate: location.corrdinate)
//                    
//                }
//            }
//                .mapStyle(.hybrid)
//                .onMapCameraChange { context in
//                    print(context.region)
//                }
//                
//            HStack(spacing: 30, content: {
//                
//                Button("Paris") {
//                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
//                    
//                }
//                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
//                
//                Button("Tokyo") {
//                    position = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
//                }
//            })
//        }.onAppear(perform: authenticate)
//        
//        switch loadingState {
//        case .loading:
//            LoadingView()
//        case .success:
//            SuccessView()
//        case .failed :
//            FailedView()
//        }
//        
//        Button("Read and Write"){
//            
//            let data = Data("Test Message".utf8)
//            let url = URL.documentsDirectory.appending(path: "message.txt")
//            
//            do {
//                try data.write(to: url,options: [.atomic,.completeFileProtection])
//                let input = try String(contentsOf: url)
//                print(input)
//            } catch {
//                print(error.localizedDescription)
//            }
//            
//        }
    }
    
    func authenticate()  {
        let context = LAContext()
        var error:NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            let reason = "We need to unlock your data"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success , authenticateError in
                if success {
                    isUnlocked = true
                } else {
                
            }
        }
        }else {
            
        }
    }
    enum LoadingState {
        case loading,success,failed
    }

    struct LoadingView:View {
        var body: some View {
            Text("Loading...")
        }
    }

    struct SuccessView:View {
        var body: some View {
            Text("Success!")
        }
    }

    struct FailedView:View {
        var body: some View {
            Text("Failed.")
        }
    }

    
}



#Preview {
    BucketListView()
}
