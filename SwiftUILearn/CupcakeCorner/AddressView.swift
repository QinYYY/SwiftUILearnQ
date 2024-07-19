//
//  AddressView.swift
//  SwiftUILearn
//
//  Created by QinY on 17/7/2024.
//

import SwiftUI


struct AddressView: View {
    
    @Bindable var order:Order
    
    
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    TextField("Name",text: $order.name)
                    TextField("Street Address",text: $order.streetAddress)
                    TextField("City",text: $order.city)
                    TextField("Zip",text: $order.zip)
                }
                Section {
                    NavigationLink("Check out"){
                        CheckoutView(order: order)
                    }
                }
                .disabled(order.hasValidAddress == false)
            }
            .navigationTitle("AddressView")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

struct CheckoutView:View {
    var order:Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingNoInternet = false
    var body: some View {
        ScrollView {
            VStack {
                
                AsyncImage(url: URL(string: "https:hws.dev/img/cupcakes@3x.jpg"),scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .padding(10)
                .clipShape(.rect(cornerRadius: 10))
                
                Text("Your total is \(order.cost,format: .currency(code: "USD"))").font(.title)
                Button("Place Order", action: {
                    
                    Task{
                        await placeOrder()
                    }
                    
                })
                    .padding()
                
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("ok"){}
                   
        } message: {
            Text(confirmationMessage)
        }
        .alert("No network", isPresented: $showingNoInternet) {
            Button("Ok"){
                
            }
        } message: {
            Text("No Network now")
        }
    }
    
    func placeOrder() async {
        
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
        
        
        do {
            let (data,_) = try await URLSession.shared.upload(for: request, from: encodedData)
                
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                showingConfirmation = true
            
        } catch {
            showingNoInternet = true
            print("Checkout failed")
        }
        
    }
    
    
}


#Preview {
    AddressView(order: Order())
}
