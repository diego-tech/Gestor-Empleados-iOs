//
//  NetworkingProvider.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 14/1/22.
//

import Foundation
import Alamofire

final class NetworkingProvider {
	
	static let shared = NetworkingProvider()
	
	private let kBaseURL = "http://localhost:8888/projects/employee-manager/public/api"
	private let kToken = "$2y$10$KmDge9RxgA2vlAUJnBrH9esAtLBAmkhbLGp4y.qqDvXdKKtoClT6O"
	
	// Update Data Message Error in API
	
	func seeProfile(success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int) -> ()) {
		let url = "\(kBaseURL)/see_profile"
		
		let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .get, headers: headers).validate(statusCode: 200...299).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
		
			// Handle User Data
			if let user = response.value?.data {
				success(user)
			}
			
			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Error
			if let error = response.error {
				failure(error)
			}
		}
	}
}

