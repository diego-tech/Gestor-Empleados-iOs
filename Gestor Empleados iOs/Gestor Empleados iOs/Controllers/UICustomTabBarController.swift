//
//  UITabBar.swift
//  Gestor Empleados iOs
//
//  Created by Diego Muñoz Herranz on 19/1/22.
//

import UIKit

class UICustomTabBarController: UITabBarController {

	var customTabBarView = UIView(frame: .zero)
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		self.setupTabBarUI()
		self.addCustomTabBarView()
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.setupCustomTabBarFrame()
	}
	
	// MARK: Styles Methods
	private func setupCustomTabBarFrame() {
		let height = self.view.safeAreaInsets.bottom + 64
		
		var tabFrame = self.tabBar.frame
		tabFrame.size.height = height
		tabFrame.origin.y = self.view.frame.size.height - height
		
		self.tabBar.frame = tabFrame
		self.tabBar.setNeedsLayout()
		self.tabBar.layoutIfNeeded()
		customTabBarView.frame = tabBar.frame
	}
	
	private func setupTabBarUI() {
		// Setup your colors and corner radius
		self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		self.tabBar.tintColor = .mainColor
		self.tabBar.unselectedItemTintColor = UIColor.grayColor
		
		// Remove the line
		if #available(iOS 13.0, *) {
			let appearance = self.tabBar.standardAppearance
			appearance.shadowImage = nil
			appearance.shadowColor = nil
			self.tabBar.standardAppearance = appearance
		} else {
			self.tabBar.shadowImage = UIImage()
			self.tabBar.backgroundImage = UIImage()
		}
	}
	
	private func addCustomTabBarView() {
		self.customTabBarView.frame = tabBar.frame

		self.customTabBarView.backgroundColor = .white
		self.customTabBarView.layer.borderColor = CGColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
		self.customTabBarView.layer.borderWidth = 1
		self.customTabBarView.layer.cornerRadius = 30
		self.customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

		self.customTabBarView.layer.masksToBounds = false
		self.customTabBarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		self.customTabBarView.layer.shadowOffset = CGSize(width: -4, height: -6)
		self.customTabBarView.layer.shadowOpacity = 0.5
		self.customTabBarView.layer.shadowRadius = 20
		
		self.view.addSubview(customTabBarView)
		self.view.bringSubviewToFront(self.tabBar)
	}
}
