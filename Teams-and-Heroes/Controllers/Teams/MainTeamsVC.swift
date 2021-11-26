//
//  MainTeamsVC.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 09.11.2021.
//

import UIKit
import CoreData

protocol SearchResultVCDelegate: AnyObject {
    func updateSearchFilter(filter: String)
}

class MainTeamsVC: UIViewController, Routable {
    
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
        tableView.register(MainTeamsTableViewCell.self, forCellReuseIdentifier: mainTeamsCell)
        return tableView
    }()
    
    private let mainTeamsCell = "mainTeamsCell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
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
    private var teams: [Teams]
    private var searchText: String = ""
    
    init(teams: [Teams]) {
        self.teams = teams
        super.init(nibName: nil, bundle: nil)
        searchController.searchBar.text = searchText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTeams()
        setupNavBar()
        setupViews()
        setupConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTeamButtonTapped))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupSearchController()
        tableView.reloadData()
        print(teams.count)
    }
    
    private func setupNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(overlayLoadView)
    }
    
    @objc func addTeamButtonTapped() {
        router?.pushAddNewTeam(teams: teams)
    }
    
    @objc func bottomMenuButtonFilterTap() {
    }
    
    @objc private func buttonBackTap() {
        navigationController?.popViewController(animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func getAllTeams() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Teams> = Teams.fetchRequest()
        
        do {
            self.teams = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func deleteOneTeam(team: Teams) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        //let fetchRequest: NSFetchRequest<Teams> = Teams.fetchRequest()
        context.delete(team)
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    private func setupSearchController() {
        // Устанавливаем search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // Отключаем ограничение на взаимодействие с объектами результата поиска
        searchController.searchBar.placeholder = "Искать"
        navigationItem.searchController = searchController
        definesPresentationContext = true // Позволяет отпустить строку поиска, при переходе на другой экран
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

extension MainTeamsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (teams.isEmpty) {
            return 5 } else {
                return teams.count
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainTeamsCell", for: indexPath) as! MainTeamsTableViewCell
        if teams.isEmpty {
            return cell
        } else {
        cell.configure(with: teams, index: indexPath.row)
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editingRow = teams[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            self.deleteOneTeam(team: editingRow)
            DispatchQueue.main.async {
                self.teams.remove(at: indexPath.row)
                self.tableView.reloadData()
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

//MARK: SetupConstraints

extension MainTeamsVC {
    
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

extension MainTeamsVC: SearchResultVCDelegate {
    
    func updateSearchFilter(filter: String) {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty
        else {
            emptyResultError()
            return
        }
    }
}

extension MainTeamsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text,
              !searchText.isEmpty
        else {
            emptyResultError()
            return
        }
    }
    
    private func emptyResultError() {
        stopLoading()
        tableView.reloadData()
    }
}
