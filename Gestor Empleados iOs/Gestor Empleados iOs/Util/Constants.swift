//
//  Constants.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 18/1/22.
//

import Foundation
import Alamofire

struct Constants {
	
	// Networking
	static let kBaseURL = "https://employee-manager-api-diego.herokuapp.com/api"
	static let kStatusCode = 200...299
	
	// Custom Status Code
	static let kErrorStatusCode = 0
	static let kCorrectStatusCode = 1
}
