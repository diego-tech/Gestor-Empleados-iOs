//
//  RegisterEmployeeViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 22/1/22.
//

import UIKit

class RegisterViewController: UIViewController {

	// Variables
	var userName: String?
	var userEmail: String?
	var userPassword: String?
	var userWorkplace: String?
	var userSalary: String?
	var userBiography: String?
		
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
		
		// Styles
		textFieldStyles(textField: nameTextField, placeholderText: "Nombre")
		
		textFieldStyles(textField: emailTextField, placeholderText: "Correo Electrónico")
		emailTextField.keyboardType = .emailAddress
		
		textFieldStyles(textField: passwordTextField, placeholderText: "Contraseña")
		passwordTextField.isSecureTextEntry = true
		
		textFieldStyles(textField: salaryTextField, placeholderText: "Salario")
		
		segmentedControlsStyles()
		textViewStyle()
		registerButtonStyle()
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
		alert.addAction(UIAlertAction(title: "Volver", style: .default,handler: { action in
			self.navigateWhenCreateUser()
		}))
		
		present(alert, animated: true)
	}
	
	// MARK: API Functions
	private func addUser() {
		let newUser = getValues()
		
		NetworkingProvider.shared.register(user: newUser) { responseData in
			self.alertFunction(title: "Felicidades", msg: (responseData?.msg)!)
		} failure: { error in
			print(error)
		} status: { status in
			print(self)
		}
	}
	
	// MARK: Styles Functions
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
			NSAttributedString.Key.foregroundColor : UIColor.white,
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
	
	// MARK: Button Action Functions
	@IBAction func goBackButtonAction(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func registerButtonAction(_ sender: Any) {
		addUser()
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
