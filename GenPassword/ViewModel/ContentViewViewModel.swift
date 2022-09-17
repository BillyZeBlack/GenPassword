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
    
    func fetchApi(length: String)
    {
        var len = 6
        if let size = Int(length) {
            if size > 6 {
                len = size
            }
        }
        
        AF.request("https://passwordinator.herokuapp.com?num=false&char=true&caps=true&len=\(len)").response
        {(responseData) in
            guard let data = responseData.data else {
                return
            }
            
            do{
                let apiResponseResult = try JSONDecoder().decode(APIResponse.self, from: data)
                if "" != apiResponseResult.data {
                    self.data = apiResponseResult.data
                }
            }
            catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            }
            catch{
                debugPrint(error.localizedDescription)
            }
        }
    }
}
