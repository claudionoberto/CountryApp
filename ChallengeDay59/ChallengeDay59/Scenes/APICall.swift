//
//  APICall.swift
//  ChallengeDay59
//
//  Created by Claudio Noberto on 07/05/22.
//

import UIKit

class ServiceModel {
    static private let baseURL = URL(string: "https://restcountries.com/v3.1")
    static private let parameterKey = "all"
    
    static func getCountries(completion: @escaping (Result<[Countries],Error>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(Error.self as! Error)) }
        let finalURL = baseURL.appendingPathComponent(parameterKey)
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                return completion(.failure(error))
            }
            guard let data = data else { return completion(.failure(Error.self as! Error)) }
            
            do {
                let decodedData = try JSONDecoder().decode([Countries].self, from: data)
                return completion(.success(decodedData))
            } catch {
                return completion(.failure(error))
            }
        }.resume()
    }
}
