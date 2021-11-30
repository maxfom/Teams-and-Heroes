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
    
    func startVC(teams: [Teams]) {
        let mainTeamsVC = MainTeamsVC(teams: teams)
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
    func pushAddNewTeam(teams: [Teams]) {
        let addNewTeamVC = AddNewTeamVC(teams: teams)
        pushViewController(vc: addNewTeamVC)
    }
    
    func pushChooseHeroes(heroes: [Hero]) {
        let chooseHeroVC = ChooseHeroVC(heroes: heroes)
        pushViewController(vc: chooseHeroVC)
    }
    
    func pushAddNewHero(heroes: [Hero]) {
        let addNewHeroVC = AddNewHeroVC(heroes: heroes)
        pushViewController(vc: addNewHeroVC)
    }

    
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
