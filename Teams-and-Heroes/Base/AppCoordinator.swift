//
//  AppCoordinator.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 09.11.2021.
//

import UIKit

class AppCoordinator: NSObject {
    
    var window: UIWindow
    var router: MainRouter?

    init(window: UIWindow?) {
        self.window = window!
        super.init()
        
        startScreenFlow()
    }
    
    func didFinishLaunchingWithOptions(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
    }

    private func startScreenFlow() {
        let navController = UINavigationController()
        router = MainRouter(navigationController: navController)
        router?.startVC(teams: [Teams]())
//        router?.pushSearchMain()
//        router?.pushSearchResult(refs: [ReferatsResponse.SearchRes](), searchFilters: [SearchFiltersResponse.filters]())
        //router?.pushOpenReferat(pages: [ShowRefResponse.asPic](), fullText: "")
        self.window.rootViewController = navController
        self.window.makeKeyAndVisible()
    }
}
