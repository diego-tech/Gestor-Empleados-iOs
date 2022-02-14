//
//  DbResponse.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 17/1/22.
//

import Foundation

struct Response: Decodable {
	let status: Int?
	let data: Data?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct ListResponse: Decodable {
	let status: Int?
	let data: [Data]?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}
