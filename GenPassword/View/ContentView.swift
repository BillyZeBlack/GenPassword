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
    @State var lenght = ""
    @State var passwordCopied = false
    @State private var capsChecked = false
    @State private var numbersChecked = false
    @State private var specialCharsChecked = false
    @State private var lettersChecked = false
    @State var passwordStrenghtLevel = "niveau"
    @State var progress: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("GenP@ssw0rd")
                .font(.title)
                .fontWeight(.bold)
            if nil == service.data || "" == service.data {
                Text("Mot de passe en cours de génération")
                    .padding()
                    .onAppear {
                        service.genPassword(len: "0", hasSpecialChar: false, hasNumbers: true, hasCaps: false, hasLetters: false)
                }
                ProgressView().progressViewStyle(.circular)
                Spacer()
            }else {
                VStack {
                    Text("Mot De Passe : ")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                    HStack {
                        Text(service.data)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .font(.body)
                            .foregroundColor(Color.blue)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.purple, lineWidth: 3))
                        
                        if !passwordCopied {
                            Image(systemName: "doc.on.doc")
                                .onTapGesture {
                                UIPasteboard.general.setValue(self.service.data!, forPasteboardType: UTType.plainText.identifier)
                                    passwordCopied = true
                            }
                        }else {
                            Image(systemName: "doc.on.doc.fill")
                        }
                    }.padding()
                    VStack{
                        Text("Créer un nouveau mot de passe")
                            .font(.title3)
                            .fontWeight(.medium)
                            .padding()
                        VStack {
                            Toggle(isOn: $capsChecked) {
                                Text("Majuscules")
                                    .font(.system(.title3, design: .rounded))
                            }
                            Toggle(isOn: $lettersChecked) {
                                Text("Minuscules")
                                    .font(.system(.title3, design: .rounded))
                            }
                            Toggle(isOn: $specialCharsChecked) {
                                Text("Caractères spéciaux")
                                    .font(.system(.title3, design: .rounded))
                            }
                        }
                        .padding()
                        TextField("Taille", text: $lenght, prompt: Text("Entrez la taille du mot de passe")
                                    .font(.system(.title3, design: .rounded))).textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                        Rectangle()
                            .frame(height: 1)
                    }
                    Button {
                        if "" != lenght {
                            // check the size
                            // show alert if size is under 6 chars
                        }
                        
                        // check if length is a number before to call this function
//                        if checkIfSizeIsNumber(len: lenght){
                        service.genPassword(len: lenght, hasSpecialChar: specialCharsChecked, hasNumbers: numbersChecked, hasCaps: capsChecked, hasLetters: lettersChecked)
//                        self.progress = service.testPassword(password: service.data)
                            hideKeyboard()
                            passwordCopied = false
//                        }
                    } label: {
                        Text("Nouveau Mot De Passe").font(.system(.title3, design: .rounded))
                    }.padding()
                }.padding()
                Meter(progress: $service.progress)
                HStack(spacing: 25){
                    Text("Niveau de sécurité du mot de passe")
                }
                Spacer()
            }
        }
    }
    
    func checkIfSizeIsNumber(len: String)->Bool
    {
        if Int(len) != nil{
            return true
        }
        return false
    }
}

extension View {
    func hideKeyboard()
    {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(service: ContentViewViewModel())
            .previewDevice("iPhone 11")
    }
}
