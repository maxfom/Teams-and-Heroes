//
//  MainRouter.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 09.11.2021.
//

import UIKit

protocol Routable: UIViewController {
    var router: MainRouter? { get set }
}

class MainRouter: NSObject {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    func startVC() {
        let mainTeamsVC = MainTeamsVC()
        mainTeamsVC.router = self
        pushViewController(vc: mainTeamsVC)
    }
//
//    func presentSideMenu() {
//        let sideMenuVC = SideMenuVC()
//        sideMenuVC.router = self
//        let menu = SideMenuNavigationController(rootViewController: sideMenuVC)
//        menu.leftSide = true
//        navigationController.present(menu, animated: true, completion: nil)
//    }
//
//    func pushSearchMain() {
//        let searchVC = SearchMainVC()
//        pushViewController(vc: searchVC)
//    }

    
    private func pushViewController(vc: Routable) {
        vc.router = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    private func presentViewController(vc: Routable, animated: Bool) {
        vc.router = self
        vc.modalPresentationStyle = .overFullScreen
        navigationController.present(vc, animated: true)
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
