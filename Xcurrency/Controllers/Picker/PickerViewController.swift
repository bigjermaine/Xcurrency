//
//  PickerViewController.swift
//  Xcurrency
//
//  Created by MacBook AIR on 17/07/2023.
//
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD



protocol PickerViewControllerdelegate :AnyObject {
    func didTapMenuButton(entry: Country, viewController: PickerViewController)
}






class PickerViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    let avengerIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
   
    var result = [Country]()
    
    weak  var delegate:PickerViewControllerdelegate?
    
    var countriesDict: [String: [Country]] = [:]
    
    var countrySectionTitles: [String] = []
    
    var filteredArr: [String] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background()
    }
    
    private func background() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
        
        networkCalls()
    }
    
    private func networkCalls() {
        NetworkManager.shared.getCountriesData { [weak self] result in
            
            switch result {
            case .success(let result):
                self?.result = result
                self?.createCountryDictionary()
                self?.filteredArr = self?.countrySectionTitles ?? []
              
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
              
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArr = searchText.isEmpty ? countrySectionTitles : countrySectionTitles.filter { $0.contains(searchText) }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredArr = countrySectionTitles
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredArr.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filteredArr[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countryKey = filteredArr[section]
        return countriesDict[countryKey]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countryKey = filteredArr[indexPath.section]
        guard let country = countriesDict[countryKey]?[indexPath.row] else {
            return UITableViewCell() // Return an empty cell if country is nil
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = country.name
        
        // Create an image view and set the image
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let imageName = country.displayName
         imageView.image = UIImage(named: imageName)
        
        
        // Set the image view as the accessory view of the cell
        cell.accessoryView = imageView
        
        return cell
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return avengerIndexTitles
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        HapticManager.shared.vibrateForSelection()
        
        let countryKey = filteredArr[indexPath.section]
        let text = countriesDict[countryKey]?[indexPath.row].name
        let image = countriesDict[countryKey]?[indexPath.row].displayName
        let rate = countriesDict[countryKey]?[indexPath.row].rate
        // Handle the selected country as needed
        guard let text = text, let image = image ,let rate = rate else {return}
        let entry = Country(name: text, displayName: image, rate:rate )
        print(entry)
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true) {
                self?.delegate?.didTapMenuButton(entry: entry, viewController: self!)
            }
        }
        
        
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        guard let index = countrySectionTitles.firstIndex(of: title) else { return -1 }
        
        return index
    }

    private func createCountryDictionary() {
        for country in result {
            let firstLetterIndex = country.name.index(country.name.startIndex, offsetBy: 1)
            let countryKey = String(country.name[..<firstLetterIndex])
            
            if var countryValues = countriesDict[countryKey] {
                countryValues.append(country)
                countriesDict[countryKey] = countryValues
            } else {
                countriesDict[countryKey] = [country]
            }
        }
        
        countrySectionTitles = Array(countriesDict.keys).sorted()
    }
}
