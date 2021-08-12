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
    var price:Float = 0
    var numOfBeds:Float = 0
    var numOfBaths:Float = 0
    var lease:Bool = false
    var sublet:Bool = false
    var maxPrice:Float = 0
    
    var filters:Dictionary = [
        "all" : true,
        "lease" : false,
        "sublet" : false,
        "price" : 0,
        "numOfBeds" : 0,
        "numOfBaths" : 0
    ] as [String : Any]
    
    override func viewDidLoad() {
        
        fetchData.fetchData{
            listingArray in self.listings = listingArray
            self.filteredListings = self.listings
            DispatchQueue.main.async{
                self.listingsTable.reloadData()
            }
        }
        
        let minBeds:Float = 0
        let minBaths:Float = 0
        
        for listing in listings{
            if listing.price >= maxPrice{
                maxPrice = listing.price
            }
        }
        
        filters["price"] = self.maxPrice
        filters["numOfBeds"] = minBeds
        filters["numOfBaths"] = minBaths
        
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        allBtnPressed()
        updateFilters()
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
        
        view.addSubview(allBtn)
        NSLayoutConstraint.activate([
            allBtn.widthAnchor.constraint(equalToConstant: ((self.view.bounds.width - 30) / 3)),
            allBtn.heightAnchor.constraint(equalToConstant: 25),
            allBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            allBtn.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(leaseBtn)
        NSLayoutConstraint.activate([
            leaseBtn.widthAnchor.constraint(equalToConstant: ((self.view.bounds.width - 30) / 3)),
            leaseBtn.heightAnchor.constraint(equalToConstant: 25),
            leaseBtn.leadingAnchor.constraint(equalTo: allBtn.trailingAnchor),
            leaseBtn.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
        view.addSubview(subletBtn)
        NSLayoutConstraint.activate([
            subletBtn.widthAnchor.constraint(equalToConstant: ((self.view.bounds.width - 30) / 3)),
            subletBtn.heightAnchor.constraint(equalToConstant: 25),
            subletBtn.leadingAnchor.constraint(equalTo: leaseBtn.trailingAnchor),
            subletBtn.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(priceDownBtn)
        NSLayoutConstraint.activate([
            priceDownBtn.widthAnchor.constraint(equalToConstant: 25),
            priceDownBtn.heightAnchor.constraint(equalToConstant: 25),
            priceDownBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            priceDownBtn.topAnchor.constraint(equalTo: self.allBtn.bottomAnchor, constant: 10)
        ])
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.leadingAnchor.constraint(equalTo: self.priceDownBtn.trailingAnchor, constant: 4),
            priceLabel.widthAnchor.constraint(equalToConstant: 55),
            priceLabel.centerYAnchor.constraint(equalTo: self.priceDownBtn.centerYAnchor)
        ])
        
        view.addSubview(priceUpBtn)
        NSLayoutConstraint.activate([
            priceUpBtn.widthAnchor.constraint(equalToConstant: 25),
            priceUpBtn.heightAnchor.constraint(equalToConstant: 25),
            priceUpBtn.trailingAnchor.constraint(equalTo: self.allBtn.trailingAnchor, constant: -5),
            priceUpBtn.topAnchor.constraint(equalTo: self.allBtn.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(bedDownBtn)
        NSLayoutConstraint.activate([
            bedDownBtn.widthAnchor.constraint(equalToConstant: 25),
            bedDownBtn.heightAnchor.constraint(equalToConstant: 25),
            bedDownBtn.leadingAnchor.constraint(equalTo: self.leaseBtn.leadingAnchor, constant: 5),
            bedDownBtn.topAnchor.constraint(equalTo: self.leaseBtn.bottomAnchor, constant: 10)
        ])
        
        bedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bedLabel)
        NSLayoutConstraint.activate([
            bedLabel.leadingAnchor.constraint(equalTo: self.bedDownBtn.trailingAnchor, constant: 2),
            bedLabel.widthAnchor.constraint(equalToConstant: 60),
            bedLabel.centerYAnchor.constraint(equalTo: self.priceDownBtn.centerYAnchor)
        ])
        
        view.addSubview(bedUpBtn)
        NSLayoutConstraint.activate([
            bedUpBtn.widthAnchor.constraint(equalToConstant: 25),
            bedUpBtn.heightAnchor.constraint(equalToConstant: 25),
            bedUpBtn.trailingAnchor.constraint(equalTo: self.leaseBtn.trailingAnchor, constant: -5),
            bedUpBtn.topAnchor.constraint(equalTo: self.leaseBtn.bottomAnchor, constant: 10)
        ])
        
        view.addSubview(bathDownBtn)
        NSLayoutConstraint.activate([
            bathDownBtn.widthAnchor.constraint(equalToConstant: 25),
            bathDownBtn.heightAnchor.constraint(equalToConstant: 25),
            bathDownBtn.leadingAnchor.constraint(equalTo: self.subletBtn.leadingAnchor, constant: 5),
            bathDownBtn.topAnchor.constraint(equalTo: self.subletBtn.bottomAnchor, constant: 10)
        ])
        
        bathLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bathLabel)
        NSLayoutConstraint.activate([
            bathLabel.leadingAnchor.constraint(equalTo: self.bathDownBtn.trailingAnchor, constant: 2),
            bathLabel.widthAnchor.constraint(equalToConstant: 60),
            bathLabel.centerYAnchor.constraint(equalTo: self.priceDownBtn.centerYAnchor)
        ])
        
        view.addSubview(bathUpBtn)
        NSLayoutConstraint.activate([
            bathUpBtn.widthAnchor.constraint(equalToConstant: 25),
            bathUpBtn.heightAnchor.constraint(equalToConstant: 25),
            bathUpBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            bathUpBtn.topAnchor.constraint(equalTo: self.subletBtn.bottomAnchor, constant: 10)
        ])
        
        setupListingsTable()
    }
    
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func allBtnPressed(){
        allBtn.backgroundColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0)
        allBtn.setTitleColor(.white, for: .normal)
        
        leaseBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        leaseBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        leaseBtn.backgroundColor = .white
        
        subletBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        subletBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        subletBtn.backgroundColor = .white
        
        filters["sublet"] = false
        filters["all"] = true
        filters["lease"] = false
        updateFilters()
        
    }
    
    @objc func leaseBtnPressed(){
        
        allBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        allBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        allBtn.backgroundColor = .white
        
        leaseBtn.backgroundColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0)
        leaseBtn.setTitleColor(.white, for: .normal)
        
        subletBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        subletBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        subletBtn.backgroundColor = .white
        
        filters["sublet"] = false
        filters["all"] = false
        filters["lease"] = true
        updateFilters()
    }
    
    @objc func subletBtnPressed(){
        
        allBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        allBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        allBtn.backgroundColor = .white
        
        subletBtn.backgroundColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0)
        subletBtn.setTitleColor(.white, for: .normal)
        
        leaseBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        leaseBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        leaseBtn.backgroundColor = .white
        
        filters["sublet"] = true
        filters["all"] = false
        filters["lease"] = false
        updateFilters()
    }
    
    @objc func priceDownBtnPressed(){
        
        if (price - 50 > 0){
            price -= 50
            priceLabel.text = "$" + "\(Int(price))"
            
            filters["price"] = price
            priceLabel.textColor = .black
            updateFilters()
        }else{
            priceLabel.text = "Price"
            priceLabel.textColor = .gray
            price = self.maxPrice
            filters["price"] = price
            updateFilters()
        }
    }
    
    @objc func priceUpBtnPressed(){
        
        price += 50
        priceLabel.text = "$" + "\(Int(price))"
        
        filters["price"] = price
        priceLabel.textColor = .black
        updateFilters()
    }
    
    @objc func bedDownBtnPressed(){
        if (numOfBeds - 1 > 0){
            numOfBeds -= 1
            bedLabel.text = "\(Int(numOfBeds))" + " bed"
            
            filters["numOfBeds"] = numOfBeds
            bedLabel.textColor = .black
            updateFilters()
            
        }else{
            bedLabel.text = "Beds"
            bedLabel.textColor = .gray
            numOfBeds = 0
            filters["numOfBeds"] = numOfBeds
            updateFilters()
        }
    }
    
    @objc func bedUpBtnPressed(){
        
        numOfBeds += 1
        bedLabel.text = "\(Int(numOfBeds))" + " bed"
        bedLabel.textColor = .black
        
        filters["numOfBeds"] = numOfBeds
        updateFilters()
    }
    
    @objc func bathDownBtnPressed(){
        
        if (numOfBaths - 1 > 0){
            numOfBaths -= 1
            bathLabel.text = "\(Int(numOfBaths))" + " bath"
            bathLabel.textColor = .black
            
            filters["numOfBaths"] = numOfBaths
            updateFilters()
            
        }else{
            bathLabel.text = "Baths"
            bathLabel.textColor = .gray
            numOfBaths = 0
            filters["numOfBaths"] = numOfBaths
            updateFilters()
        }
    }
    
    @objc func bathUpBtnPressed(){
        
        numOfBaths += 1
        bathLabel.text = "\(Int(numOfBaths))" + " bath"
        bathLabel.textColor = .black
        
        filters["numOfBaths"] = numOfBaths
        updateFilters()
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
    
    let allBtn:UIButton = {
        let allBtn = UIButton()
        allBtn.translatesAutoresizingMaskIntoConstraints = false
        allBtn.setTitle("All", for: .normal)
        allBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        allBtn.titleLabel?.textAlignment = .center
        allBtn.backgroundColor = UIColor.white
        allBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        allBtn.layer.cornerRadius = 10
        allBtn.layer.borderWidth = 1
        allBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        allBtn.addTarget(self, action: #selector(allBtnPressed), for: .touchUpInside)
        return allBtn
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
    
    let priceDownBtn:UIButton = {
        let priceDownBtn = UIButton()
        priceDownBtn.translatesAutoresizingMaskIntoConstraints = false
        priceDownBtn.setTitle("-", for: .normal)
        priceDownBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceDownBtn.titleLabel?.textAlignment = .center
        priceDownBtn.titleLabel?.baselineAdjustment = .alignCenters
        priceDownBtn.backgroundColor = UIColor.white
        priceDownBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        priceDownBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        priceDownBtn.layer.cornerRadius = 12.5
        priceDownBtn.layer.borderWidth = 1
        priceDownBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        priceDownBtn.addTarget(self, action: #selector(priceDownBtnPressed), for: .touchUpInside)
        return priceDownBtn
    }()
    
    let priceUpBtn:UIButton = {
        let priceUpBtn = UIButton()
        priceUpBtn.translatesAutoresizingMaskIntoConstraints = false
        priceUpBtn.setTitle("+", for: .normal)
        priceUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceUpBtn.titleLabel?.textAlignment = .center
        priceUpBtn.titleLabel?.baselineAdjustment = .alignCenters
        priceUpBtn.backgroundColor = UIColor.white
        priceUpBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        priceUpBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        priceUpBtn.layer.cornerRadius = 12.5
        priceUpBtn.layer.borderWidth = 1
        priceUpBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        priceUpBtn.addTarget(self, action: #selector(priceUpBtnPressed), for: .touchUpInside)
        return priceUpBtn
    }()
    
    let bedDownBtn:UIButton = {
        let bedDownBtn = UIButton()
        bedDownBtn.translatesAutoresizingMaskIntoConstraints = false
        bedDownBtn.setTitle("-", for: .normal)
        bedDownBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bedDownBtn.titleLabel?.textAlignment = .center
        bedDownBtn.titleLabel?.baselineAdjustment = .alignCenters
        bedDownBtn.backgroundColor = UIColor.white
        bedDownBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        bedDownBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        bedDownBtn.layer.cornerRadius = 12.5
        bedDownBtn.layer.borderWidth = 1
        bedDownBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        bedDownBtn.addTarget(self, action: #selector(bedDownBtnPressed), for: .touchUpInside)
        return bedDownBtn
    }()
    
    let bedUpBtn:UIButton = {
        let bedUpBtn = UIButton()
        bedUpBtn.translatesAutoresizingMaskIntoConstraints = false
        bedUpBtn.setTitle("+", for: .normal)
        bedUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bedUpBtn.titleLabel?.textAlignment = .center
        bedUpBtn.titleLabel?.baselineAdjustment = .alignCenters
        bedUpBtn.backgroundColor = UIColor.white
        bedUpBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        bedUpBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        bedUpBtn.layer.cornerRadius = 12.5
        bedUpBtn.layer.borderWidth = 1
        bedUpBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        bedUpBtn.addTarget(self, action: #selector(bedUpBtnPressed), for: .touchUpInside)
        return bedUpBtn
    }()
    
    let bathDownBtn:UIButton = {
        let bathDownBtn = UIButton()
        bathDownBtn.translatesAutoresizingMaskIntoConstraints = false
        bathDownBtn.setTitle("-", for: .normal)
        bathDownBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bathDownBtn.titleLabel?.textAlignment = .center
        bathDownBtn.titleLabel?.baselineAdjustment = .alignCenters
        bathDownBtn.backgroundColor = UIColor.white
        bathDownBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        bathDownBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        bathDownBtn.layer.cornerRadius = 12.5
        bathDownBtn.layer.borderWidth = 1
        bathDownBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        bathDownBtn.addTarget(self, action: #selector(bathDownBtnPressed), for: .touchUpInside)
        return bathDownBtn
    }()
    
    let bathUpBtn:UIButton = {
        let bathUpBtn = UIButton()
        bathUpBtn.translatesAutoresizingMaskIntoConstraints = false
        bathUpBtn.setTitle("+", for: .normal)
        bathUpBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bathUpBtn.titleLabel?.textAlignment = .center
        bathUpBtn.titleLabel?.baselineAdjustment = .alignCenters
        bathUpBtn.backgroundColor = UIColor.white
        bathUpBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        bathUpBtn.setTitleColor(UIColor.white, for: UIControl.State.selected)
        bathUpBtn.layer.cornerRadius = 12.5
        bathUpBtn.layer.borderWidth = 1
        bathUpBtn.layer.borderColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0).cgColor
        bathUpBtn.addTarget(self, action: #selector(bathUpBtnPressed), for: .touchUpInside)
        return bathUpBtn
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Price"
        label.textAlignment = .center
        return label
    }()
    
    let bedLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Beds"
        label.textAlignment = .center
        return label
    }()
    
    let bathLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.text = "Baths"
        label.textAlignment = .center
        return label
    }()
    
    func setupListingsTable(){
        listingsTable.register(SimplePostCell.self, forCellReuseIdentifier: "cell")
        listingsTable.dataSource = self
        listingsTable.delegate = self
        view.addSubview(listingsTable)
        listingsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listingsTable.topAnchor.constraint(equalTo: self.priceDownBtn.bottomAnchor, constant: 10),
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
        bedString += " bed · "
        cell.cellBed.text = bedString
        let bath:Int = Int(self.filteredListings[indexPath.row].bath)
        var bathString = "\(bath)"
        bathString += " bath"
        cell.cellBath.text = bathString
        
        let walkTime:Int = Int(self.filteredListings[indexPath.row].walk_time)
        var walkString = "\(walkTime)"
        walkString += " mins"
        cell.cellWalkTime.text = walkString
        
        let busTime:Int = Int(self.filteredListings[indexPath.row].bus_time)
        var busString = "\(busTime)"
        busString += " mins"
        cell.cellBusTime.text = busString
        
        let carTime:Int = Int(self.filteredListings[indexPath.row].car_time)
        var carString = "\(carTime)"
        carString += " mins"
        cell.cellCarTime.text = carString
        
        if self.filteredListings[indexPath.row].sublet == true {
            cell.cellRentalType.text = "Sublet"
        }
        
        if self.filteredListings[indexPath.row].lease == true {
            cell.cellRentalType.text = "Lease"
        }
        
        if self.filteredListings[indexPath.row].lease == true && self.filteredListings[indexPath.row].sublet == true{
            cell.cellRentalType.text = "Lease & Sublet"
        }
        if self.filteredListings[indexPath.row].lease == false && self.filteredListings[indexPath.row].sublet == false{
            cell.cellRentalType.text = "Unknown"
        }
        
        if (self.filteredListings[indexPath.row].images_lowquality!.count) > 0{
            cell.imageURL = self.filteredListings[indexPath.row].images_lowquality?[0]
        }
        else{
            let imageUrlString = "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
            let imageUrl:URL = URL(string: imageUrlString)!
            cell.imageURL = imageUrl
        }
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
        
        let walkTime:Int = Int(self.filteredListings[indexPath.row].walk_time)
        var walkString = "\(walkTime)"
        walkString += " mins"
        detailedListing.walkTime.text = walkString
        
        let busTime:Int = Int(self.filteredListings[indexPath.row].bus_time)
        var busString = "\(busTime)"
        busString += " mins"
        detailedListing.busTime.text = busString
        
        let carTime:Int = Int(self.filteredListings[indexPath.row].car_time)
        var carString = "\(carTime)"
        carString += " mins"
        detailedListing.carTime.text = carString
        
        if self.filteredListings[indexPath.row].sublet == true {
            detailedListing.listingType.text = "Sublet"
        }
        
        if self.filteredListings[indexPath.row].lease == true {
            detailedListing.listingType.text = "Lease"
        }
        
        if self.filteredListings[indexPath.row].lease == true && self.filteredListings[indexPath.row].sublet == true{
            detailedListing.listingType.text = "Lease & Sublet"
        }
        
        if self.filteredListings[indexPath.row].lease == false && self.filteredListings[indexPath.row].sublet == false{
            detailedListing.listingType.text = "Unknown"
        }
        detailedListing.listingText.text = self.filteredListings[indexPath.row].post_text
        detailedListing.postURL = self.filteredListings[indexPath.row].post_url
        
        if (filteredListings[indexPath.row].images_lowquality!.count) > 0{
            detailedListing.imageURL = self.filteredListings[indexPath.row].images_lowquality?[0]
        }else{
            let imageUrlString = "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
            let imageUrl:URL = URL(string: imageUrlString)!
            detailedListing.imageURL = imageUrl
        }
        
        self.navigationController?.pushViewController(detailedListing, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func updateFilters(){
        filteredListings = listings
        if filters["all"] as! Bool == true{
            filteredListings = listings
//            let allListings = filteredListings
//            filteredListings = []
//            for listing in allListings {
//                if listing.lease == true || listing.sublet == true{
//                    filteredListings.append(listing)
//                }
//            }
        }
        
        if filters["lease"] as! Bool == true{
            let leaseListings = filteredListings
            filteredListings = []
            for listing in leaseListings {
                if listing.lease == true{
                    filteredListings.append(listing)
                }
            }
        }
        
        if filters["sublet"] as! Bool == true{
            let subletListings = filteredListings
            filteredListings = []
            for listing in subletListings {
                if listing.sublet == true{
                    filteredListings.append(listing)
                }
            }
        }
        if filters["price"] as! Float != 0{
            let priceListings = filteredListings
            filteredListings = []
            for listing in priceListings {
                if listing.price <= filters["price"] as! Float{
                    filteredListings.append(listing)
                }
            }
        }
        
        if filters["numOfBeds"] as! Float != 0{
            let bedListings = filteredListings
            filteredListings = []
            for listing in bedListings {
                if listing.bed >= filters["numOfBeds"] as! Float{
                    filteredListings.append(listing)
                }
            }
        }
        
        if filters["numOfBaths"] as! Float != 0{
            let bathListings = filteredListings
            filteredListings = []
            for listing in bathListings {
                if listing.bath >= filters["numOfBaths"] as! Float{
                    filteredListings.append(listing)
                }
            }
        }
        listingsTable.reloadData()
    }
}
