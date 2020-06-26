//
//  ContentView.swift
//  FurnitureApp
//
//  Created by Aakash on 26/06/2020.
//  Copyright © 2020 Aakash. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab = 0
    var body: some View {
        TabBar()
    }
}

struct Home:View{
    let chairs: [Chair] = [.init(name: "Sofa Chair", price: "$350", image: "r1"),
                           .init(name: "Park bench", price: "$320", image: "r2"),
                           .init(name: "Cantilever chair", price: "$320", image: "r3"),
                           .init(name: "Wing chair", price: "$120", image: "r4"),
                           .init(name: "Deck chair", price: "$500", image: "r5"),
                           .init(name: "Desk chair", price: "$1230", image: "r6")]
    
    
    
    @Environment(\.colorScheme) var scheme
    @State private var search = ""
    
    var body: some View{
        let data = chairs.collection(into: 2)
        
        return VStack {
            getHeader()
            ScrollView(.vertical, showsIndicators: false){
                
                VStack(){
                    getSearchBar()
                    
                    HStack(){
                        Text("Today's Pick").font(.title).bold().padding(10)
                        Spacer()
                    }
                    
                    VStack{
                        Image("chair").resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 50, height: UIScreen.main.bounds.width - 50 )
                            .padding(.bottom, -40)
                        Text("Arm Chair").font(.title).bold()
                        Text("$1000").padding(10)
                        
                    }.background(Color.primary.opacity(0.1)
                        .cornerRadius(20)
                        .padding(.top, 90))
                    
                    HStack(){
                        Text("Recommeded for You").font(.title).bold().padding(10)
                        Spacer()
                    }.padding(.top)
                    
                    ForEach(0 ..< data.count){ row in
                        HStack{
                            Spacer()
                            ForEach(data[row]) { item in
                                ChairItemView(chair: item)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    fileprivate func getHeader() -> some View {
        return ZStack{
            HStack(spacing:15){
                Button(action: {
                    
                }){
                    Image("menu").foregroundColor(.primary)
                }.frame(width: 30, height: 30)
                
                Spacer()
                
                Button(action: {
                    
                }){
                    Image("qr").foregroundColor(.primary)
                }.frame(width: 30, height: 30)
                
                Button(action: {
                    UIApplication.shared.windows.first?.overrideUserInterfaceStyle = self.scheme == .dark ? .light : .dark
                }){
                    Image(systemName: scheme == .dark ? "sun.max.fill" : "moon.fill").foregroundColor(.primary)
                }.frame(width: 30, height: 30)
                
                
            }
            VStack{
                Text("Furniture").font(.title).bold()
            }
        }.padding()
    }
    
    fileprivate func getSearchBar() -> some View {
        return HStack(spacing : 15){
            TextField("Search", text: $search)
            
            if search != ""{
                Button(action: {
                    
                }){
                    Image("search").foregroundColor(.primary)
                }
            }
            
        }.padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color.primary.opacity(0.05))
            .cornerRadius(12)
            .padding([.leading, .trailing], 5)
    }
    
}

struct Search:View{
    var body: some View{
        VStack {
            Text("Search")
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
struct Cart:View{
    var body: some View{
        VStack {
            Text("Cart")
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
struct Account:View{
    var body: some View{
        VStack {
            Text("Account")
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ChairItemView: View{
    
    var chair:Chair
    
    var body: some View{
        
        VStack{
            Image(chair.image)
            Text(chair.name)
                .font(.headline).bold()
            Text(chair.price)
                .font(.headline)
                .foregroundColor(Color.primary.opacity(0.7))
        }.padding(5)
            .background(Color.primary
                .opacity(0.1)
                .cornerRadius(10))
    }
}

struct TabBar: View{
    
    @State private var index = 0
    @Environment(\.colorScheme) var scheme
    var body: some View{
        
        VStack{
            ZStack{
                Home().opacity(index == 0 ? 1 : 0)
                Search().opacity(index == 1 ? 1 : 0)
                Cart().opacity(index == 2 ? 1 : 0)
                Account().opacity(index == 3 ? 1 : 0)
            }
            
            HStack{
                TabItem(selfIndex: 0, iconName: "home", SelectedIndex: $index)
                Spacer(minLength: 0)
                TabItem(selfIndex: 1, iconName: "search", SelectedIndex: $index)
                Spacer(minLength: 0)
                TabItem(selfIndex: 2, iconName: "cart", SelectedIndex: $index)
                Spacer(minLength: 0)
                TabItem(selfIndex: 3, iconName: "account", SelectedIndex: $index)
                Spacer(minLength: 0)
                
            }.padding(.horizontal, 25)
                .padding(.top)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 10 : 0)
                .background(scheme == .dark ? Color.black : Color.white)
                .shadow(color: Color.primary.opacity(0.08), radius: 5, x: 5, y: -5)
            
        }
    }
}
struct TabItem : View{
    
    var selfIndex:Int
    var iconName: String
    @Binding var SelectedIndex:Int
    
    var body: some View{
        
        Button(action: {
            withAnimation(.easeIn) {
                self.SelectedIndex = self.selfIndex
            }
            
        }){
            HStack(spacing: 6){
                Image(iconName)
                    .foregroundColor(selfIndex == SelectedIndex ? .white : .primary)
                
                if SelectedIndex == selfIndex{
                    Text(iconName)
                        .foregroundColor(.white)
                }
            }
            .padding([.top, .bottom], 10)
            .padding(.horizontal)
            .background(SelectedIndex == selfIndex ? Color("Color") : .clear)
            .clipShape(Capsule())
        }
    }
}

struct Chair: Identifiable{
    var id = UUID()
    var name:String
    var price:String
    var image:String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
