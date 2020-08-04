//
//  APIClient.swift
//  Parsing-JSON-Using-URLSession
//
//  Created by Amy Alsaydi on 8/4/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation

enum AppError: Error {
    case badURL(String) // associated property to capture a string
    case networkError(Error)
    case decodingError(Error)
}

// TODO: convert to a Generic APIClient<Station()
// conform APIClient to Decodable

class APIClient {
    
    // NOTE!!!!
    // the fetchData method does an asynchronous network call
    // this means the method returns (BEFORE) the request is complete
    
    // when dealing with asynchronous calls we use a closure to capture the return
    // other mechanisms you can use include: delegation, NotificationCenter
    // newer to iOS developers as of iOS 13 is Combine
    
    // closures captures values, its a reference type
    
    func fetchData(completion: @escaping (Result<[Station], AppError>) -> ()) {
        let endpoint = "https://gbfs.citibikenyc.com/gbfs/en/station_information.json"
        // 1.
        // since were using urlsession - we need a url to create our Network Request
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        // 2. create a GET request, other examples POST, DELETE, PATCH, PUT
        let request = URLRequest(url: url) // make this mutable if you want to manipulate a request, but here the httpMethod is "GET" by default which is what we need
        
        
        //3. use URLSession to make the Network Request
        // URLSession.shared is a singleton - this is sufficent to use for making most requests
        // using URLSession without the shared instance gives you access to adding necessary configurations to your task
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
            }
            
            if let data = data {
                // 4. decode json to our swift model
                do {
                    let results = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    completion(.success(results.data.stations))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        
        dataTask.resume() // if you forget this you'll never get data
    }
}
