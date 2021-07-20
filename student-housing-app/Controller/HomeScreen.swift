//
//  HomeScreen.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-18.
//

import UIKit

class HomeScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"HomeScreenBg")!)
        setupView()

        // Do any additional setup after loading the view.
    }
    
    func setupView(){
        
        let searchRentalsBtn = UIButton()
        searchRentalsBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchRentalsBtn)
        NSLayoutConstraint.activate([
            searchRentalsBtn.widthAnchor.constraint(equalToConstant: 300),
            searchRentalsBtn.heightAnchor.constraint(equalToConstant: 60),
            searchRentalsBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            searchRentalsBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60)
        ])
        searchRentalsBtn.setTitle("Search Rentals", for: .normal)
        searchRentalsBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        searchRentalsBtn.titleLabel?.textAlignment = .center
        searchRentalsBtn.backgroundColor = UIColor.white
        searchRentalsBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        searchRentalsBtn.layer.cornerRadius = 30
        searchRentalsBtn.addTarget(self, action: #selector(searchRentalsBtnPressed), for: .touchUpInside)
        
        let labelRect1 = CGRect(x: 30, y: self.view.center.y - 130, width: 250, height: 150)
        let label1 = UILabel(frame: labelRect1)
        label1.text = "Find Your Next Home"
        label1.font = UIFont.boldSystemFont(ofSize: 50)
        label1.textColor = UIColor.white
        label1.numberOfLines = 2
        view.addSubview(label1)
        
        //let exploreRentalsBtnRect = CGRect(x: 30, y: labelRect1.maxY + 30, width: 200, height: 40)
        let exploreRentalsBtn = UIButton()
        exploreRentalsBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exploreRentalsBtn)
        NSLayoutConstraint.activate([
            exploreRentalsBtn.widthAnchor.constraint(equalToConstant: 200),
            exploreRentalsBtn.heightAnchor.constraint(equalToConstant: 40),
            exploreRentalsBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30),
            exploreRentalsBtn.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 60)
        ])
        
        
        exploreRentalsBtn.setTitle("Explore Rentals", for: .normal)
        exploreRentalsBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        exploreRentalsBtn.titleLabel?.textAlignment = .center
        exploreRentalsBtn.backgroundColor = UIColor.white
        exploreRentalsBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        exploreRentalsBtn.layer.cornerRadius = 10
    }

    @objc func searchRentalsBtnPressed(){
        let searchScreen = SearchScreen()
        searchScreen.title="Search Rentals"
        self.navigationController?.pushViewController(searchScreen, animated: true)
    }

}
