//
//  ViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// MARK: See Profile
		
//		NetworkingProvider.shared.seeProfile { user in
//			print(user)
//		} failure: { error in
//			print(error)
//		} status: { status  in
//			print(status)
//		}
		
		// MARK: Employee List
		
//		NetworkingProvider.shared.employeeList { users in
//			print(users)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}

		// MARK: Employee Detail
		
//		NetworkingProvider.shared.employeeDetail(id: 3) { user in
//			print(user)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: Login
		
//		let userLogin = UserLogin(email: "diegorrhh@gmail.com", password: "Diego123456^")
//
//		NetworkingProvider.shared.login(user: userLogin) { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: User Register
		
//		let newUser = NewUser(name: "Diego", email: "diego171200@gmail.com", password: "Prueba12345.", workplace: "Empleado", salary: "1500", biography: "Hola Soy Prueba")
//
//		NetworkingProvider.shared.register(user: newUser) { error in
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
//		NetworkingProvider.shared.modifyData(userId: 8, user: updateUser) { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
		
		// MARK: Modify Password
		
//		let newPasswords = NewPasswords(password: "Diego12345.", repeatPassword: "Diego12345.")
//
//		NetworkingProvider.shared.modifyPassword(passwords: newPasswords) { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
	}
}

