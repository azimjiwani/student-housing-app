//
//  SearchScreen.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-19.
//

import UIKit

class SearchScreen: UIViewController {
    
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView (){
        backBtn()
        titleLabel()
    }
    
    @objc func backBtnPressed(){
        let searchScreen = SearchScreen()
        searchScreen.title="Search Rentals"
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
        titleLabel.text = "Search a city"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
    }

}
