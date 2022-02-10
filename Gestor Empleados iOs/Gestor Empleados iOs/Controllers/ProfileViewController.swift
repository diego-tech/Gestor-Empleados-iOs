//
//  ProfileViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {
		
	// Outlets
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var workplaceLabel: UILabel!
	@IBOutlet weak var biographyLabel: UILabel!
	@IBOutlet weak var salaryLabel: UILabel!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		getProfileData()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		nameLabel.text = ""
		workplaceLabel.text = ""
		biographyLabel.text = ""
		salaryLabel.text = ""
	}
	
	// MARK: Button Action Functions
	@IBAction func goToChangePasswordAction(_ sender: UIButton) {
		navigateToChangePassword()
	}
	
	@IBAction func logOutButtonAction(_ sender: UIButton) {
		// Comprobar problema tras logout
		 logOut()
	}
	
	// MARK: API Functions
	private func getProfileData(){
		NetworkingProvider.shared.seeProfile { responseData, status, msg in
			if let userName = responseData?.name, let userWorkplace = responseData?.workplace, let userBiography = responseData?.biography, let userSalary = responseData?.salary {
				self.nameLabel.text = userName
				self.workplaceLabel.text = userWorkplace
				self.biographyLabel.text = userBiography
				self.salaryLabel.text = userSalary
			}
		} failure: { error in
			print(error)
		}
	}
	
	private func logOut(){
		NetworkingProvider.shared.logout { status, msg in
			self.navigateToAuth()
			UserDefaultsProvider.remove(key: .authUserToken)
		} failure: { error in 
			print(error)
		}
	}
	
	// MARK: Functions
	private func navigateToAuth(){
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "AuthViewController") as! AuthViewController
		self.present(vc, animated: true, completion: nil)
	}

	private func navigateToChangePassword() {
		let storyBoard = UIStoryboard(name: "ChangePassword", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordViewController
		self.present(vc, animated: true, completion: nil)
	}
}
