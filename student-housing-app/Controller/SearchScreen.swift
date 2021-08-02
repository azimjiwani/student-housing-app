//
//  SearchScreen.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-19.
//

import UIKit

class SearchScreen: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var tblSearchResults = UITableView()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //filteredArray = dataArray
        setupView()
    }
    
    func setupView (){
        backBtn()
        titleLabel()
        configureSearchBar()
        citiesTable()
        loadListOfCities()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func backBtn(){
        let backBtn = UIButton()
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backBtn)
        NSLayoutConstraint.activate([
            backBtn.widthAnchor.constraint(equalToConstant: 55),
            backBtn.heightAnchor.constraint(equalToConstant: 25),
            backBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            backBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        ])
        backBtn.setTitle("Back", for: .normal)
        backBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backBtn.titleLabel?.textAlignment = .center
        backBtn.backgroundColor = UIColor.white
        backBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        backBtn.layer.cornerRadius = 10
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
    }
    
    func titleLabel(){
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 125),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        ])
        titleLabel.text = "Search"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
    }
    
    func citiesTable(){
        tblSearchResults.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tblSearchResults.dataSource = self
        tblSearchResults.delegate = self
        view.addSubview(tblSearchResults)
        tblSearchResults.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tblSearchResults.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
            tblSearchResults.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tblSearchResults.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tblSearchResults.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func loadListOfCities() {
        if let filepath = Bundle.main.path(forResource: "cities", ofType: "txt") {
            let citiesString = try? String(contentsOfFile: filepath)
            dataArray = citiesString!.components(separatedBy:"\n")
            filteredArray = dataArray
            tblSearchResults.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredArray.count
        
//        if shouldShowSearchResults {
//            return filteredArray.count
//        }
//        else {
//            return dataArray.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        
        cell.textLabel?.text = filteredArray[indexPath.row]
        
//        if shouldShowSearchResults {
//            cell.textLabel?.text = filteredArray[indexPath.row]
//        }
//        else {
//            cell.textLabel?.text = dataArray[indexPath.row]
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let simplePost = SimplePosts()
        self.navigationController?.pushViewController(simplePost, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureSearchBar() {
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        searchBar.sizeToFit()
        tblSearchResults.tableHeaderView = searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar:UISearchBar, textDidChange searchText: String){
        let searchString = searchText
        filteredArray = []
        if searchString == "" || searchString.count == 0{
            filteredArray = dataArray
        }else{
            for city in dataArray {
                if city.lowercased().contains(searchString.lowercased()){
                    filteredArray.append(city)
                }
            }
            
//            filteredArray = dataArray.filter({ (city) -> Bool in
//                let cityText: NSString = city as NSString
//                let range = cityText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive)
//                return range.location != NSNotFound
//            })
        }
        tblSearchResults.reloadData()
    }
}

