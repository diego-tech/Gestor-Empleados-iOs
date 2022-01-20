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
	private let imageEye = UIImageView()
	
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
		showAndHidePassword()
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
				let password = NewPassword(password: firstPassword, repeatPassword: secondPassword)
				UserDefaultsProvider.remove(key: .authUserToken)
				changePassword(password: password)
			}
		}
	}
	
	// MARK: API Function
	private func changePassword(password: NewPassword){
		NetworkingProvider.shared.changePassword(passwords: password) { responseData in
			print(responseData?.msg)			
			let storyBoard = UIStoryboard(name: "Main", bundle: nil)
			let vc = storyBoard.instantiateViewController(withIdentifier: "TabBarController") as! AuthViewController
			self.present(vc, animated: true, completion: nil)
		} failure: { error in
			print(error)
		} status: { status in
			print(status)
		}
	}
	
	// MARK: Functions

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
	
	private func showAndHidePassword() {
		imageEye.image = UIImage(named: "CloseEye")
		
		let contentView = UIView()
		
		contentView.addSubview(imageEye)
		
		contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)

		imageEye.frame = CGRect(x: -10, y: 0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)
		
		firstPasswordTextField.rightView = contentView
		firstPasswordTextField.rightViewMode = .always
		
//		secondPasswordTextField.rightView = contentView
//		secondPasswordTextField.rightViewMode = .always

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		imageEye.isUserInteractionEnabled = true
		imageEye.addGestureRecognizer(tapGestureRecognizer)
	}
	
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		
		if iconClick {
			iconClick = false
			tappedImage.image = UIImage(named: "EyeOpen")
			firstPasswordTextField.isSecureTextEntry = false
			secondPasswordTextField.isSecureTextEntry = false
		} else {
			iconClick = true
			tappedImage.image = UIImage(named: "CloseEye")
			firstPasswordTextField.isSecureTextEntry = true
			secondPasswordTextField.isSecureTextEntry = true
		}
	}
}
