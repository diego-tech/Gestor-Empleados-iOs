//
//  DateDecoder.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 14/1/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
	
	let dateFormatter = DateFormatter()
	
	override init() {
		super.init()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
		dateDecodingStrategy = .formatted(dateFormatter)
	}
}
