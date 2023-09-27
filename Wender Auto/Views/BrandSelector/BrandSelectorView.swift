//
//  BrandSelectorView.swift
//  Wender Auto
//
//  Created by Wender on 26/09/23.
//

import SwiftUI

struct BrandSelectorView: View {
    
    @StateObject var model = BrandSelectorModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                
                List {
                    if !model.isLoading {
                        ForEach(model.brands, id: \.code) { brand in
                            NavigationLink {
                                ModelSelectorView(brandId: brand.code, brandName: brand.name)
                            } label: {
                                Text(brand.name)
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
                    await model.updateBrands()
                }
            }
            .navigationTitle("Brands")
            .searchable(text: $model.search, prompt: "Search for your brand")
        }
    }
}

#Preview {
    BrandSelectorView()
}
