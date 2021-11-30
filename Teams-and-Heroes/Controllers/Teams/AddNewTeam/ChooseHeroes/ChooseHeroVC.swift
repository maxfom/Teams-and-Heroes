//
//  ChooseHeroVC.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 01.12.2021.
//

import UIKit
import CoreData

class ChooseHeroVC: UIViewController, Routable {
    
    var router: MainRouter?
    
    // MARK: - UI Elements
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.color = .lightGray
        return activityIndicatorView
    }()
    
    private let overlayLoadView: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.1)
        view.alpha = 0
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 80))
        tableView.register(ChooseHeroTableViewCell.self, forCellReuseIdentifier: chooseHeroCell)
        return tableView
    }()
    
    private let chooseHeroCell = "chooseHeroCell"
    
    private let lineBottom: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = UIColor().colorFromHex("#7D8185")
        return line
    }()
    
    private let bottomMenuButtonLines: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        button.tintColor = UIColor().colorFromHex("#7DC041")
        button.addedTouchArea = 10
        return button
    }()
    
    private let bottomMenuButtonBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = UIColor().colorFromHex("#7DC041")
        button.addTarget(self, action: #selector(buttonBackTap), for: .touchUpInside)
        button.addedTouchArea = 10
        return button
    }()
    
    private  let bottomMenuButtonFilter: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "vector.filt"), for: .normal)
        button.tintColor = UIColor().colorFromHex("#7DC041")
        button.addTarget(self, action: #selector(bottomMenuButtonFilterTap), for: .touchUpInside)
        button.addedTouchArea = 10
        return button
    }()
    
    // MARK: - Properties
    private var heroes: [Hero]
    
    init(heroes: [Hero]) {
        self.heroes = heroes
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllHeroes()
        setupViews()
        setupConstraints()
        //navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTeamButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(overlayLoadView)
    }
    
    private func getAllHeroes() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Hero> = Hero.fetchRequest()
        
        do {
            self.heroes = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @objc func bottomMenuButtonFilterTap() {
        
    }
    
    @objc private func buttonBackTap() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func startLoading() {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseInOut) {
            self.overlayLoadView.alpha = 1
        }
        
        view.bringSubviewToFront(overlayLoadView)
        view.isUserInteractionEnabled = false
        loadingIndicator.isHidden = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
    }
    
    private func stopLoading() {
        UIView.animate(withDuration: 0.33, delay: 0, options: .curveEaseInOut) {
            self.overlayLoadView.alpha = 0
        }
        view.isUserInteractionEnabled = true
        loadingIndicator.stopAnimating()
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource

extension ChooseHeroVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chooseHeroCell", for: indexPath) as! ChooseHeroTableViewCell
        if heroes.isEmpty {
            return cell
        } else {
            cell.configure(with: heroes, index: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: SetupConstraints

extension ChooseHeroVC {
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints { table in
            table.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            table.right.equalTo(view)
            table.left.equalTo(view).offset(-20)
            table.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        overlayLoadView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
