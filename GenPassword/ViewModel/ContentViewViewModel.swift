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
    
    func genPassword(len: Int, hasSpecialChar: Bool, hasNumbers: Bool, hasCaps: Bool, hasLetters: Bool)
    {
        var passwordElements = ""
        var passwordGenerated = ""
        
        let letters = "aàbcçdeéèfghijklmnopqrstuùvwxyz"
        let caps = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let specialChars = "!&^%$#@()/"
        let numbers = "0123456789"
        
        if hasNumbers {
            passwordElements += numbers
        }
        
        if hasSpecialChar {
            passwordElements += specialChars
        }
        
        if hasLetters {
            passwordElements += letters
        }
        
        if hasCaps {
            passwordElements += caps
        }
        
        if 0 < passwordElements.count {
            passwordGenerated = String((0..<len).map{ _ in passwordElements.randomElement()! })
            testPassword(password: passwordGenerated, hasCaps: hasCaps, hasLetter: hasLetters, hasSpecialChar: hasSpecialChar, hasNumber: hasNumbers)
        }
    }
    
    func testPassword(password: String, hasCaps: Bool, hasLetter: Bool, hasSpecialChar: Bool, hasNumber: Bool)
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
        let numberResult = numberTest.evaluate(with: password)//password
        
        let specialCharRegex = ".*[!&^%$#@()/]+.*"
        let specialCharTest = NSPredicate(format: "SELF MATCHES %@", specialCharRegex)
        let specialCharResult = specialCharTest.evaluate(with: password)
        
        // Maj seules
        if (hasCaps && capitalResult) && ((!hasNumber && !numberResult) && (!hasLetter && !lowercaseResult) && (!hasSpecialChar && !specialCharResult)) {
            condition = true
        }
        
        // Maj et minuscule
        if ((hasCaps && capitalResult) && (hasLetter && lowercaseResult)) && ((!hasNumber && !numberResult) && (!hasSpecialChar && !specialCharResult)) {
            condition = true
        }
        
        //Maj et nombres
        if ((hasCaps && capitalResult) && (hasNumber && numberResult)) && ((!hasLetter && !lowercaseResult) && (!hasSpecialChar && !specialCharResult)) {
            condition = true
        }
        
        //Maj et caract. spé
        if ((hasCaps && capitalResult) && (hasSpecialChar && specialCharResult)) && ((!hasLetter && !lowercaseResult) && (!hasNumber && !numberResult)) {
            condition = true
        }
        
        //Maj && Minu && nombre
        if ((hasCaps && capitalResult) && (hasLetter && lowercaseResult) && (hasNumber && numberResult)) && (!hasSpecialChar && !specialCharResult) {
            condition = true
        }
        
        //Maj && minu && caractere spéciaux
        if (hasCaps && capitalResult && hasLetter && lowercaseResult && hasSpecialChar && specialCharResult) && (!hasNumber && !numberResult) {
            condition = true
        }

        //Maj et nombres et caracteres
        if ((hasCaps && capitalResult) && (hasNumber && numberResult) && (hasSpecialChar && specialCharResult)) && (!hasLetter && !lowercaseResult) {
            condition = true
        }
        
        //Minus seules
        if (hasLetter && lowercaseResult) && ((!hasNumber && !numberResult) && (!hasCaps && !capitalResult) && (!hasSpecialChar && !specialCharResult)) {
            condition = true
        }
        
        //Minus et nombres
        if ((hasLetter && lowercaseResult) && (hasNumber && numberResult)) && ((!hasCaps && !capitalResult) && (!hasSpecialChar && !specialCharResult)) {
            condition = true
        }
        
        //Minus et caractere spéciaux
        if ((hasLetter && lowercaseResult) &&  (hasSpecialChar && specialCharResult)) && ((!hasNumber && !numberResult) && (!hasCaps && !capitalResult)){
            condition = true
        }
        
        //Minus ; nombre ; cacartere
        if ((hasLetter && lowercaseResult) && (hasNumber && numberResult) && (hasSpecialChar && specialCharResult)) && ((!hasCaps && !capitalResult)) {
            condition = true
        }
        
        //Nombres seul
        if (hasNumber && numberResult) && ((!hasCaps && !capitalResult) && (!hasLetter && !lowercaseResult) && (!hasSpecialChar && !specialCharResult)) {
            condition = true
        }
        
        //Nombre et caractère spéciaux
        if ((hasNumber && numberResult) && (hasSpecialChar && specialCharResult) && ((!hasCaps && !capitalResult) && (!hasLetter && !lowercaseResult))) {
            condition = true
        }
        
        //caractere spéciaux
        if (hasSpecialChar && specialCharResult) && ((!hasCaps && !capitalResult) && (!hasLetter && !lowercaseResult) && (!hasNumber && !numberResult)) {
            condition = true
        }
        
        //tous les éléments
        if hasSpecialChar && specialCharResult && hasCaps && capitalResult && hasLetter && lowercaseResult && hasNumber && numberResult {
            condition = true
        }
        
        if condition { //|| (!hasCaps && !hasLetter && !hasSpecialChar)
            checkStrenghtPassword(password: password, capitalResult: capitalResult, lowercaseResult: lowercaseResult, specialCharResult: specialCharResult, numberResult: numberResult)
        } else {
            genPassword(len: password.count, hasSpecialChar: hasSpecialChar, hasNumbers: hasNumber, hasCaps: hasCaps, hasLetters: hasLetter)
        }
    }
    
    func checkStrenghtPassword(password: String, capitalResult: Bool, lowercaseResult: Bool, specialCharResult: Bool, numberResult: Bool)
    {
        // MARK: Only numbers
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
        
        //MARK: only lowercase
        if (password.count >= 8 && 10 >= password.count && lowercaseResult) && (!capitalResult && !numberResult && !specialCharResult) {
            self.progress = 40.0
        }
        
        if (password.count > 10 && 13 >= password.count && lowercaseResult) && (!capitalResult && !numberResult && !specialCharResult) {
            self.progress = 60.0
        }
        
        if (password.count > 13 && 17 >= password.count && lowercaseResult) && (!capitalResult && !numberResult && !specialCharResult) {
            self.progress = 80.0
        }
        
        if (password.count > 17 && lowercaseResult) && (!capitalResult && !numberResult && !specialCharResult) {
            self.progress = 100
        }
        
        //MARK: Only Uppercase
        if (password.count >= 8 && 10 >= password.count && capitalResult) && (!lowercaseResult && !numberResult && !specialCharResult) {
            self.progress = 40.0
        }
        
        if (password.count > 10 && 13 >= password.count && capitalResult) && (!lowercaseResult && !numberResult && !specialCharResult) {
            self.progress = 60.0
        }
        
        if (password.count > 13 && 17 >= password.count && capitalResult) && (!lowercaseResult && !numberResult && !specialCharResult) {
            self.progress = 80.0
        }
        
        if (password.count > 17 && capitalResult) && (!lowercaseResult && !numberResult && !specialCharResult) {
            self.progress = 100
        }
        
        //MARK: only Special Charac
        if (password.count >= 8 && 10 >= password.count && specialCharResult) && (!lowercaseResult && !numberResult && !capitalResult) {
            self.progress = 40.0
        }
        
        if (password.count > 10 && 13 >= password.count && specialCharResult) && (!lowercaseResult && !numberResult && !capitalResult) {
            self.progress = 60.0
        }
        
        if (password.count > 13 && 17 >= password.count && specialCharResult) && (!lowercaseResult && !numberResult && !capitalResult) {
            self.progress = 80.0
        }
        
        if (password.count > 17 && specialCharResult) && (!lowercaseResult && !numberResult && !capitalResult) {
            self.progress = 100
        }
        
        //MARK: uppercase && lowercase
        if ((password.count >= 8 && 10 >= password.count) && (capitalResult && lowercaseResult)) && !numberResult && !specialCharResult {
            self.progress = 40.0
        }
        
        if (password.count > 10 && 13 >= password.count && (capitalResult && lowercaseResult)) && !numberResult && !specialCharResult  {
            self.progress = 60.0
        }
        
        if (password.count > 13 && 17 >= password.count && (capitalResult && lowercaseResult)) && !numberResult && !specialCharResult  {
            self.progress = 80.0
        }
        
        if (password.count > 17 && (capitalResult && lowercaseResult)) && !numberResult && !specialCharResult  {
            self.progress = 100.0
        }
        
        //MARK: uppercase && lowercase && numbers
        if (password.count == 8 && capitalResult && lowercaseResult && numberResult) && !specialCharResult {
            self.progress = 80.0
        }
        
        if (password.count > 8 && capitalResult && lowercaseResult && numberResult) && !specialCharResult {
            self.progress = 100.0
        }
        
        //MARK: uppercase && lowercase && specialCharacter
        if (password.count == 8 && capitalResult && lowercaseResult && numberResult) && !specialCharResult {
            self.progress = 80.0
        }
        
        if (password.count > 8 && capitalResult && lowercaseResult && numberResult) && !specialCharResult {
            self.progress = 100.0
        }
        
        //MARK: uppercase && numbers
        if (password.count >= 8 && 10 >= password.count && capitalResult && numberResult) && (!lowercaseResult && !specialCharResult) {
            self.progress = 60.0
        }
        
        if ((password.count > 10 && 12 >= password.count) && capitalResult && numberResult) && (!lowercaseResult && !specialCharResult) {
            self.progress = 80.0
        }
        
        if (password.count > 12 && capitalResult && numberResult) && (!lowercaseResult && !specialCharResult) {
            self.progress = 100
        }
        
        //MARK: uppercase && specialCharact
        if (password.count >= 8 && 10 >= password.count && capitalResult && specialCharResult) && (!lowercaseResult && !numberResult) {
            self.progress = 80.0
        }
        
        if (password.count > 10 && capitalResult && specialCharResult) && (!lowercaseResult && !numberResult) {
            self.progress = 100.0
        }
        
        //MARK: lowercase && numbers
        if (password.count >= 8 && 13 >= password.count && lowercaseResult && numberResult) &&  (!capitalResult && !specialCharResult) {
            self.progress = 80.0
        }
        
        if (password.count > 13 &&  !capitalResult && lowercaseResult && numberResult) && (!capitalResult && !specialCharResult) {
            self.progress = 100.0
        }
        
        //MARK: lowercase && specialchart
        if (password.count >= 8 && 9 >= password.count && lowercaseResult && specialCharResult) && (!capitalResult && !numberResult) {
            self.progress = 60
        }
        
        if (password.count > 9 && 11 > password.count && lowercaseResult && specialCharResult) && (!capitalResult && !numberResult) {
            self.progress = 80
        }
        
        if (password.count > 11 && lowercaseResult && specialCharResult) && (!capitalResult && !numberResult) {
            self.progress = 100
        }
        
        //MARK: Numbers & special characters
        if (password.count == 8 && numberResult && specialCharResult) && (!capitalResult && !lowercaseResult) {
            self.progress = 40.0
        }
        
        if (password.count >= 9 && 11 >= password.count && numberResult && specialCharResult) && (!capitalResult && !lowercaseResult) {
            self.progress = 60.0
        }
        
        if (password.count > 11 && 14 >= password.count && numberResult && specialCharResult) && (!capitalResult && !lowercaseResult) {
            self.progress = 80.0
        }
        
        if (password.count > 14 && numberResult && specialCharResult) && (!capitalResult && !lowercaseResult) {
            self.progress = 100.0
        }

        //MARK: all possibilties
        if password.count == 8 && capitalResult && lowercaseResult && numberResult && specialCharResult {
            self.progress = 40.0
        }
        
        if password.count > 8 && 10 >= password.count && capitalResult && lowercaseResult && numberResult && specialCharResult {
            self.progress = 60.0
        }
        
        if password.count > 10 && 12 >= password.count && lowercaseResult && numberResult && specialCharResult {
            self.progress = 80.0
        }
        
        if password.count > 12 && capitalResult && lowercaseResult && numberResult && specialCharResult {
            self.progress = 100.0
        }
        
        self.data = password
    }
}
