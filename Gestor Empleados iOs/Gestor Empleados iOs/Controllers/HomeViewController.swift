//
//  HomeViewController.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 18/1/22.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
	
	// Variables
	private var employeeViewModel = EmployeeViewModel()
	private var employee: Data?
	
	// Outlets
	@IBOutlet weak var employeeListView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		self.employeeListView.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomEmployeeCell")
		
		employeeListView.allowsSelection = true
		employeeList()
    }
	
	// MARK: API Functions
	private func employeeList(){
		employeeViewModel.fetchEmployeeList { [weak self] in
			self?.employeeListView.dataSource = self
			self?.employeeListView.delegate = self
			self?.employeeListView.reloadData()
		}
	}
	
	// MARK: Functions
	private func navigate(){
		let storyBoard = UIStoryboard(name: "EmployeeDetail", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeDetail") as! EmployeeDetailViewController
		self.present(vc, animated: false, completion: nil)
	}
}


// MARK: - TableView Extension
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return employeeViewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		employeeListView.deselectRow(at: indexPath, animated: true)
		employee = employeeViewModel.cellForRowAt(indexPath: indexPath)
		
		// Mandar Id Seleccionado
		let storyBoard = UIStoryboard(name: "EmployeeDetail", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeDetail") as! EmployeeDetailViewController
		
		if let id = employee?.id {
			vc.id = id
		}
		
		self.present(vc, animated: true, completion: nil)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = employeeListView.dequeueReusableCell(withIdentifier: "CustomEmployeeCell", for: indexPath) as! EmployeeListTableViewCell
		
		employee = employeeViewModel.cellForRowAt(indexPath: indexPath)
		cell.setCellWithValueOf(employee!)
	
		return cell
	}
}

