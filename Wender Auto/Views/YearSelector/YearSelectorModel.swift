//
//  YearSelectorModel.swift
//  Wender Auto
//
//  Created by Wender on 27/09/23.
//

import Foundation

final class YearSelectorModel: ObservableObject {
    @Published var years: [CodeNameModel] = []
    
    @Published var isLoading = false // TODO: publish in main thread
    @Published var isError = false
    @Published var search = ""
    
    let api = FipeApiService()
    
    func updateCarModels(brand: String, model: String) async {
        self.isLoading = true
        
        do {
            let result = try await api.listYears(type: "cars", brand: brand, model: model)
            
            self.years = result
            self.isError = false
        } catch let e {
            print(e)
            self.isError = true
            
        }
        self.isLoading = false
        
    }
}
