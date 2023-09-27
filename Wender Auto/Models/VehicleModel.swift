//
//  VehicleModel.swift
//  Wender Auto
//
//  Created by Wender on 26/09/23.
//

import Foundation

struct VehicleModel: Codable {
    let vehicleType: Int
    let price, brand, model: String
    let modelYear: Int
    let fuel, codeFipe, referenceMonth, fuelAcronym: String
}
