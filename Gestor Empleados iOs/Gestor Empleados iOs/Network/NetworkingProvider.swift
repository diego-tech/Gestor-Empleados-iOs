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
	private let kToken = "$2y$10$ml8oTez73OvhB..5qG5XieBT7lTpAAoNzcCEhyTGzs2jp5Gl4bKTa"
	private let kStatusCode = 200...299

	func employeeList(success: @escaping (_ users: [User]) -> (), failure: @escaping (_ error: Error) -> (), status: @escaping (_ status: Int, _ message: String) -> ()) {
		let url = "\(kBaseURL)/employee_list"
		
		let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .get, headers: headers).validate(statusCode: kStatusCode).responseDecodable(of: UserListResponse.self) {
			response in
			
			// Handle User Data
			if let users = response.value?.data {
				success(users)
			}
			
			// Handle Status Code & Message
			if let code = response.value?.status, let msg = response.value?.msg {
				status(code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	func employeeDetail(id: Int, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error) -> (), status: @escaping (_ status: Int, _ message: String) -> ()) {
		let url = "\(kBaseURL)/employee_detail?user_id=\(id)"
		
		let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .get, headers: headers).validate(statusCode: kStatusCode).responseDecodable(of: UserResponse.self, decoder: DateDecoder()) {
			response in
			
			// Handle User Data
			if let user = response.value?.data {
				success(user)
			}
			
			// Handle Status Code & Message
			if let code = response.value?.status, let msg = response.value?.msg {
				status(code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	func seeProfile(success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error) -> (), status: @escaping (_ status: Int, _ message: String) -> ()) {
		let url = "\(kBaseURL)/see_profile"
		
		let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .get, headers: headers).validate(statusCode: kStatusCode).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
		
			// Handle User Data
			if let user = response.value?.data {
				success(user)
			}
			
			// Handle Status Code & Message
			if let code = response.value?.status, let msg = response.value?.msg {
				status(code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
//	func login(user: UserLogin, failure: @escaping (_ error: Error) -> (), status: @escaping (_ status: Int, _ message: String) -> ()) {
//		let url = "\(kBaseURL)/login"
//
//		AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: kStatusCode).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
//
//			if let code = response.value?.status ,let msg = response.value?.msg{
//				status(code, msg)
//			}
//
//			if let error = response.error {
//				failure(error)
//			}
//		}
//	}
}

