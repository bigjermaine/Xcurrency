//
//  HistoryViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 16/07/2023.
//


import UIKit
import SVProgressHUD
import Realm
import RealmSwift

class HistoryViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource {
   
    var data = [String]()
    let realm = try! Realm()
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "No history try converting"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        display()
        
        
        
    
    }
    
    private func display() {
        DispatchQueue.main.async {[weak self] in
            self?.render()
            self?.tableView.reloadData()
        }
    }
    
    private func render() {
        let people = realm.objects(person.self)
        
        for person in people {
            let rate =  person.Rate
            let date = person.date
            let baseCurrency = person.baseCurrency
            let convertCureency = person.ConvertCurency
            
            let allStrings = "\(baseCurrency): \(rate) \(convertCureency) \(date)"
            
            data.append(allStrings)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
