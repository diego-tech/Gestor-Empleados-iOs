//
//  ChangePasswordViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit
import Alamofire

class ChangePasswordViewController: UIViewController {
	
	var firstPassword: String?
	var secondPassword: String?
	
	var iconClick = false
	
	// Outlets
	@IBOutlet weak var firstPasswordTextField: UITextField!
	@IBOutlet weak var secondPasswordTextField: UITextField!
	@IBOutlet weak var acceptButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Styles And Custom Actions
		textFieldStyle()
		acceptButtonStyle()
    }
    
	
	// MARK: Action Buttons
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func acceptButtonAction(_ sender: UIButton) {
		firstPassword = firstPasswordTextField.text
		secondPassword = secondPasswordTextField.text
		
		if let firstPassword = firstPassword, let secondPassword = secondPassword {
			if firstPassword != "", secondPassword != "" {
				// Comprobar problema tras change password
				let password = NewPassword(password: firstPassword, repeatPassword: secondPassword)
				changePassword(password: password)
			}
		}
	}
	
	// MARK: Functions
	private func navigateToAuth(){
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
		self.present(vc, animated: true, completion: nil)
	}

	// MARK: API Function
	private func changePassword(password: NewPassword){
		NetworkingProvider.shared.changePassword(passwords: password) { status, message in
			guard let msg = message else { return }
			
			if status != Constants.kErrorStatusCode {
				UserDefaultsProvider.remove(key: .authUserToken)

				let alert = UIAlertController(title: "Confirmación", message: msg, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
					self.navigateToAuth()
				}))
				self.present(alert, animated: true)
			} else {
				let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
				self.present(alert, animated: true)
			}
		} failure: { error in
			if let error = error {
				debugPrint(error)
			}
		}
	}

	// MARK: Styles
	private func textFieldStyle(){
		// Global Input Type Style Atributtes
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.mainColorLowOpacity,
			NSAttributedString.Key.font: UIFont(name: FontType.SFProRegular.rawValue, size: 17)
		]
		
		// First Password Text Field Styles
		firstPasswordTextField.attributedPlaceholder = NSAttributedString(
			string: "Contraseña",
			attributes: attributes as [NSAttributedString.Key: Any]
		)
		firstPasswordTextField.tintColor = .mainColor
		firstPasswordTextField.isSecureTextEntry = true
		firstPasswordTextField.showAndHidePassword()
		
		// Second Password Text Field Styles
		secondPasswordTextField.attributedPlaceholder = NSAttributedString(
			string: "Confirmar Contraseña",
			attributes: attributes as [NSAttributedString.Key: Any]
		)
		secondPasswordTextField.tintColor = .mainColor
		secondPasswordTextField.isSecureTextEntry = true
		secondPasswordTextField.showAndHidePassword()
	}
	
	private func acceptButtonStyle() {
		acceptButton.layer.cornerCurve = .circular
		acceptButton.layer.cornerRadius = 10
	}
}
