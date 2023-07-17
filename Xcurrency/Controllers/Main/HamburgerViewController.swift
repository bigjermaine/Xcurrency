//
//  HamburgerViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import UIKit

class HamburgerViewController: UIViewController, MenuViewControllerDelegate {
       
    enum MenuState{
        case opened
        case closed
    }
    
        let menVc =  MenuViewController()
        
        let homeVc = HomeViewController()
        
        var navVc:UINavigationController?
        
        let historyVc = HistoryViewController()
        private var menuState:MenuState = .closed
        
        override func viewDidLoad() {
            super.viewDidLoad()

            // Do any additional setup after loading the view.
            view.backgroundColor = .white
           
            addChildVcS()
        }
        
        
         func addChildVcS() {
             menVc.delegate = self
             addChild(menVc)
             view.addSubview(menVc.view)
             menVc.didMove(toParent: self)


             homeVc.delegate = self
             let navVC = UINavigationController(rootViewController: homeVc)
             navVC.title = "Home"
             addChild(navVC)
             view.addSubview(navVC.view)
             navVC.didMove(toParent: self)
             self.navVc = navVC
           
             
             
         }
      

    }
extension HamburgerViewController:HomeViewControllerdelegate {
    func didTapManuButton() {
        switch menuState {
        case .opened:
            UIView.animate(withDuration: 0.2, delay: 0,options: .curveEaseInOut) {
                self.navVc?.view.frame.origin.x = 0
            }completion: { [weak self ]done in
                if done {
                    self?.menuState = .closed
                }
            }
            
        case .closed:
            
            UIView.animate(withDuration: 0.5, delay: 0) {
                self.navVc?.view.frame.origin.x = self.homeVc.view.frame.size.width - 100
            }completion: { [weak self ]done in
                if done {
                    self?.menuState = .opened
                    
                }
            }
            
        }
    }
    
    func didselect(menuItem: MenuViewController.menuOptions) {
        didTapManuButton()
    
        switch menuItem {
            
        case .home:
            resetToHome()
        case .history:
            history()
        case .settings:
            break
        }
    }
    func  history() {
        let vc =  historyVc
       homeVc.addChild(vc)
       homeVc.view.addSubview(vc.view)
       vc.view.frame = view.frame
       vc.didMove(toParent:  homeVc)
       homeVc.title = vc.title
    }
    
    func resetToHome() {
        historyVc.view.removeFromSuperview()
        historyVc.didMove(toParent: self)
    }
   
}
