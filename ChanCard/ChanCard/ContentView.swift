//
//  ContentView.swift
//  ChanCard
//
//  Created by Chan Jung on 11/4/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            Color(red: 0.2, green: 0.6, blue: 0.86, opacity: 1.0)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("profile")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200,height: 200)
                    .scaleEffect(x: 2,y: 2,anchor: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white,lineWidth: 6))
                Text("Chan Jung")
                    .bold()
                    .font(Font.custom("Staatliches-Regular", size: 40)) // you need to add "Fonts provided by app" at info.plist, and add the font name in it
                    .foregroundColor(.white)
            Text("iOS Enginner")
                .foregroundColor(.white)
                .font(.system(size: 25))
                .bold()
                Divider()
                Capsule()
                    .frame(width: 330, height: 90)  // use frame to change size
                    .colorInvert()
                    .overlay(
                        VStack{
                            HStack{
                                Image(systemName: "phone.fill")
                                Text("(206) 735 1194")
                            }
                            Text("www.github.com/ckse93")
                            Text("ckse93@gmail.com")
                        }
                )
                
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
