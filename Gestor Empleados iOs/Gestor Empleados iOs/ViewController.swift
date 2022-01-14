//
//  ViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		NetworkinProvider.shared.seeProfile { user in
			print(user)
		} failure: { error in
			print(error.debugDescription)
		}
	}
}

