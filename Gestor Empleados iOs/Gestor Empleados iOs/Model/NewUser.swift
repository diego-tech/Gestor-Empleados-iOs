//
//  NewUser.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 15/1/22.
//

import Foundation

struct NewUser: Encodable {
	let name: String?
	let email: String?
	let password: String?
	let workplace: String?
	let salary: String?
	let biography: String?
	
	enum CodingKeys: String, CodingKey {
		case name
		case email
		case password
		case workplace
		case salary
		case biography
	}
}
