//
//  VehicleHistoryModel.swift
//  Wender Auto
//
//  Created by Wender on 26/09/23.
//

import Foundation

struct VehicleHistoryModel: Codable {
    let vehicleType: Int
    let brand, model: String
    let modelYear: Int
    let fuel, codeFipe, fuelAcronym: String
    let priceHistory: [PriceHistory]
}

struct PriceHistory: Codable {
    let price, month, reference: String
}
