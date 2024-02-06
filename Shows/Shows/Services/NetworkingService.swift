//
//  NetworkingService.swift
//  Shows
//
//  Created by Matej Kuprešak on 19.09.2023..
//

import Foundation
import SwiftUI

protocol NetworkingServiceProtocol {
    func fetchArray<T: Codable>(of type: T.Type, with request: Request, completion: @escaping (Result<[T], ErrorHandler>) -> Void) where T: Codable
    
    func fetchSearchResponse(query: String, completion: @escaping (Result<[SearchResponse], ErrorHandler>) -> Void)
    
    func fetchCast(showID: Int, completion: @escaping (Result<[CastResponse], ErrorHandler>) -> Void)
    
    func fetchHomeScreenShow(showID: Int, completion: @escaping (Result<Show, ErrorHandler>) -> Void)
    
    func fetchHomeScreenSchedule(date: String, completion: @escaping (Result<[HomeScreenSchedule], ErrorHandler>) -> Void)
}

final class NetworkingService: ObservableObject, NetworkingServiceProtocol {
    func fetchArray<T>(of type: T.Type, with request: Request, completion: @escaping (Result<[T], ErrorHandler>) -> Void) where T : Decodable, T : Encodable {
        guard let urlRequest = configureRequest(request) else { return }
        let urlSession: URLSession = URLSession.shared
        
        //crete a data task
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let data = data {
                    // parse data
                    do {
                        let json = try JSONDecoder().decode([T].self, from: data)
                        print(json)
                        completion(.success(json))
                    } catch {
                        print("Error: \(error)")
                        completion(.failure(.cannotParse))
                        return
                    }
                }
            } else {
                print("Error: \(httpResponse.statusCode)")
                completion(.failure(.notFound))
            }
        }
        .resume()
    }
    
    func fetchSingleObject<T>(of type: T.Type, with request: Request, completion: @escaping (Result<T, ErrorHandler>) -> Void) where T : Decodable, T: Encodable {
        guard let urlRequest = configureRequest(request) else { return }
        let urlSession: URLSession = URLSession.shared
        
        //crete a data task
        urlSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299 {
                if let data = data {
                    // parse data
                    do {
                        let json = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(json))
                    } catch {
                        print("Error: \(error)")
                        completion(.failure(.cannotParse))
                        return
                    }
                }
            } else {
                print("Error: \(httpResponse.statusCode)")
                completion(.failure(.notFound))
            }
        }
        .resume()
    }
    
    func fetchSearchResponse(query: String, completion: @escaping (Result<[SearchResponse], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/search/shows?q=",
            method: .get,
            type: .json,
            parameters: nil,
            query: query
        )
        
        fetchArray(of: SearchResponse.self, with: request) { [weak self] result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                completion(.success(response))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchCast(showID: Int, completion: @escaping (Result<[CastResponse], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/shows/\(showID)/cast",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil
        )
        
        fetchArray(of: CastResponse.self, with: request) { [weak self] result in
            switch result {
            case .success(let response):
                print("SUCCESS")
                completion(.success(response))
            case .failure(let error):
                print("ERROR: \(error)")
            }
        }
    }
    
    func fetchHomeScreenShow(showID: Int, completion: @escaping (Result<Show, ErrorHandler>) -> Void) {
        let request = Request(
            path: "/shows/\(showID)",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil
        )

        fetchSingleObject(of: Show.self, with: request) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchHomeScreenSchedule(date: String, completion: @escaping (Result<[HomeScreenSchedule], ErrorHandler>) -> Void) {
        let request = Request(
            path: "/schedule?country=US&date=\(date)",
            method: .get,
            type: .json,
            parameters: nil,
            query: nil
        )
        
        fetchArray(of: HomeScreenSchedule.self, with: request) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NetworkingService {
    func configureRequest(_ request: Request) -> URLRequest? {
        let configuration: NetworkConfiguration = NetworkConfiguration(baseURL: "https://api.tvmaze.com")
        let urlString = configuration.baseURL + request.path
        
        guard let url = URL(string: urlString) else {
            print("Error creating request URL with: \(urlString)")
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.setValue(request.type.rawValue, forHTTPHeaderField: "Content-Type")
        
        //headers
        if let headers = configuration.staticHeaders {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        //auth header
        if let authorization = configuration.authorizationHeaders {
            for (key, value) in authorization {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        //paramaters and query
        if let parameters = request.parameters {
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                urlRequest.httpBody = jsonData
            }
        }
        
        if let query = request.query {
            urlRequest.url = URL(string: urlString.appending(query))
        }
        
        return urlRequest
    }
}
