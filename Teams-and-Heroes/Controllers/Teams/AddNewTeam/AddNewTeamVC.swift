//
//  AddNewTeamVC.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 14.11.2021.
//

import UIKit
import CoreData

class AddNewTeamVC: UITableViewController, Routable {
    
    var router: MainRouter?
    
    var teams: [Teams]
    
    private let idAddNewTeamCell = "idAddNewTeamCell"
    private let idOptionTasksHeader = "idOptionTasksHeader"
    
    let headerNameArray = ["Title Of Your Team", "Choose Your Heroes", "Who is the Leader?", "Icon of Team"]
    let cellNameArray = ["Name Team", "Name 2", "Name 3", "Name 4"]
    
    private var titleTeam: String = ""
    private var leaderTeam: String = ""
    
    private var imageIsChanged = false
    
    init(teams: [Teams]) {
        self.teams = teams
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add new Team"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        //tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionTaskCell)
        tableView.separatorStyle = .none
        //tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionTasksHeader)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        tableView.register(AddNewTeamTableViewCell.self, forCellReuseIdentifier: idAddNewTeamCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionTasksHeader)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonTapped))
        
    }
    
    @objc func backButtonTapped() {
        router?.startVC(teams: teams)
    }
    
    @objc func saveButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard  let entity = NSEntityDescription.entity(forEntityName: "Teams", in: context)  else { return }
        
        let teamsObject = Teams(entity: entity, insertInto: context)
        teamsObject.name = titleTeam
        teamsObject.leader = leaderTeam
        guard let lastId = teams.last?.id else { return }
        teamsObject.id = lastId + 1
        
        do {
            try context.save()
            self.teams.append(teamsObject)
            alertOk(title: "Team added", message: "New team added succesful")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        dismiss(animated: true) { [self] in
        router?.startVC(teams: self.teams)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddNewTeamCell, for: indexPath) as! AddNewTeamTableViewCell
        cell.configure(cellNameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AddNewTeamTableViewCell
        
        switch indexPath.section {
        case 0:
            alertForCellName(label: cell.nameCellLabel, name: "Name team", placeholder: "Enter name team") { text in
                self.titleTeam = text
            }
        case 1:
            alertForCellName(label: cell.nameCellLabel, name: "Choose your heroes", placeholder: "Get Heroes") { text in
            }
        case 2:
            alertForCellName(label: cell.nameCellLabel, name: "Who is your leader?", placeholder: "Choose you leader") { text in
                self.leaderTeam = text
            }
        case 3:
            alertPhotoCamera { [self] source in
                chooseImagePicker(source: source)
            }
        default:
            print("Add click")
        }
    }
}

extension AddNewTeamVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [3, 0]) as! AddNewTeamTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
}
