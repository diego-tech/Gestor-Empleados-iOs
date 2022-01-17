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
	private let kStatusCode = 200...299
	

	// Employee List
	func employeeList(authToken: HTTPHeaders, serverResponse: @escaping (_ responseData: [Data]?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) -> ()) {
		let url = "\(kBaseURL)/employee_list"
		
		// let headers: HTTPHeaders = [.authorization(authToken)]
		
		AF.request(url, method: .get, headers: authToken).validate(statusCode: kStatusCode).responseDecodable(of: ListResponse.self) {
			response in
			
			// Handle Response Data
			if let data = response.value?.data {
				serverResponse(data)
			}
			
			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Employee Detail
	func employeeDetail(authToken: HTTPHeaders, id: Int, serverResponse: @escaping (_ responseData: Data?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) -> ()) {
		let url = "\(kBaseURL)/employee_detail?user_id=\(id)"
		
		// let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .get, headers: authToken).validate(statusCode: kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
						
			// Handle Response Data
			if let data = response.value?.data {
				serverResponse(data)
			}
			
			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Login
	func login(user: UserLogin, serverResponse: @escaping (_ responseData: Data?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) -> ()) {
		let url = "\(kBaseURL)/login"

		AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: kStatusCode).responseDecodable (of: Response.self, decoder: DateDecoder()) { response in
			
			// Handle Response Data
			if let data = response.value?.data{
				serverResponse(data)
			}

			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}

			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Register
	func register(authToken: HTTPHeaders, user: NewUser, serverResponse: @escaping (_ responseData: Data?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) ->()) {
		let url = "\(kBaseURL)/register"
		
		// let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: authToken).validate(statusCode: kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data
			if let data = response.value?.data {
				serverResponse(data)
			}
			
			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Retrieve Password
	func retrievePassword(email: String, serverResponse: @escaping (_ responseData: Data?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) -> ()){
		let url = "\(kBaseURL)/retrieve_password?email=\(email)"
		
		AF.request(url, method: .post).validate(statusCode: kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data
			if let data = response.value?.data {
				serverResponse(data)
			}
			
			// Handle Statuus Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Modify Data
	func modifyData(authToken: HTTPHeaders, userId: Int, user: NewUser, serverResponse: @escaping (_ responseData: Data?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) -> ()) {
		let url = "\(kBaseURL)/modify_data?user_id=\(userId)"
		
		// let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: authToken).validate(statusCode: kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data
			if let data = response.value?.data {
				serverResponse(data)
			}
			
			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Modify Password
	func modifyPassword(authToken: HTTPHeaders, passwords: NewPassword, serverResponse: @escaping (_ responseData: Data?) -> (), failure: @escaping (_ error: Error?) -> (), status: @escaping (_ status: Int?) -> ()){
		let url = "\(kBaseURL)/modify_password"
		
//		let headers: HTTPHeaders = [.authorization(kToken)]
		
		AF.request(url, method: .post, parameters: passwords, encoder: JSONParameterEncoder.default, headers: authToken).validate(statusCode: kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data
			if let data = response.value?.data {
				serverResponse(data)
			}
			
			// Handle Status Code
			if let code = response.value?.status {
				status(code)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
}

