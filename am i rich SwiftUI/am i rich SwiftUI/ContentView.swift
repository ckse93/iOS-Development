//
//  ContentView.swift
//  am i rich SwiftUI
//
//  Created by Chan Jung on 11/3/19.
//  Copyright © 2019 Chan Jung. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{  // stacking element component on top of each other
            Color(red:0.5,green:0.5,blue:0.5).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            // or you can use
            //Color(.systemTeal)
            VStack {
                Text("I am rich")
                    .font(.system(size: 45))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Image("diamond")
                    .resizable().aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200, alignment: .center)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone Xʀ")  // option+click previewDevice property to see all the listing
    }
}
