//
//  AuthViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit
import Alamofire

class AuthViewController: UIViewController {
	
	private let authToken: HTTPHeaders = [.authorization("$2y$10$Wo6jNnh4Ksx7y8qP7uUR1uiUXJt.RntdqV4mBSj5uXrCMWN9vvWBe")]
	
	// Variables
	var email: String?
	var password: String?
	
	// Outlets
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var retrievePassword: UIButton!
	@IBOutlet weak var accessButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		textFieldStyle()
		accessButtonStyle()
	}
	
	// MARK: Action Buttons
	@IBAction func retrievePasswordAction(_ sender: Any) {
	}
	
	@IBAction func accessButtonAction(_ sender: Any) {
		email = emailTextField.text
		password = passwordTextField.text
		
		if let email = email, let password = password {
			if email != "", password != "" {
				let userLogin = UserLogin(email: email, password: password)
				
				login(loginUser: userLogin)
			} else {
				print("Introduzca")
			}
		}
	}
	
	// MARK: API Functions
	private func login(loginUser: UserLogin) {
		NetworkingProvider.shared.login(user: loginUser) { responseData in
			print(responseData)
		} failure: { error in
			print(error)
		} status: { status in
			print(status)
		}

	}
	
	// MARK: Styles
	private func textFieldStyle() {
		// Global Input Type Style Atributtes
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.mainColorLowOpacity,
			NSAttributedString.Key.font : UIFont(name: FontType.SFProRegular.rawValue, size: 17)
		]
		
		// Email Text Field Styles
		emailTextField.attributedPlaceholder = NSAttributedString(
				string: "Correo Electrónico",
				attributes: attributes as [NSAttributedString.Key : Any]
		)
		emailTextField.tintColor = .mainColor
		emailTextField.keyboardType = .emailAddress
		
		// Password Text Field Styles
		passwordTextField.isSecureTextEntry = true
		passwordTextField.attributedPlaceholder =  NSAttributedString(
			string: "Contraseña",
			attributes: attributes as [NSAttributedString.Key : Any]
		)
		passwordTextField.tintColor = .mainColor
	}
	
	private func accessButtonStyle() {
		accessButton.layer.cornerCurve = .circular
		accessButton.layer.cornerRadius = 10
	}
	
	
	// MARK: Test Api Routes
	private func testApiRoutes (){
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
		
		// MARK: LogOut
		
//		NetworkingProvider.shared.logout(authToken: authToken) { responseData in
//			print(responseData)
//		} failure: { error in
//			print(error)
//		} status: { status in
//			print(status)
//		}
	}
}

