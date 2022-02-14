//
//  Passwords.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 15/1/22.
//

import Foundation

struct NewPassword: Encodable {
	let password: String?
	let repeatPassword: String?
	
	enum CodingKeys: String, CodingKey {
		case password
		case repeatPassword = "repeat_password"
	}
}
