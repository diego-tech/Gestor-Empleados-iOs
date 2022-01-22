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
	private var userName: String?
	private var userWorkplace: String?
	private var userBiography: String?
	private var userSalary: String?
	
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
	
	// MARK: Functions
	
	
	// MARK: Action Buttons
	@IBAction func editProfileButtonAction(_ sender: Any) {
	}
	
	@IBAction func goBackButtonAction(_ sender: Any) {
		dismiss(animated: false, completion: nil)
	}
	
	// MARK: Styles
	private func detailViewStyle() {
		detailView.layer.cornerCurve = .circular
		detailView.layer.cornerRadius = 10
	}
}
