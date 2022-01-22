//
//  ChangePasswordViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit
import Alamofire

class ChangePasswordViewController: UIViewController {
	
	// Variables
	let authToken: HTTPHeaders = [.authorization(Constants.kAuthUserToken!)]

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
		showAndHidePassword(textField: secondPasswordTextField)
    }
    
	
	// MARK: Action Buttons
	@IBAction func goBackButtonAction(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func acceptButtonAction(_ sender: Any) {
		firstPassword = firstPasswordTextField.text
		secondPassword = secondPasswordTextField.text
		
		if let firstPassword = firstPassword, let secondPassword = secondPassword {
			if firstPassword != "", secondPassword != "" {
				// Comprobar problema tras change password
				let password = NewPassword(password: firstPassword, repeatPassword: secondPassword)
				UserDefaultsProvider.remove(key: .authUserToken)
				changePassword(password: password)
			}
		}
	}
	
	// MARK: API Function
	private func changePassword(password: NewPassword){
		NetworkingProvider.shared.changePassword(passwords: password) { status, message in
			print(message)
		} failure: { error in
			print(error)
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
		
		// Second Password Text Field Styles
		secondPasswordTextField.attributedPlaceholder = NSAttributedString(
			string: "Confirmar Contraseña",
			attributes: attributes as [NSAttributedString.Key: Any]
		)
		secondPasswordTextField.tintColor = .mainColor
		secondPasswordTextField.isSecureTextEntry = true
	}
	
	private func acceptButtonStyle() {
		acceptButton.layer.cornerCurve = .circular
		acceptButton.layer.cornerRadius = 10
	}
	
	private func showAndHidePassword(textField: UITextField) {
		let imageEye = UIImageView()
		imageEye.image = UIImage(named: "CloseEye")
		
		let contentView = UIView()
		
		contentView.addSubview(imageEye)
		
		contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)

		imageEye.frame = CGRect(x: -10, y: 0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)
		
		textField.rightView = contentView
		textField.rightViewMode = .always

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		imageEye.isUserInteractionEnabled = true
		imageEye.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		
		if iconClick {
			iconClick = false
			firstPasswordTextField.isSecureTextEntry = false
			secondPasswordTextField.isSecureTextEntry = false
			tappedImage.image = UIImage(named: "EyeOpen")
		} else {
			iconClick = true
			firstPasswordTextField.isSecureTextEntry = true
			secondPasswordTextField.isSecureTextEntry = true
			tappedImage.image = UIImage(named: "CloseEye")
		}
	}
}
