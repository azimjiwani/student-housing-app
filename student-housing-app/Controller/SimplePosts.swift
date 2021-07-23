//
//  SimplePosts.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-21.
//

import UIKit

class SimplePosts: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var listingsTable = UITableView()
    var fetchData = FetchData()
    var listings = [SimpleListing]()
    {
        didSet
        {
            DispatchQueue.main.async{
                self.listingsTable.reloadData()
            }
        }
    }
    var listingArray = [SimpleListing]()

    override func viewDidLoad() {
        
        fetchData.fetchData{listingArray in self.listings = [listingArray!]}
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView(){
        backBtn()
        titleLabel()
        setupListingsTable()
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
        titleLabel.text = "Listings"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
    }
    
    func setupListingsTable(){
        listingsTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        listingsTable.dataSource = self
        listingsTable.delegate = self
        view.addSubview(listingsTable)
        listingsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listingsTable.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90),
            listingsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            listingsTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listingsTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = self.listings[indexPath.row].listing_title
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }

}
