//
//  ContentView.swift
//  GenPassword
//
//  Created by williams saadi on 17/09/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject var service: ContentViewViewModel
    @State var lenght = 8.0
    @State var passwordCopied = false
    @State private var capsChecked = false
    @State private var numbersChecked = true
    @State private var specialCharsChecked = false
    @State private var lettersChecked = false
    @State var passwordStrenghtLevel = "niveau"
    @State var progress: CGFloat = 0
    
    var body: some View {
        Text("GenP@ssw0rd")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        ScrollView {
            VStack {
                VStack {
                    VStack{
                        Text("Paramètres du mot de passe")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Toggle(isOn: $capsChecked) {
                            Text("Majuscules")
                                .font(.system(.title3, design: .rounded))
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1))
                    
                        Toggle(isOn: $lettersChecked) {
                            Text("Minuscules")
                                .font(.system(.title3, design: .rounded))
                        }                    .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1))
                        Toggle(isOn: $numbersChecked) {
                            Text("Nombres")
                                .font(.system(.title3, design: .rounded))
                        }                    .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1))
                        Toggle(isOn: $specialCharsChecked) {
                            Text("Caractères spéciaux")
                                .font(.system(.title3, design: .rounded))
                        }
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1))

                        HStack {
                            Text("\(Int(lenght))")
                            Slider(value: $lenght, in: 8...64)
                        }
                        
                        HStack {
                            Spacer()
                            if nil == service.data {
                                Text("GenP@ssw0rd")
                                    .padding()
                            } else {
                                Text(service.data)
                                    .padding()
                                    .foregroundColor(Color.blue)
                            }
                            Spacer()
                            if !passwordCopied {
                                Image(systemName: "doc.on.doc")
                                    .padding()
                                    .onTapGesture {
                                    UIPasteboard.general.setValue(self.service.data!, forPasteboardType: UTType.plainText.identifier)
                                        passwordCopied = true
                                    }
                            }else {
                                Image(systemName: "doc.on.doc.fill")
                                    .padding()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1))
                    }
                    .padding(.horizontal, 8)
                    
                    Button {
                        service.genPassword(len: Int(lenght), hasSpecialChar: specialCharsChecked, hasNumbers: numbersChecked, hasCaps: capsChecked, hasLetters: lettersChecked)
                            passwordCopied = false
                    } label: {
                        Text("Créer un  mot de passe").font(.system(.title3, design: .rounded))
                    }
                    .padding()
                }
                if service.progress != nil {
                    VStack(spacing: 25){
                        Text("Niveau de sécurité du mot de passe")
                            .padding()
                        MeterView(progress: $service.progress)
                            .padding(.horizontal,8)
                    }.padding()
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(service: ContentViewViewModel())
            .previewDevice("iPhone 11")
    }
}
