//
//  HttpService.swift
//  Wender Auto
//
//  Created by Wender on 26/09/23.
//

import Foundation

struct HttpService {
    
    private let session = URLSession.shared
    
    /// A get request
    /// - Parameters:
    ///   - url: Your host request as a String.
    ///   - headers: A dictionary for headers.
    /// - Returns: A async request.
    func get<T: Decodable>(_ url: String, headers: [String: String]? = [:]) async throws -> HttpResponse<T> {
        guard let url = URL(string: url) else {
            throw HttpServiceError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // TODO: check cache policy for requests
        //request.cachePolicy = .returnCacheDataDontLoad
        
        headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpServiceError.invalidResponse
        }
        
        if httpResponse.statusCode != 200 {
            let rawResponse = String(decoding: data, as: UTF8.self)
            return HttpResponse<T>(statusCode: httpResponse.statusCode, raw: rawResponse, content: nil)
        }
        
        let decoder = JSONDecoder()
        let bodyResponse = try decoder.decode(T.self, from: data)
        
        return HttpResponse<T>(statusCode: httpResponse.statusCode, raw: nil, content: bodyResponse)
    }
    
    /// Make a POST request
    /// - Parameters:
    ///   - url: Your host request as a String.
    ///   - headers: A dictionary for headers.
    ///   - body: A body converted to a Data object.
    /// - Returns: A async request.
    func post<T: Decodable>(_ url: String, headers: [String: String]? = [:], body: Data?) async throws -> HttpResponse<T> {
        guard let url = URL(string: url) else {
            throw HttpServiceError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // TODO: check cache policy for requests
        //request.cachePolicy = .returnCacheDataDontLoad
        
        headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        request.httpBody = body
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw HttpServiceError.invalidResponse
        }
        
        if httpResponse.statusCode != 200 {
            let rawResponse = String(decoding: data, as: UTF8.self)
            return HttpResponse<T>(statusCode: httpResponse.statusCode, raw: rawResponse, content: nil)
        }
        
        let decoder = JSONDecoder()
        let bodyResponse = try decoder.decode(T.self, from: data)
        
        return HttpResponse<T>(statusCode: httpResponse.statusCode, raw: nil, content: bodyResponse)
    }
}

struct HttpResponse<T> {
    let statusCode: Int
    let raw: String?
    let content: T?
}

enum HttpServiceError: Error {
    case invalidUrl
    case invalidResponse
    case invalidConversion
}
