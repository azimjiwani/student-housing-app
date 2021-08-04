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
    var filteredListings = [SimpleListing]()

    override func viewDidLoad() {
        
        fetchData.fetchData{
            listingArray in self.listings = listingArray
            self.filteredListings = self.listings
            DispatchQueue.main.async{
            self.listingsTable.reloadData()
            }
        }
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView(){
        backBtn()
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 125),
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        ])
        view.addSubview(leaseBtn)
        NSLayoutConstraint.activate([
            leaseBtn.widthAnchor.constraint(equalToConstant: (self.view.bounds.width / 2) - 15),
            leaseBtn.heightAnchor.constraint(equalToConstant: 25),
            leaseBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            leaseBtn.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
        view.addSubview(subletBtn)
        NSLayoutConstraint.activate([
            subletBtn.widthAnchor.constraint(equalToConstant: (self.view.bounds.width / 2) - 15),
            subletBtn.heightAnchor.constraint(equalToConstant: 25),
            subletBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.view.bounds.width / 2),
            subletBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            subletBtn.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
        
        setupListingsTable()
    }
    

    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func leaseBtnPressed(){
        leaseBtn.backgroundColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0)
        leaseBtn.setTitleColor(.white, for: .normal)
        subletBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        subletBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        subletBtn.backgroundColor = .white
        
        filteredListings = []
        for listing in listings {
            if listing.lease == true{
                filteredListings.append(listing)
            }
        }
        listingsTable.reloadData()
    }
    
    @objc func subletBtnPressed(){
        subletBtn.backgroundColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0)
        subletBtn.setTitleColor(.white, for: .normal)
        leaseBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        leaseBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        leaseBtn.backgroundColor = .white
        
        filteredListings = []
        for listing in listings {
            if listing.sublet == true{
                filteredListings.append(listing)
            }
        }
        listingsTable.reloadData()
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
    
    let titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Listings"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    let leaseBtn:UIButton = {
        let leaseBtn = UIButton()
        leaseBtn.translatesAutoresizingMaskIntoConstraints = false
        leaseBtn.setTitle("Lease", for: .normal)
        leaseBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        leaseBtn.titleLabel?.textAlignment = .center
        leaseBtn.backgroundColor = UIColor.white
        leaseBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        leaseBtn.layer.cornerRadius = 10
        leaseBtn.layer.borderWidth = 1
        leaseBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        leaseBtn.addTarget(self, action: #selector(leaseBtnPressed), for: .touchUpInside)
        return leaseBtn
    }()
    
    let subletBtn:UIButton = {
        let subletBtn = UIButton()
        subletBtn.translatesAutoresizingMaskIntoConstraints = false
        subletBtn.setTitle("Sublet", for: .normal)
        subletBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        subletBtn.titleLabel?.textAlignment = .center
        subletBtn.backgroundColor = UIColor.white
        subletBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        subletBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        subletBtn.layer.cornerRadius = 10
        subletBtn.layer.borderWidth = 1
        subletBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        subletBtn.addTarget(self, action: #selector(subletBtnPressed), for: .touchUpInside)
        return subletBtn
    }()
    
    func setupListingsTable(){
        listingsTable.register(SimplePostCell.self, forCellReuseIdentifier: "cell")
        listingsTable.dataSource = self
        listingsTable.delegate = self
        view.addSubview(listingsTable)
        listingsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listingsTable.topAnchor.constraint(equalTo: self.leaseBtn.bottomAnchor, constant: 10),
            listingsTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20),
            listingsTable.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            listingsTable.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredListings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SimplePostCell
        cell.cellTitle.text = self.filteredListings[indexPath.row].listing_title
        cell.cellAddress.text = self.filteredListings[indexPath.row].address
        let price:Int = Int(self.filteredListings[indexPath.row].price)
        var priceString = "$"
        priceString += "\(price)"
        priceString += " / month"
        cell.cellPrice.text = priceString
        let bed:Int = Int(self.filteredListings[indexPath.row].bed)
        var bedString = "\(bed)"
        bedString += " bed"
        cell.cellBed.text = bedString
        let bath:Int = Int(self.filteredListings[indexPath.row].bath)
        var bathString = "\(bath)"
        bathString += " bath"
        cell.cellBath.text = bathString
        
        if self.filteredListings[indexPath.row].sublet == true {
            cell.cellRentalType.text = "Sublet"
        }
        
        if self.filteredListings[indexPath.row].lease == true {
            cell.cellRentalType.text = "Lease"
        }
        
        if self.filteredListings[indexPath.row].lease == true && self.filteredListings[indexPath.row].sublet == true{
            cell.cellRentalType.text = "Sublet & Lease"
        }
        
        
        let imageUrlString = "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
        let imageUrl:URL = URL(string: imageUrlString)!
        cell.imageURL = imageUrl
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedListing = DetailedListing()
        detailedListing.listingTitle.text = self.filteredListings[indexPath.row].listing_title
        detailedListing.listingAddress.text = self.filteredListings[indexPath.row].address
        let price:Int = Int(self.filteredListings[indexPath.row].price)
        var priceString = "$"
        priceString += "\(price)"
        priceString += " / month"
        detailedListing.listingPrice.text = priceString
        let bed:Int = Int(self.filteredListings[indexPath.row].bed)
        var bedString = "\(bed)"
        bedString += " bed · "
        detailedListing.listingBed.text = bedString
        let bath:Int = Int(self.filteredListings[indexPath.row].bath)
        var bathString = "\(bath)"
        bathString += " bath"
        detailedListing.listingBath.text = bathString
        detailedListing.listingText.text = self.filteredListings[indexPath.row].post_text
        detailedListing.postURL = self.filteredListings[indexPath.row].post_url
        let imageUrlString = "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
        let imageUrl:URL = URL(string: imageUrlString)!
        detailedListing.imageURL = imageUrl
//        detailedListing.imageURL = self.listings[indexPath.row].images_lowquality[0]
        self.navigationController?.pushViewController(detailedListing, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func filterByScopeButton(){
        
    }
    
}
