//
//  AuthViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit
import Alamofire

class AuthViewController: UIViewController {
	
	private let authToken: HTTPHeaders = [.authorization("$2y$10$DsHj/8JArmFJ.zEKzSqGhuxTuY4EyiQmCh5JPmPsChS9BGl4dlJn6")]

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// MARK: Employee List
		
//		NetworkingProvider.shared.employeeList(authToken: authToken) { responseData in
//			print(responseData)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}

		// MARK: Employee Detail
		
//		NetworkingProvider.shared.employeeDetail(authToken: authToken, id: 3) { responseData in
//			print(responseData)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: Login
		
//		let userLogin = UserLogin(email: "diegorrhh@gmail.com", password: "Diego12345.")
//		
//		NetworkingProvider.shared.login(user: userLogin) { user in
//			print(user)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: User Register
		
//		let newUser = NewUser(name: "Diego", email: "diego171200@gmail.com", password: "Prueba12345.", workplace: "Empleado", salary: "1500", biography: "Hola Soy Prueba")
//
//		NetworkingProvider.shared.register(authToken: authToken, user: newUser) { responseData in
//			print(responseData)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: Retrieve Password
		
//		let email: String = "diego171200@gmail.com"
//
//		NetworkingProvider.shared.retrievePassword(email: email) { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: Modify Data
		
//		let updateUser = NewUser(name: "Pepe", email: nil, password: nil, workplace: nil, salary: nil, biography: nil)
//
//		NetworkingProvider.shared.modifyData(authToken: authToken, userId: 8, user: updateUser) { responseData in
//			print(responseData)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: Modify Password
		
//		let newPasswords = NewPasswords(password: "Diego12345.", repeatPassword: "Diego12345.")
//
//		NetworkingProvider.shared.modifyPassword(authToken: authToken, passwords: newPasswords) { responseData in
//			print(responseData)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
	}
}

