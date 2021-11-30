//
//  AddNewHeroVC.swift
//  Teams-and-Heroes
//
//  Created by Максим Фомичев on 30.11.2021.
//

import UIKit
import CoreData

class AddNewHeroVC: UITableViewController, Routable {
    
    var router: MainRouter?
    
    var heroes: [Hero]
    
    private let idAddNewHeroCell = "idAddNewHeroCell"
    private let idOptionHeroesHeader = "idOptionHeroesHeader"
    
    let headerNameArray = ["Name Of Your Hero", "Special speak of Your Hero", "Main item", "Picture for your Hero"]
    let cellNameArray = ["Enter name of hero", "ex. For the Horde!", "ex. Sword", "choose image"]
    
    private var nameHero: String = ""
    private var speakHero: String = ""
    private var mainItem: String = ""
    private var imageHero: Data?
    
    private var imageIsChanged = false
    
    init(heroes: [Hero]) {
        self.heroes = heroes
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
        setupNavBar()
        
        title = "Add new Team"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.968627451, alpha: 1)
        tableView.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        tableView.register(AddNewHeroTableViewCell.self, forCellReuseIdentifier: idAddNewHeroCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionHeroesHeader)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonTapped))
        
        print(heroes)
    }
    
    private func setupNavBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc func backButtonTapped() {
        print("Back")
    }
    
    @objc func saveButtonTapped() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard  let entity = NSEntityDescription.entity(forEntityName: "Hero", in: context)  else { return }
        
        let heroObject = Hero(entity: entity, insertInto: context)
        heroObject.name = nameHero
        heroObject.speak = speakHero
        heroObject.item = mainItem
        heroObject.image = imageHero
        if heroes.last?.id != nil {
        let lastId = heroes.last?.id
        heroObject.id = (lastId ?? 0) + 1
        } else {
        heroObject.id = 1
        }
        do {
            try context.save()
            self.heroes.append(heroObject)
            alertOk(title: "Hero added", message: "New hero added succesful")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        dismiss(animated: true) { [self] in
        router?.startVC(teams: [Teams]())
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idAddNewHeroCell, for: indexPath) as! AddNewHeroTableViewCell
        cell.cellHeroImageConfigure(cellNameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 3 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionHeroesHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AddNewHeroTableViewCell
        
        switch indexPath.section {
        case 0:
            alertForCellName(label: cell.nameCellLabel, name: "Name team", placeholder: "Enter name team") { text in
                self.nameHero = text
            }
        case 1:
            alertForCellName(label: cell.nameCellLabel, name: "Speak special of your hero", placeholder: "ex: For the Horde!") { text in
                self.speakHero = text
            }
        case 2:
            alertForCellName(label: cell.nameCellLabel, name: "Main item for your hero", placeholder: "Choose your item") { text in
                self.mainItem = text
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

extension AddNewHeroVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
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
        let cell = tableView.cellForRow(at: [3, 0]) as! AddNewHeroTableViewCell
        
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true
        guard let data = cell.backgroundViewCell.image?.pngData() else { return }
        self.imageHero = data
        dismiss(animated: true)
    }
}
