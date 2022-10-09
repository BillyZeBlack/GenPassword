//
//  TogglesView.swift
//  GenPassword
//
//  Created by williams saadi on 09/10/2022.
//

import SwiftUI

struct TogglesView: View {
    @Binding var capsChecked: Bool
    @Binding var lettersChecked: Bool
    @Binding var numbersChecked: Bool
    @Binding var specialCharsChecked: Bool
    
    var body: some View {
        VStack{
            Toggle(isOn: $capsChecked) {
                Text("Majuscules")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1))
            
            Toggle(isOn: $lettersChecked) {
                Text("Minuscules")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1))
            Toggle(isOn: $numbersChecked) {
                Text("Nombres")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, lineWidth: 1))
            Toggle(isOn: $specialCharsChecked) {
                Text("Caractères spéciaux")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(.white)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray, lineWidth: 1))
        }
    }

}

struct TogglesView_Previews: PreviewProvider {
    static var previews: some View {
        TogglesView(capsChecked: .constant(true), lettersChecked: .constant(true), numbersChecked: .constant(true), specialCharsChecked: .constant(true))
    }
}
