//
//  ProfileViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit

class ProfileViewController: UIViewController {
	
	// Outlets
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var workplaceLabel: UILabel!
	@IBOutlet weak var biographyLabel: UILabel!
	@IBOutlet weak var salaryLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		getProfileData()
    }
	
	// MARK: Button Action Functions
	@IBAction func goToChangePasswordAction(_ sender: Any) {
		navigateToChangePassword()
	}
	
	@IBAction func logOutButtonAction(_ sender: Any) {
		// Comprobar problema tras logout
		// logOut()
	}
	
	// MARK: API Functions
	private func getProfileData(){
		NetworkingProvider.shared.seeProfile { responseData, status in
			
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
		NetworkingProvider.shared.logout { responseData in
			self.navigateToAuth()
			UserDefaultsProvider.remove(key: .authUserToken)
			print( UserDefaultsProvider.string(key: .authUserToken))
		} failure: { error in
			print(error)
		} status: { status in
			print(status)
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
