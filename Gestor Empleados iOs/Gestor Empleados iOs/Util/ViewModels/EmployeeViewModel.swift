//
//  EmployeeViewModel.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import Foundation
import Alamofire

class EmployeeViewModel {
	
	private var employeeList = [Data]()
	
	func fetchEmployeeList(completion: @escaping () -> ()) {
		NetworkingProvider.shared.employeeList() { responseData, status in
			self.employeeList = responseData!
			completion()
		} failure: { error in
			print(error)
		}
	}
	
	func numberOfRowsInSection(section: Int) -> Int {
		if employeeList.count != 0 {
			return employeeList.count
		}
		return 0
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Data {
		return employeeList[indexPath.row]
	}
}
