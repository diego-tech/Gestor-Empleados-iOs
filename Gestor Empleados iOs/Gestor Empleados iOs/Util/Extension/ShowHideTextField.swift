//
//  ShowHideTextField.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 10/2/22.
//

import UIKit

var iconClick = false

extension UITextField {
	func showAndHidePassword(){
		let imageEye = UIImageView()
		imageEye.image = UIImage(named: "CloseEye")
		
		let contentView = UIView()
		contentView.addSubview(imageEye)
		
		contentView.frame = CGRect(x: 0, y: 0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye")!.size.height)
		imageEye.frame = CGRect(x: -10, y: 0, width: UIImage(named: "CloseEye")!.size.width, height: UIImage(named: "CloseEye" )!.size.height)
		
		self.rightView = contentView
		self.rightViewMode = .always

		let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
		
		imageEye.isUserInteractionEnabled = true
		imageEye.addGestureRecognizer(tapGestureRecognizer)
	}
		
	@objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
		let tappedImage = tapGestureRecognizer.view as! UIImageView
		
		if iconClick {
			iconClick = false
			tappedImage.image = UIImage(named: "EyeOpen")
			self.isSecureTextEntry = false
		} else {
			iconClick = true
			tappedImage.image = UIImage(named: "CloseEye")
			self.isSecureTextEntry = true
		}
	}
}
