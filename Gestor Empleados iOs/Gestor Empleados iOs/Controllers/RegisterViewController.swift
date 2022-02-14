//
//  RegisterEmployeeViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 22/1/22.
//

import UIKit
import SwiftUI

class RegisterViewController: UIViewController {

	// Variables
	var userName: String?
	var userEmail: String?
	var userPassword: String?
	var userWorkplace: String?
	var userSalary: String?
	var userBiography: String?
	
	var iconClick = false
		
	// Outlets
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!
	@IBOutlet weak var workplaceSegmentedControls: UISegmentedControl!
	@IBOutlet weak var salaryTextField: UITextField!
	@IBOutlet weak var biographyTextView: UITextView!
	@IBOutlet weak var registerButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Styles and Custom Actions
		textFieldStyles(textField: nameTextField, placeholderText: "Nombre")
		
		textFieldStyles(textField: emailTextField, placeholderText: "Correo Electrónico")
		emailTextField.keyboardType = .emailAddress
		
		textFieldStyles(textField: passwordTextField, placeholderText: "Contraseña")
		passwordTextField.isSecureTextEntry = true
		
		textFieldStyles(textField: salaryTextField, placeholderText: "Salario")
		
		segmentedControlsStyles()
		textViewStyle()
		registerButtonStyle()
		showAndHidePassword()
	}
	
	// MARK: Functions
	private func getValues() -> NewUser {
		userName = nameTextField.text
		userEmail = emailTextField.text
		userPassword = passwordTextField.text
		
		if workplaceSegmentedControls.selectedSegmentIndex == 0 {
			userWorkplace = "Empleado"
		} else if workplaceSegmentedControls.selectedSegmentIndex == 1 {
			userWorkplace = "RRHH"
		} else if workplaceSegmentedControls.selectedSegmentIndex == 2 {
			userWorkplace = "Directivo"
		}
		
		userSalary = salaryTextField.text
		userBiography = biographyTextView.text
		
		return NewUser(name: userName, email: userEmail, password: userPassword, workplace: userWorkplace, salary: userSalary, biography: userBiography)
	}
	
	private func navigateWhenCreateUser() {
		let storyBoard = UIStoryboard(name: "Home", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UICustomTabBarController
		self.present(vc, animated: true, completion: nil)
	}
	
	private func alertFunction(title: String, msg: String){
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Volver", style: .default, handler: { action in
			self.navigateWhenCreateUser()
		}))
		
		present(alert, animated: true)
	}
	
	private func checkFields() -> Bool {
		if nameTextField.text == "" {
			nameTextField.layer.borderWidth = 0.3
			nameTextField.layer.borderColor = UIColor.red.cgColor
			nameTextField.layer.cornerCurve = .circular
			nameTextField.layer.cornerRadius = 5
			
			return false
		}
		
		if emailTextField.text == "" {
			emailTextField.layer.borderWidth = 0.3
			emailTextField.layer.borderColor = UIColor.red.cgColor
			emailTextField.layer.cornerCurve = .circular
			emailTextField.layer.cornerRadius = 5
			
			return false
		}
		
		if passwordTextField.text == ""{
			passwordTextField.layer.borderWidth = 0.3
			passwordTextField.layer.borderColor = UIColor.red.cgColor
			passwordTextField.layer.cornerCurve = .circular
			passwordTextField.layer.cornerRadius = 5
			
			return false
		}
		
		if salaryTextField.text == "" {
			salaryTextField.layer.borderWidth = 0.3
			salaryTextField.layer.borderColor = UIColor.red.cgColor
			salaryTextField.layer.cornerCurve = .circular
			salaryTextField.layer.cornerRadius = 5
			
			return false
		}
		
		if biographyTextView.text == "" {
			biographyTextView.layer.borderWidth = 0.3
			biographyTextView.layer.borderColor = UIColor.red.cgColor
			biographyTextView.layer.cornerCurve = .circular
			biographyTextView.layer.cornerRadius = 5
			
			return false
		}
		
		return true
	}
	
	// MARK: API Functions
	private func addUser() {
		let newUser = getValues()
		
		NetworkingProvider.shared.register(user: newUser) { status, msg in
			let statusCode = status
			guard let msg = msg else { return }
			
			if statusCode == 1 {
				self.alertFunction(title: "Felicidades", msg: msg)
			} else if statusCode == 0 {
				let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Volver", style: .cancel))
				
				self.present(alert, animated: true)
			}
		} failure: { error in
			if let error = error {
				debugPrint(error)
			}
		}
	}
	
	// MARK: Styles and Custom Actions
	private func textFieldStyles(textField: UITextField, placeholderText: String) {
		// Global Input Type Style Atributtes
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.mainColorLowOpacity,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProRegular.rawValue, size: 17)
		]
		
		textField.attributedPlaceholder = NSAttributedString(
			string: placeholderText,
			attributes: attributes as [NSAttributedString.Key: Any]
		)
		
		textField.tintColor = .mainColor
		textField.text = ""
	}
	
	private func segmentedControlsStyles(){
		workplaceSegmentedControls.setTitleTextAttributes([
			NSAttributedString.Key.foregroundColor: UIColor.white,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProSemibold.rawValue, size: 14) as Any
		], for: .normal)
		workplaceSegmentedControls.backgroundColor = .mainColorLowOpacity
		workplaceSegmentedControls.selectedSegmentTintColor = .mainColor
	}
	
	private func textViewStyle(){
		biographyTextView.text = ""
		biographyTextView.font = UIFont(name: FontType.SFProRegular.rawValue, size: 12)
		biographyTextView.tintColor = .mainColor
		biographyTextView.layer.borderWidth = 0.3
		biographyTextView.layer.cornerCurve = .circular
		biographyTextView.layer.cornerRadius = 10
		biographyTextView.layer.borderColor = UIColor.mainColorLowOpacity?.cgColor
	}
	
	private func registerButtonStyle(){
		registerButton.layer.cornerCurve = .circular
		registerButton.layer.cornerRadius = 10
	}
	
	
	private func showAndHidePassword(){
		let imageEye = UIImageView()
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
	
	// MARK: Button Action Functions
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func registerButtonAction(_ sender: UIButton) {
		if checkFields() {
			addUser()
		}
	}
}


extension RegisterViewController: UITextViewDelegate {
	// Limit Characters of Text View
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		let currentText = textView.text ?? ""
		
		guard let stringRange = Range(range, in: currentText) else { return false }
		
		let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
		
		return updatedText.count <= 255
	}
}
