//
//  BrandSelectorModel.swift
//  Wender Auto
//
//  Created by Wender on 26/09/23.
//

import Foundation

final class BrandSelectorModel: ObservableObject {
    @Published var brands: [CodeNameModel] = []
    
    @Published var isLoading = false // TODO: publish in main thread
    @Published var isError = false
    @Published var search = ""
    
    let api = FipeApiService()
    
    func updateBrands() async {
        self.isLoading = true
        
        do {
            let result = try await api.listBrands(type: "cars")
            
            self.brands = result
            self.isError = false
        } catch let e {
            print(e)
            self.isError = true
            
        }
        self.isLoading = false
        
    }
}
