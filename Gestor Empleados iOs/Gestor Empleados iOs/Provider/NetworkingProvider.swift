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
	
	// Employee List
	func employeeList(serverResponse: @escaping (_ responseData: [Data]?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/employee_list"
		
		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]
				
		AF.request(url, method: .get, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable(of: ListResponse.self) {
			response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let statusCode = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, statusCode, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Employee Detail
	func employeeDetail(id: Int, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/employee_detail?user_id=\(id)"

		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]

		AF.request(url, method: .get, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in

			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let code = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, code, msg)
			}

			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Login
	func login(user: UserLogin, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/login"

		AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).validate(statusCode: Constants.kStatusCode).responseDecodable (of: Response.self, decoder: DateDecoder()) { response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let statusCode = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, statusCode, msg)
			}

			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Register
	func register(user: NewUser, serverResponse: @escaping (_ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/register"
		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]
		
		AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data && Status Code && Message
			if let code = response.value?.status, let msg = response.value?.msg {
				serverResponse(code, msg)
			}

			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Retrieve Password
	func retrievePassword(email: String, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()){
		let url = "\(Constants.kBaseURL)/retrieve_password?email=\(email)"
		
		AF.request(url, method: .post).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let code = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Modify Data
	func modifyData(userId: Int, user: NewUser, serverResponse: @escaping (_ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/modify_data?user_id=\(userId)"
		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]

		
		AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle && Status Code && Message
			if let code = response.value?.status, let msg = response.value?.msg{
				serverResponse(code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Modify Password
	func changePassword(passwords: NewPassword, serverResponse: @escaping (_ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()){
		let url = "\(Constants.kBaseURL)/modify_password"
		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]

		AF.request(url, method: .post, parameters: passwords, encoder: JSONParameterEncoder.default, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data && Status Code && Message
			if let code = response.value?.status, let msg = response.value?.msg {
				serverResponse(code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Logout
	func logout(serverResponse: @escaping (_ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/logout"
		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]
		
		AF.request(url, method: .post, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Status Code && Message
			if let code = response.value?.status, let msg = response.value?.msg {
				serverResponse(code, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// See Profile
	func seeProfile(serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/see_profile"
		
		let authToken: HTTPHeaders = [.authorization(UserDefaultsProvider.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: authToken).validate(statusCode: Constants.kStatusCode).responseDecodable (of: Response.self, decoder: DateDecoder()) { response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let statusCode = response.value?.status, let msg = response.value?.msg{
				serverResponse(data, statusCode, msg)
			}

			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
}

