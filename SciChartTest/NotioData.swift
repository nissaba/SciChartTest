//
//	NotioData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct NotioData : Codable {

	let cdA : Double
    let power : Double
    let speed : Double
    let timestamp : Int

    enum CodingKeys: String, CodingKey {
        case cdA = "CdA"
        case power = "power"
        case speed = "speed"
        case timestamp = "timestamp"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cdA = try values.decode(Double.self, forKey: .cdA)
        power = try values.decode(Double.self, forKey: .power)
        speed = try values.decode(Double.self, forKey: .speed)
        timestamp = try values.decode(Int.self, forKey: .timestamp)
    }
}
