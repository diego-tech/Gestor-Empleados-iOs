//
//  EmployeeListTableViewCell.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 18/1/22.
//

import UIKit

class EmployeeListTableViewCell: UITableViewCell {

	@IBOutlet weak var employeeName: UILabel!
	@IBOutlet weak var employeeWorkplace: UILabel!
	@IBOutlet weak var employeeSalary: UILabel!
	
	func setCellWithValueOf(_ employee: Data) {
		updateUI(employeeName: employee.name, employeeWorkplace: employee.workplace, employeeSalary: employee.salary)
	}
	
	private func updateUI(employeeName: String?, employeeWorkplace: String?, employeeSalary: String?) {
		self.employeeName.text = employeeName
		self.employeeWorkplace.text = employeeWorkplace
		self.employeeSalary.text = employeeSalary
	}
}
