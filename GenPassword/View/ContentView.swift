//
//  ContentView.swift
//  GenPassword
//
//  Created by williams saadi on 17/09/2022.
//

import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @StateObject var service =  ContentViewViewModel()
    @State var lenght = 8.0
    @State var passwordCopied = false
    @State private var capsChecked = false
    @State private var numbersChecked = false
    @State private var specialCharsChecked = false
    @State private var lettersChecked = false
    @State var passwordStrenghtLevel = "niveau"
    @State var progress: CGFloat = 0
    @State var toggleNotSelected = false
    @State var canShowGraphique = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("GenP@sswØrd")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.white)
                    .onAppear(perform: {
                        service.genPassword(len: 0, hasSpecialChar: specialCharsChecked, hasNumbers: numbersChecked, hasCaps: capsChecked, hasLetters: lettersChecked)
                    })
                    .padding()
                ScrollViewReader { svr in
                    ScrollView(showsIndicators: false) {
                        VStack {
                            VStack {
                                VStack{
                                    Text("Paramètres du mot de passe")
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .foregroundColor(.white)
                                    
                                    TogglesView(capsChecked: $capsChecked,
                                                  lettersChecked: $lettersChecked,
                                                  numbersChecked: $numbersChecked,
                                                  specialCharsChecked: $specialCharsChecked)
                                    HStack {
                                        Text("\(Int(lenght))")
                                            .foregroundColor(.white)
                                        Slider(value: $lenght, in: 8...64)
                                            .accentColor(Color.white)
                                            .frame(height: 40)
                                        Text("64")
                                            .foregroundColor(.white)
                                    }
                                    Button {
                                        if !capsChecked && !lettersChecked && !numbersChecked && !specialCharsChecked {
                                            toggleNotSelected = true
                                            canShowGraphique = false
                                            service.progress = 0
                                            service.resetPassword()
                                        } else {
                                            toggleNotSelected = false
                                            canShowGraphique = true
                                            withAnimation(.linear(duration: 1.5)) {
                                                svr.scrollTo(0, anchor: .bottom)
                                            }
                                            service.genPassword(len: Int(lenght), hasSpecialChar: specialCharsChecked, hasNumbers: numbersChecked, hasCaps: capsChecked, hasLetters: lettersChecked)
                                            passwordCopied = false
                                        }
                                    } label: {
                                        Text("Créer un  mot de passe").font(.system(.title3, design: .rounded))
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity, minHeight: 55)
                                            .overlay(RoundedRectangle(cornerRadius: 15)
                                                        .stroke(Color.white, lineWidth: 3))
                                    }
                                    .clipped()
                                    .padding()
                                    .alert(isPresented: $toggleNotSelected) {
                                        Alert(
                                            title: Text("Information")
                                                .foregroundColor(.gray),
                                            message: Text("Veuillez sélectionner un élément")
                                                .foregroundColor(.white),
                                            dismissButton: .default(Text("OK")
                                                                        .foregroundColor(.white))
                                        )
                                    }
                                    VStack {
                                        HStack {
                                            Spacer()
                                            if !capsChecked && !lettersChecked && !numbersChecked && !specialCharsChecked || nil == service.data {
                                                Text("My GenP@ssw0rd")
                                                    .foregroundColor(.white)
//                                                    .padding()
                                                
                                            } else {
                                                Text(service.data)
//                                                    .padding()
                                                    .foregroundColor(.white)
                                            }
                                            Spacer()
                                            if !passwordCopied {
                                                Image(systemName: "doc.on.doc")
                                                    .foregroundColor(.white)
//                                                    .padding()
                                                    .onTapGesture {
                                                        UIPasteboard.general.setValue(self.service.data!, forPasteboardType: UTType.plainText.identifier)
                                                        passwordCopied = true
                                                    }
                                            }else {
                                                Image(systemName: "doc.on.doc.fill")
                                                    .foregroundColor(.white)
//                                                    .padding()
                                            }
                                        }
//                                        .frame(maxWidth: .infinity)
//                                        .overlay(RoundedRectangle(cornerRadius: 15)
//                                                .stroke(Color.gray, lineWidth: 1))
                                        Rectangle()
                                            .frame(width: .infinity, height: 1)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.horizontal, 8)
                            }
                            VStack {
                                Text("Sécurité du mot de passe")
                                    .foregroundColor(.white)
                                    .padding()
                                MeterView(progress: $service.progress)
                                    .padding()
                            }.id(0)
                            .padding(.horizontal, 8)
                            .padding(.bottom)
                        }.padding(.bottom)
                    }.padding(.bottom)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 8)
            .background(LinearGradient(gradient: Gradient(colors: [Color("ColorBackground1"), Color("ColorBackground2")]), startPoint: .top, endPoint: .bottom))
            Spacer()
        }.background(LinearGradient(gradient: Gradient(colors: [Color("ColorBackground1"), Color("ColorBackground2")]), startPoint: .top, endPoint: .bottom))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(service: ContentViewViewModel())
        
    }
}
