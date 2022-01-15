//
//  User.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 14/1/22.
//

import Foundation

struct UserResponse: Decodable {
	let status: Int?
	let data: Data?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
	}
}

struct UserListResponse: Decodable {
	let status: Int?
	let data: [Data]?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
	}
}

struct Data: Decodable {
	let id: Int?
	let name: String?
	let email: String?
	let workplace: String?
	let salary: String?
	let biography: String?
	let apiToken: String?
	let updateToken: String?
	let createdAt: Date?
	let updatedAt: Date?
	
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case email
		case workplace
		case salary
		case biography
		case apiToken = "api_token"
		case updateToken = "update_token"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
		case msg
	}
}
