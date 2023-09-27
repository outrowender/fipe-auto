//
//  ModelSelectorView.swift
//  Wender Auto
//
//  Created by Wender on 27/09/23.
//

import SwiftUI

struct ModelSelectorView: View {
    
    let brandId: String
    
    let brandName: String
    
    @StateObject var model = ModelSelectorModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            List {
                if !model.isLoading {
                    ForEach(model.carModels, id: \.code) { carModel in
                        NavigationLink {
//                            ModelSelectorView(brandId: 22)
                            YearSelectorView(brandId: brandId, modelId: carModel.code, modelName: carModel.name)
                        } label: {
                            Text(carModel.name)
                        }
                    }
                } else {
                    ProgressView()
                        .listRowBackground(Color.clear)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
            
        }
        .onLoad {
            Task {
                await model.updateCarModels(brand: brandId)
            }
        }
        .navigationTitle(brandName)
        .searchable(text: $model.search, prompt: "Search for your car model")
        
        //        .searchable(text: $model.search, prompt: "Search for your car model")
    }
}

#Preview {
    ModelSelectorView(brandId: "22", brandName: "Ford")
}
