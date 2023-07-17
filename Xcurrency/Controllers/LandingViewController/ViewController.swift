//
//  ViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if  isLoggedIn {
            let navC = UINavigationController(rootViewController: OnboardingViewController())
            navC.modalPresentationStyle = .fullScreen
            present(navC , animated: false)
            
        }else {
            let vC =  HamburgerViewController()
            vC.modalPresentationStyle = .fullScreen
            present(vC , animated: false)
        }
       
    }
}

