//
//  ModifyDataViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 22/1/22.
//

import UIKit

class ModifyDataViewController: UIViewController {
	
	// Variable
	var id: Int = 0
	var name: String?
	var email: String?
	var workplace: String?
	var salary: String?
	var biography: String?
	
	// Outlets
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var workplaceSegmentedControl: UISegmentedControl!
	@IBOutlet weak var salaryTextField: UITextField!
	@IBOutlet weak var biographyTextView: UITextView!
	@IBOutlet weak var modifyButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
				
		// Styles and Custom Actions
		setValues()
		emailTextField.keyboardType = .emailAddress
		
		segmentedControlsStyles()
		modifyButtonStyle()
    }
	
	// MARK: Functions
	private func setValues(){
		if let userName = name, let userWorkplace = workplace, let userSalary = salary, let userBiography = biography, let userEmail = email {
			textFieldStyles(textField: nameTextField, placeholderText: "", text: userName)
			textFieldStyles(textField: emailTextField, placeholderText: userEmail, text: "")
			textFieldStyles(textField: salaryTextField, placeholderText: "", text: userSalary)
			textViewStyles(textView: biographyTextView, text: userBiography)
			setSegmentedControlsValue(workplace: userWorkplace)
		}
	}
	
	private func setSegmentedControlsValue(workplace: String) {
		if workplace == "Empleado" {
			workplaceSegmentedControl.selectedSegmentIndex = 0
		} else if workplace == "RRHH" {
			workplaceSegmentedControl.selectedSegmentIndex = 1
		} else if workplace == "Directivo" {
			workplaceSegmentedControl.selectedSegmentIndex = 2
		}
	}
	
	private func getValues() -> NewUser {
		if nameTextField.text != "" {
			name = nameTextField.text
		} else {
			name = nil
		}
		
		if emailTextField.text != "" {
			email = emailTextField.text
		} else {
			email = nil
		}
		
		if workplaceSegmentedControl.selectedSegmentIndex == 0 {
			workplace = "Empleado"
		} else if workplaceSegmentedControl.selectedSegmentIndex == 1 {
			workplace = "RRHH"
		} else if workplaceSegmentedControl.selectedSegmentIndex == 2 {
			workplace = "Directivo"
		}
		
		if salaryTextField.text != "" {
			salary = salaryTextField.text
		} else {
			salary = nil
		}
		
		if biographyTextView.text != "" {
			biography = biographyTextView.text
		} else {
			salary = nil
		}
		
		return NewUser(name: name, email: email, password: nil, workplace: workplace, salary: salary, biography: biography)
	}
	
	private func navigateWhenCreateUser() {
		let storyBoard = UIStoryboard(name: "Home", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! UICustomTabBarController
		self.present(vc, animated: true, completion: nil)
	}
	
	private func alertFunction(title: String, msg: String){
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { action in
			self.navigateWhenCreateUser()
		}))
				
		present(alert, animated: true)
	}
	
	
	// MARK: Action Functions
	@IBAction func modifyButtonAction(_ sender: Any) {
		modifyData()
	}
	
	@IBAction func goBackButtonAction(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: API Functions
	private func modifyData(){
		let modifyUser = getValues()
		
		NetworkingProvider.shared.modifyData(userId: id, user: modifyUser) { status, msg in
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
			let error = error
			debugPrint(error as Any)
		}
	}
	
	// MARK: Styles
	private func textFieldStyles(textField: UITextField, placeholderText: String, text: String) {
		// Global Input Type Style Atributtes
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.mainColorLowOpacity,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProRegular.rawValue, size: 17)
		]
		textField.text = ""
		textField.attributedPlaceholder = NSAttributedString(
			string: placeholderText,
			attributes: attributes as [NSAttributedString.Key: Any]
		)
		textField.textColor = .mainColor
		textField.tintColor = .mainColorLowOpacity
		textField.text = text
	}
	
	private func segmentedControlsStyles() {
		workplaceSegmentedControl.setTitleTextAttributes([
			NSAttributedString.Key.foregroundColor: UIColor.white,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProSemibold.rawValue, size: 14) as Any
		], for: .normal)
		workplaceSegmentedControl.backgroundColor = .mainColorLowOpacity
		workplaceSegmentedControl.selectedSegmentTintColor = .mainColor
	}
	
	private func textViewStyles(textView: UITextView, text: String){
		textView.text = ""
		textView.font = UIFont(name: FontType.SFProRegular.rawValue, size: 12)
		textView.tintColor = .mainColor
		textView.layer.borderWidth = 0.3
		textView.layer.cornerCurve = .circular
		textView.layer.cornerRadius = 10
		textView.layer.borderColor = UIColor.mainColorLowOpacity?.cgColor
		textView.text = text
	}
	
	private func modifyButtonStyle() {
		modifyButton.layer.cornerCurve = .circular
		modifyButton.layer.cornerRadius = 10
	}
}
