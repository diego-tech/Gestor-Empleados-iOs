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
//			print(error.debugDescription)
//		} status: { status, msg  in
//			print(status)
//			print(msg)
//		}
		
		// MARK: Employee List
		
//		NetworkingProvider.shared.employeeList { users in
//			print(users)
//		} failure: { error in
//			print(error)
//		} status: { status, message in
//			print(status)
//			print(message)
//		}

		// MARK: Employee Detail
		
//		NetworkingProvider.shared.employeeDetail(id: 3) { user in
//			print(user)
//		} failure: { error in
//			print(error)
//		} status: { status, message in
//			print(status)
//			print(message)
//		}
		
		// MARK: Login
		
		let userLogin = UserLogin(email: "diegorrhh@gmail.com", password: "Diego123456^")
		
		NetworkingProvider.shared.login(user: userLogin) { error in
			print(error)
		} status: { status, message in
			print(status)
			print(message)
		}
	}
}

