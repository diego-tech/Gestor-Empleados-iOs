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
	static let kBaseURL = "http://localhost:8888/projects/employee-manager/public/api"
	static let kStatusCode = 200...299
	
	// Custom Status Code
	static let kErrorStatusCode = 0
	static let kCorrectStatusCode = 1
	
	// User Defaults Constants
	static let kAuthUserToken = UserDefaultsProvider.string(key: .authUserToken)
	static let kAuthUserName = UserDefaultsProvider.string(key: .authUserName)
	static let kAuthUserEmail = UserDefaultsProvider.string(key: .authUserEmail)
	static let kAuthUserWorkplace = UserDefaultsProvider.string(key: .authUserWorkplace)
	static let kAuthUserSalary = UserDefaultsProvider.string(key: .authUserSalary)
	static let kAuthUseBiography = UserDefaultsProvider.string(key: .authUserBiography)
}
