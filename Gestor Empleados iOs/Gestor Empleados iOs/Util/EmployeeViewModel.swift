//
//  EmployeeViewModel.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import Foundation
import Alamofire

class EmployeeViewModel {
	
	let authToken: HTTPHeaders = [.authorization(Constants.kAuthToken!)]
	private var employeeList = [Data]()
	
	func fetchEmployeeList(completion: @escaping () -> ()) {
		NetworkingProvider.shared.employeeList(authToken: authToken) { responseData, status in
			// self.employeeList
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
