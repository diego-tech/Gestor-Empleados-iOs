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
	private var status = Int()
	
	func fetchEmployeeList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.employeeList() { responseData, status, msg in
			if let responseList = responseData, let status = status {
				self.employeeList = responseList
				self.status = status
				completion(status)
			}
		} failure: { error in
			if let error = error {
				debugPrint(error)
			}
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
