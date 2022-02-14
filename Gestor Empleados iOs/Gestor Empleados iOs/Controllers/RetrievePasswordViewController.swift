//
//  RetrievePasswordViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 18/1/22.
//

import UIKit

class RetrievePasswordViewController: UIViewController {

	// Variables
	var email: String?
	
	// Outlets
	@IBOutlet weak var emailTextField: UITextField!
	@IBOutlet weak var retrievePasswordButton: UIButton!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Styles
		textFieldStyle()
		sendButtonStyle()
    }
	
	// MARK: Action Buttons
	@IBAction func retrievePasswordButtonAction(_ sender: UIButton) {
		email = emailTextField.text
				
		if let userEmail = email {
			if userEmail != "" {
				retrievePassword(userEmail: userEmail)
			}
		}
	}
	
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: API Functions
	private func retrievePassword(userEmail: String) {
		NetworkingProvider.shared.retrievePassword(email: userEmail) {status, msg in
			if let responseMsg = msg {
				self.alertFunction(title: "Contraseña Enviada", msg: responseMsg)
			}
		} failure: { error in
			if let error = error {
				self.alertFunction(title: "Error", msg: error.localizedDescription)
			}
		}
	}
	
	// MARK: Functions
	private func alertFunction(title: String, msg: String){
		let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Volver", style: .default,handler: { action in
			self.dismiss(animated: true, completion: nil)
			self.emailTextField.text = ""
		}))
		
		present(alert, animated: true)
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
	}
	
	private func sendButtonStyle() {
		retrievePasswordButton.layer.cornerCurve = .circular
		retrievePasswordButton.layer.cornerRadius = 10
	}
}
