//
//  EmployeeDetailViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

	// Variables
	var id: Int = 0
	var detailUserName: String? = ""
	var detailUserEmail: String? = ""
	var detailUserWorkplace: String? = ""
	var detailUserSalary: String? = ""
	var detailUserBiography: String? = ""
	
	// Outlets
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var workplaceLabel: UILabel!
	@IBOutlet weak var biographyLabel: UILabel!
	@IBOutlet weak var salaryLabel: UILabel!
	@IBOutlet weak var editProfileButton: UIButton!
	@IBOutlet weak var detailView: UIView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
				
		getUserDetail()
    }
	
	// MARK: API Functions
	private func getUserDetail() {
		NetworkingProvider.shared.employeeDetail(id: id) { responseData, status, msg in
			if let userName = responseData?.name, let userWorkplace = responseData?.workplace, let userBiography = responseData?.biography, let userSalary = responseData?.salary, let userEmail = responseData?.email {
				self.nameLabel.text = userName
				self.workplaceLabel.text = userWorkplace
				self.biographyLabel.text = userBiography
				self.salaryLabel.text = userSalary
				
				self.detailUserName = userName
				self.detailUserEmail = userEmail
				self.detailUserWorkplace = userWorkplace
				self.detailUserSalary = userSalary
				self.detailUserBiography = userBiography
			}
		} failure: { error in
			if let error = error {
				debugPrint(error)
			}
		}
	}
	
	// MARK: Functions
	private func navigate(){
		let storyBoard = UIStoryboard(name: "ModifyData", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "ModifyData") as! ModifyDataViewController
		vc.id = id
		vc.name = detailUserName
		vc.email = detailUserEmail
		vc.workplace = detailUserWorkplace
		vc.salary = detailUserSalary
		vc.biography = detailUserBiography
		
		self.present(vc, animated: true, completion: nil)
	}
	
	// MARK: Action Buttons
	@IBAction func editProfileButtonAction(_ sender: UIButton) {
		navigate()
	}
	
	@IBAction func goBackButtonAction(_ sender: UIButton) {
		dismiss(animated: false, completion: nil)
	}
	
	// MARK: Styles
	private func detailViewStyle() {
		detailView.layer.cornerCurve = .circular
		detailView.layer.cornerRadius = 10
	}
}
