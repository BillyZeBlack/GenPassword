//
//  GenPasswordApp.swift
//  GenPassword
//
//  Created by williams saadi on 17/09/2022.
//

import SwiftUI

@main
struct GenPasswordApp: App {
    var body: some Scene {
        WindowGroup {
//            NavigationView{
                ContentView(service: ContentViewViewModel())
//                ContentView2().navigationBarTitle(Text("GenP@ssw0rd"))
//            }
        }
    }
}
