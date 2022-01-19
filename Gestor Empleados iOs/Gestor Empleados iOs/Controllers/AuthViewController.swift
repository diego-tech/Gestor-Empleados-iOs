//
//  AuthViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit
import Alamofire

class AuthViewController: UIViewController {
	
	// Variables
	var email: String?
	var password: String?
	var iconClick = false

	private let imageEye = UIImageView()
	
	// Outlets
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var retrievePassword: UIButton!
	@IBOutlet weak var accessButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.

		
		// Styles And Custom Actions
		textFieldStyle()
		accessButtonStyle()
		showAndHidePassword()
	}
	
	// MARK: Action Buttons
	@IBAction func retrievePasswordAction(_ sender: Any) {
		let storyBoard = UIStoryboard(name: "RetrievePassword", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "RetrievePasswordViewController") as! RetrievePasswordViewController
		self.present(vc, animated: true, completion: nil)
		
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
		NetworkingProvider.shared.login(user: loginUser) { responseData, status in
			if let auth_token = responseData?.apiToken, let auth_email = responseData?.email {
				self.setUserLoginDefaults(authUserToken: auth_token, authUserEmail: auth_email)
			}
			
			if status != Constants.kErrorStatusCode {
				self.navigate()
			} else {
				print(responseData?.msg)
			}
		} failure: { error in
			print(error!)
		}
	}
	
	// MARK: Functions
	private func setUserLoginDefaults(authUserToken: String, authUserEmail: String) {
		UserDefaultsProvider.setUserDefaults(key: .authUserToken, value: authUserToken)
		UserDefaultsProvider.setUserDefaults(key: .authUserEmail, value: authUserEmail)
	}
	
	private func navigate(){
		let storyBoard = UIStoryboard(name: "Home", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UICustomTabBarController
		self.present(vc, animated: true, completion: nil)
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
	
	private func showAndHidePassword(){
		imageEye.image = UIImage(named: "CloseEye")
		
		let contentView = UIView()
		contentView.addSubview(imageEye)
		
		contentView.frame = CGRect(x:0, y:0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)
		imageEye.frame = CGRect(x:-10, y:0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye" )!.size.height)
		
		passwordTextField.rightView = contentView
		passwordTextField.rightViewMode = .always

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		imageEye.isUserInteractionEnabled = true
		imageEye.addGestureRecognizer(tapGestureRecognizer)
	}
		
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		
		if iconClick {
			iconClick = false
			tappedImage.image = UIImage(named: "EyeOpen")
			passwordTextField.isSecureTextEntry = false
		} else {
			iconClick = true
			tappedImage.image = UIImage(named: "CloseEye")
			passwordTextField.isSecureTextEntry = true
		}
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

