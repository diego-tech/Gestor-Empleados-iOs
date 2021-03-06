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
	@IBOutlet weak var employeeLabel: UILabel!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// List View Initialisation
		self.employeeListView.register(UINib(nibName: "EmployeeListTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomEmployeeCell")
		employeeListView.allowsSelection = true
		
		// Employee List Styles
		employeeListView.separatorStyle = .singleLine
		employeeListView.showsVerticalScrollIndicator = false
		employeeList()
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Check Permissions
		checkIfHasPermisions()
		
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
		employeeViewModel.fetchEmployeeList { [weak self] status in
			if status != Constants.kErrorStatusCode {
				self?.employeeListView.dataSource = self
				self?.employeeListView.delegate = self
				self?.employeeListView.reloadData()
			} else {
				guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AuthViewController") as? AuthViewController else {
					fatalError("¡No se pudo instanciar AuthVC!")
				}
				self?.present(vc, animated: true, completion: nil)
			}
		}
	}
	
	// MARK: Functions
	private func navigate(){
		let storyBoard = UIStoryboard(name: "EmployeeDetail", bundle: nil)
		let vc = storyBoard.instantiateViewController(withIdentifier: "EmployeeDetail") as! EmployeeDetailViewController
		self.showDetailViewController(vc, sender: self)
	}
	
	private func checkIfHasPermisions() {
		let userWorkplace = UserDefaultsProvider.string(key: .authUserWorkplace)
		
		if userWorkplace == "Empleado" {
			employeeListView.isHidden = true
			employeeLabel.isHidden = false
			floatingButton.isHidden = true
		} else {
			employeeListView.isHidden = false
			employeeLabel.isHidden = true
			floatingButton.isHidden = false
		}
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

