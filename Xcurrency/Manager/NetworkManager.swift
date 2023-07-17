//
//  NetworkManager.swift
//  Xcurrency
//
//  Created by MacBook AIR on 17/07/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    
    
    enum APIError:Error {
        case failedToGetData
    }
    
    static let shared = NetworkManager()
    
    
    ///Note:  get countries datas to display on the Picker
    public func getCountriesData(completion: @escaping (Result<[Country], Error>) -> Void) {
        AF.request("http://data.fixer.io/api/latest?access_key=5cdcd6169f487decc0170d8db3d08d2a", method: .get, encoding: URLEncoding.default).response { response in
            
            
            // Check for errors
            guard let value = response.data, response.error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            let json = JSON(value)
            
            let symbols = json["rates"].dictionaryValue
            // Extract country names from the symbols dictionary
         
         
            var data = [Country]()
            
            for (countryCode, rate) in symbols {
                if let rateValue = rate.double {
                    let country = Country(name: countryCode, displayName: String(countryCode.dropLast()), rate: rateValue)
                    data.append(country)
                }
            }
            
            completion(.success(data))
        }
    }
    
    
    //Couldnt perfomr this operation because of api limitation on unpaid account
    public func getCalculationData(amount: String, baseCurrency: String, resultCurrency: String, completion: @escaping (Result<String, Error>) -> Void) {
        let accessKey = "5cdcd6169f487decc0170d8db3d08d2a"
        let url = "http://data.fixer.io/api/convert"
        
        let urlString = "\(url)?access_key=\(accessKey)&from=\(baseCurrency)&to=\(resultCurrency)&amount=\(amount)"
         AF.request(urlString, method: .get, encoding: URLEncoding.default).response { response in
            // Check for errors
            guard let value = response.data, response.error == nil else {
                completion(.failure(APIError.failedToGetData))
                return
            }
            
            let json = JSON(value)
            let result = json["result"].doubleValue
            let resultString = String(format: "%.2f", result) // Format the result to two decimal places
            completion(.success(resultString))
            
        }
        
    }
}
