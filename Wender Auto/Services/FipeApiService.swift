//
//  FipeApiService.swift
//  Wender Auto
//
//  Created by Wender on 26/09/23.
//

import Foundation

final class FipeApiService {
    private let http = HttpService()
    
    private let path = "https://parallelum.com.br/fipe/api/v2"
    
    
    func listBrands(type: String) async throws -> [CodeNameModel] {
        let response: HttpResponse<[CodeNameModel]> = try await http.get("\(path)/\(type)/brands")
        
        if response.statusCode != 200 {
            throw HttpServiceError.invalidResponse
        }
        
        if let content = response.content {
            return content
        }
        
        throw HttpServiceError.invalidConversion
    }

    func listModels(type: String, brand: String) async throws -> [CodeNameModel] {
        let response: HttpResponse<[CodeNameModel]> = try await http.get("\(path)/\(type)/brands/\(brand)/models")
        
        if response.statusCode != 200 {
            throw HttpServiceError.invalidResponse
        }
        
        if let content = response.content {
            return content
        }
        
        throw HttpServiceError.invalidConversion
    }
    
    func listYears(type: String, brand: String, model: String) async throws -> [CodeNameModel] {
        let response: HttpResponse<[CodeNameModel]> = try await http.get("\(path)/\(type)/brands/\(brand)/models/\(model)/years")
        
        if response.statusCode != 200 {
            throw HttpServiceError.invalidResponse
        }
        
        if let content = response.content {
            return content
        }
        
        throw HttpServiceError.invalidConversion
    }
    
}
