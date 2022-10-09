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
        VStack{
            if timerFinish {
                ContentView()
            } else {
                Text("fsdfsdf")
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            timerFinish = true
            })
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPage()
    }
}
