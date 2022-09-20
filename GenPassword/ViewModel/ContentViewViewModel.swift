//
//  ContentViewViewModel.swift
//  GenPassword
//
//  Created by williams saadi on 17/09/2022.
//

import Foundation
import Alamofire
import UIKit

class ContentViewViewModel: ObservableObject {
    
    @Published var data : String!
    @Published var level: String!
    @Published var progress: CGFloat!
    
    func genPassword(len: String, hasSpecialChar: Bool, hasNumbers: Bool, hasCaps: Bool, hasLetters: Bool)
    {
        var length = 8
        
        let letters = "aàbcçdeéèfghijklmnopqrstuùvwxyz"
        let caps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let specialChars = "!&^%$#@()/"
        var numbers = "0123456789"
        
        if let size = Int(len) {
            if size > 8 {
                length = size
            }
        }
        
        if hasSpecialChar {
            numbers += specialChars
        }
        
        if hasLetters {
            numbers += letters
        }
        
        if hasCaps {
            numbers += caps
        }
        
        data = String((0..<length).map{ _ in numbers.randomElement()! })
        
        testPassword(password: data, hasCaps: hasCaps, hasLetter: hasLetters, hasSpecialChar: hasSpecialChar)
    }
    
    func testPassword(password: String, hasCaps: Bool, hasLetter: Bool, hasSpecialChar: Bool)
    {
        var condition = false
        
        let capitalLetterRegex = ".*[A-Z]+.*"
        let textTest = NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex)
        let capitalResult = textTest.evaluate(with: password)
        
        let lowercaseLetter = ".*[a-z]+.*"
        let lowercaseTest = NSPredicate(format: "SELF MATCHES%@", lowercaseLetter)
        let lowercaseResult = lowercaseTest.evaluate(with: password)
        
        let numbersRegex = ".*[0-9]+.*"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numbersRegex)
        let numberResult = numberTest.evaluate(with: password)
        
        let specialCharRegex = ".*[!&^%$#@()/]+.*"
        let specialCharTest = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        let specialCharResult = specialCharTest.evaluate(with: password)
        
        if hasCaps && capitalResult {
            condition = true
        }
        
        if hasLetter && lowercaseResult {
            condition = true
        }
        
        if hasSpecialChar && specialCharResult {
            condition = true
        }
        
        if condition || (!hasCaps && !hasLetter && !hasSpecialChar){
            checkStrenghtPassword(password: password, capitalResult: capitalResult, lowercaseResult: lowercaseResult, specialCharResult: specialCharResult, numberResult: numberResult)
        } else {
            genPassword(len: password, hasSpecialChar: hasSpecialChar, hasNumbers: true, hasCaps: hasCaps, hasLetters: hasLetter)
        }
    }
    
    func checkStrenghtPassword(password: String, capitalResult: Bool, lowercaseResult: Bool, specialCharResult: Bool, numberResult: Bool)
    {
        if ((password.count <= 10 && numberResult) && !capitalResult && !lowercaseResult && !specialCharResult) {
            level = "20"
            self.progress = 20.0
        }
        
        if (password.count >= 11 && password.count <= 15 && numberResult) && !capitalResult && !lowercaseResult && !specialCharResult {
            level = "40"
            self.progress = 40.0
        }
        
        if (password.count > 15 && numberResult) && !capitalResult && !lowercaseResult && !specialCharResult {
            level = "60"
            self.progress = 60.0
        }
        
        if (password.count <= 5 && numberResult && capitalResult && lowercaseResult) && !specialCharResult {
            level = "20"
            self.progress = 20.0
        }
        
        if (password.count > 5 && password.count <= 8 && numberResult && capitalResult && lowercaseResult) && !specialCharResult {
            level = "40"
            self.progress = 40.0
        }
        
        if (password.count > 8 && password.count <= 10 && numberResult && capitalResult && lowercaseResult) && !specialCharResult {
            level = "60"
            self.progress = 60.0
        }
        
        if (password.count > 10 && password.count <= 13 && numberResult && capitalResult && lowercaseResult) && !specialCharResult {
            level = "80"
            self.progress = 80.0
        }
        
        if (password.count > 13 && numberResult && capitalResult && lowercaseResult) && !specialCharResult {
            level = "100"
            self.progress = 100.0
        }
        
        if password.count <= 5 && numberResult && capitalResult && lowercaseResult && specialCharResult {
            level = "20"
            self.progress = 20.0
        }
        
        if (password.count > 5 && password.count <= 8) && numberResult && capitalResult && lowercaseResult && specialCharResult {
            level = "40"
            self.progress = 40.0
        }
        
        if (password.count > 8 && password.count <= 10) && numberResult && capitalResult && lowercaseResult && specialCharResult {
            level = "60"
            self.progress = 60.0
        }
        
        if (password.count > 10 && password.count <= 12) && numberResult && capitalResult && lowercaseResult && specialCharResult {
            level = "80"
            self.progress = 80.0
        }
        
        if password.count > 12 && numberResult && capitalResult && lowercaseResult && specialCharResult {
            level = "100"
            self.progress = 100.0
        }
    }
}
