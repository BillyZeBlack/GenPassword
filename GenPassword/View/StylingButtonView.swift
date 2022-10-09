//
//  StylingButtonView.swift
//  GenPassword
//
//  Created by williams saadi on 09/10/2022.
//

import SwiftUI

struct StylingButtonView: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .frame(maxWidth: .infinity, minHeight: 55)
                .background(.clear)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.5 : 1)
                .animation(.easeOut(duration: 0.5), value: configuration.isPressed)
                .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 3))
        
        }
}

