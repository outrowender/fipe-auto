//
//  ModelSelectorModel.swift
//  Wender Auto
//
//  Created by Wender on 27/09/23.
//

import Foundation

final class ModelSelectorModel: ObservableObject {
    @Published var carModels: [CodeNameModel] = []
    
    @Published var isLoading = false // TODO: publish in main thread
    @Published var isError = false
    @Published var search = ""
    
    let api = FipeApiService()
    
    func updateCarModels(brand: String) async {
        self.isLoading = true
        
        do {
            let result = try await api.listModels(type: "cars", brand: brand)
            
            self.carModels = result
            self.isError = false
        } catch let e {
            print(e)
            self.isError = true
            
        }
        self.isLoading = false
        
    }
}
