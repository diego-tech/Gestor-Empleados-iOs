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
			if let auth_token = responseData?.apiToken, let auth_email = responseData?.email, let auth_name = responseData?.name, let auth_workplace = responseData?.workplace, let auth_salary = responseData?.salary, let auth_biography = responseData?.biography {
								
				self.setUserLoginDefaults(authUserToken: auth_token, authUserEmail: auth_email, authUserName: auth_name, authUserWorkplace: auth_workplace, authUserSalary: auth_salary, authUserBiography: auth_biography)
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
	private func setUserLoginDefaults(authUserToken: String?, authUserEmail: String?, authUserName: String?, authUserWorkplace: String?, authUserSalary: String?, authUserBiography: String?) {
		
		if let authUserName = authUserName, let authUserToken = authUserToken, let authUserEmail = authUserEmail, let authUserWorkplace = authUserWorkplace, let authUserSalary = authUserSalary, let authUserBiography = authUserBiography {
			UserDefaultsProvider.setUserDefaults(key: .authUserToken, value: authUserToken)
			UserDefaultsProvider.setUserDefaults(key: .authUserName, value: authUserName)
			UserDefaultsProvider.setUserDefaults(key: .authUserEmail, value: authUserEmail)
			UserDefaultsProvider.setUserDefaults(key: .authUserWorkplace, value: authUserWorkplace)
			UserDefaultsProvider.setUserDefaults(key: .authUserSalary, value: authUserSalary)
			UserDefaultsProvider.setUserDefaults(key: .authUserBiography, value: authUserBiography)
		}

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
}

