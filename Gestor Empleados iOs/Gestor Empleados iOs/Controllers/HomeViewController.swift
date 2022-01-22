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
	
	// Floating Button
	private let floatingButton: UIButton = {
		let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
		button.backgroundColor = .mainColor
		
		let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
		button.setImage(image, for: .normal)
		button.tintColor = .white
		button.setTitleColor(.mainColor, for: .normal)
		button.layer.shadowRadius = 10
		button.layer.shadowOpacity = 0.3
		
		// Corner Radius
		button.layer.cornerRadius = 30
		return button
	}()
	
	// Outlets
	@IBOutlet weak var employeeListView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		self.employeeListView.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomEmployeeCell")
		
		employeeListView.allowsSelection = true
		
		employeeList()
		
		// Employee List Styles
		employeeListView.separatorStyle = .singleLine
  		employeeListView.showsVerticalScrollIndicator = false
		
		// Floating Button Initialisation
		floatingButtonInit()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		// Floating Button
		floatingButton.frame = CGRect(x: view.frame.size.width - 120,
									  y: view.frame.size.height - 200,
									  width: 60,
									  height: 60)
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
	
	// MARK: Floating Button Styles
	private func floatingButtonInit() {
		view.addSubview(floatingButton)
		floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
	}
	
	@objc private func didTapButton() {
		let storyBoard = UIStoryboard(name: "Register", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
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
		
		cell.layer.cornerRadius = 8
		cell.layer.masksToBounds = true
	
		return cell
	}
}

