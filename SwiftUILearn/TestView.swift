//
//  TestView.swift
//  SwiftUILearn
//
//  Created by QinY on 17/7/2024.
//

import SwiftUI

@Observable
class User:Codable {
    
    enum CodingKeys:String,CodingKey {
        case _name = "name"
        case _email = "email"
    }
    
    var name = "Toylor"
    var email = "Toylor@gmail.com"
}


struct  Response:Codable {
    var results:[Result]
}

struct Result:Codable {
    var trackId:Int
    var trackName:String
    var collectionName:String
}


struct TestView: View{
    let title:String
    
    @State private var username = ""
    @State private var email = ""
    @State private var tapCount = 0
    var disableFrom:Bool {
        username.count == 0 || email.count == 0
    }
    
    @State private var results = [Result]()
    
    
    var body: some View {
        Text(title)
        
        
        
        NavigationStack{
            
            Form {
                Section {
                    TextField("username",text: $username)
                    TextField("email",text: $email)
                }
                Section {
                    Button("Create account"){
                        print("create accmount")
                        let user = User()
                        user.name = username
                        user.email = email
                        
                        encodeUser(user: user)
                    }
                }
                .disabled(disableFrom)
    //            .disabled(username.isEmpty || email.isEmpty)
                
                Section {
                    Button("Tap count\(tapCount)") {
                        tapCount += 1
                    }
    //                .sensoryFeedback(.impact(weight: .heavy,intensity: 0.5), trigger: tapCount)
    //                .sensoryFeedback(.impact(weight: .light,intensity: 1), trigger: tapCount)
    //                .sensoryFeedback(.impact(weight: .medium,intensity: 0.8), trigger: tapCount)
                    .sensoryFeedback(.increase, trigger: tapCount)
                }
                
                
                
            }
            
            List(results,id: \.trackId){item in
                VStack(alignment:.leading){
                    HStack{
                        
                        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
                            if let image = phase.image {
                                image
                                .resizable()
                                .scaledToFit()
                            }else if phase.error != nil {
                                Text("There was an error loading the image")
                            }else {
                                ProgressView()
                            }

                        }
                        .frame(width: 200,height: 200)
                        .background(Color.cyan)
                        .clipShape(.rect(cornerRadius: 20))
                            
                            
                            
                    }
                    Text(item.trackName).font(.headline)
                    Text(item.collectionName)
                }
                
            }
            .navigationTitle(title)
            .listStyle(.plain)
            .task {
                await loadData()
            }
            
        }
        
        
    }
    
    func encodeUser(user:User){
        let data = try!JSONEncoder().encode(user)
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("url")
            return
        }
        
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try?JSONDecoder().decode(Response.self, from: data){
                results =  decodedResponse.results
            }
        } catch {
            print("invalid data")
        }
                
    }
}

#Preview {
    TestView(title: String())
}
