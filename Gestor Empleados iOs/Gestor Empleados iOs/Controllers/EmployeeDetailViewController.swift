//
//  EmployeeDetailViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

	var id: Int = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		NetworkingProvider.shared.employeeDetail(id: id) { responseData in
			print(responseData)
		} failure: { error in
			
		} status: { status in
			
		}
    }
}
