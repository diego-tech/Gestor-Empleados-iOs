//
//  ModifyDataViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 22/1/22.
//

import UIKit

class ModifyDataViewController: UIViewController {
	
	// Variable
	var id: Int = 0
	var name: String?
	var email: String?
	var workplace: String?
	var salary: String?
	var biography: String?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		print(id)
		print(name)
		print(workplace)
		print(salary)
		print(biography)
		print(email)
    }
}
