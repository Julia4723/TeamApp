//
//  TabBarViewController.swift
//  TeamApp
//
//  Created by user on 17.04.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        
    }
    
    

    // Для передачи данных между таббаами
    private func setupViewControllers() {
        guard let characterTableVC = viewControllers?.first as? CharactersTableViewController else { return }
        guard let settingsVC = viewControllers?.last as? SettingsViewController else { return }
        
    }
    
    

     
}

