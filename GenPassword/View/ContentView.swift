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
    
    var body: some View {
        VStack {
            if nil == service.data || "" == service.data {
                Text("Mot de passe en cours de génération")
                    .padding()
                    .onAppear {
                        service.fetchApi(length: "0")
                }
                ProgressView().progressViewStyle(.circular)
                Spacer()
            }else {
                VStack {
                    Text("Mot de passe généré : ")
                    HStack {
                        Text(service.data).padding()
                            .font(.title3)
                            .border(.black)
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
                        TextField("Taille", text: $lenght, prompt: Text("Entrez la taille du mot de passe"))
                            .keyboardType(.decimalPad)
                        Rectangle()
                            .frame(height: 1)
                    }
                    Button {
                        service.fetchApi(length: lenght)
                        hideKeyboard()
                        passwordCopied = false
                    } label: {
                        Text("Je veux un nouveau mot de passe")
                    }.padding()
                }.padding()
                Spacer()
            }
        }
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
    }
}
