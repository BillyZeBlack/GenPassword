//
//  HomePage.swift
//  GenPassword
//
//  Created by williams saadi on 05/10/2022.
//

import SwiftUI

struct LaunchPage: View {
    @State var timerFinish = false
    
    var body: some View {
        VStack(spacing: 25) {
            if timerFinish {
                ContentView()
            } else {
                VStack {
                    Spacer()
                    TextShimmer(text: "GenP@sswØrd")
                        .preferredColorScheme(.dark)
                    Spacer()
                    Image("slice of digital - NB - fond noir")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width, height: 100)
                }
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            timerFinish = true
            })
        }
    }
}

struct launchPage_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPage()
    }
}
