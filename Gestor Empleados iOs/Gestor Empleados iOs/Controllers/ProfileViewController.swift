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

		nameLabel.text = Constants.kAuthUserName
		workplaceLabel.text = Constants.kAuthUserWorkplace
		biographyLabel.text = Constants.kAuthUseBiography
		salaryLabel.text = Constants.kAuthUserSalary
    }
}
