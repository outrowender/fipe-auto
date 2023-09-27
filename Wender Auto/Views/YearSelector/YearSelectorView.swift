//
//  YearSelectorView.swift
//  Wender Auto
//
//  Created by Wender on 27/09/23.
//

import SwiftUI

struct YearSelectorView: View {
    
    let brandId: String
    let modelId: String
    
    let modelName: String
    
    @StateObject var model = YearSelectorModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            
            List {
                if !model.isLoading {
                    ForEach(model.years, id: \.code) { year in
                        NavigationLink {
                            ModelSelectorView(brandId: "22", brandName: "Ford")
                        } label: {
                            Text(year.name)
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
                await model.updateCarModels(brand: brandId, model: modelId)
            }
        }
        .navigationTitle(modelName)
        .searchable(text: $model.search, prompt: "Search for your car model")
        
        //        .searchable(text: $model.search, prompt: "Search for your car model")
    }
}

#Preview {
    YearSelectorView(brandId: "22", modelId: "6424", modelName: "Fiesta")
}
