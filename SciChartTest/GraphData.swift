//
//	graphData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct GraphData : Codable {

	let cdAwithvalueremoved : Float
	let cdawithoutremovedvalue : Float
	let distance : Float
	let power : Float
	let speed : Float
	let time : Int


	enum CodingKeys: String, CodingKey {
		case cdAwithvalueremoved = "CdAwithvalueremoved"
		case cdawithoutremovedvalue = "Cdawithoutremovedvalue"
		case distance = "distance"
		case power = "power"
		case speed = "speed"
		case time = "time"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cdAwithvalueremoved = try values.decode(Float.self, forKey: .cdAwithvalueremoved)
		cdawithoutremovedvalue = try values.decode(Float.self, forKey: .cdawithoutremovedvalue)
		distance = try values.decode(Float.self, forKey: .distance)
		power = try values.decode(Float.self, forKey: .power)
		speed = try values.decode(Float.self, forKey: .speed)
		time = try values.decode(Int.self, forKey: .time)
	}


}
