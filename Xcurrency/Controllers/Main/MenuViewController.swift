//
//  MenuViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didselect(menuItem:MenuViewController.menuOptions)
}

class MenuViewController: UIViewController {
    
    
    //Enum for switching the tableview
    enum menuOptions:String,CaseIterable {
        case home = "home"
        case history = "history"
        case settings = "Settings"
      
        var ImageName:String {
            switch self {
                
            case .home:
                return "house.fill"
            case .history:
               return "coloncurrencysign"
            case .settings:
                 return "gear"
            }
            
        }
    }
    
    private let tableView:UITableView = {
       let table = UITableView()
       table.register(UITableViewCell.self, forCellReuseIdentifier:"Cell")
        table.translatesAutoresizingMaskIntoConstraints = false
      return table
    }()
    
    
    
    private let logoImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "Xcurrency")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
      return imageView
    }()
    
   
    private let rectangleView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
    
    
    
    weak var delegate:MenuViewControllerDelegate?

  

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  skyDarkBlueColor
        view.addSubview( rectangleView)
        view.addSubview(tableView)
        view.addSubview(logoImageView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor =  skyDarkBlueColor
        Subviews()
       
    }
    
    
    func Subviews() {
        // Add constraints to the rectangleView
        // Add constraints to the tableView
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: rectangleView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            rectangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rectangleView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            rectangleView.widthAnchor.constraint(equalTo:tableView.widthAnchor),
            rectangleView.heightAnchor.constraint(equalToConstant: 200)
        ])

        // Add constraints to the logoImageView
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: rectangleView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: rectangleView.centerYAnchor, constant: 0),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150)
        ])

        
      
        
      
    }
}

  


extension MenuViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let imageSize = CGSize(width: 20, height: 20)
        if let originalImage = UIImage(systemName:  menuOptions.allCases[indexPath.row].ImageName) {
            let resizedImage = originalImage.resize(to: imageSize)
            cell.imageView?.image = resizedImage.withRenderingMode(.alwaysTemplate)
            cell.imageView?.tintColor = skyDarkBlueColor
        }

        cell.textLabel?.text = menuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .gray
        
        cell.selectionStyle = .none
        cell.separatorInset = .zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     let item  =  menuOptions.allCases[indexPath.row]
        delegate?.didselect(menuItem: item)
        

        
    }
}

  


