//
//  DetailedListing.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-23.
//

import UIKit

class DetailedListing: UIViewController {

    var listingTitle: String!
    var listing_title : String!
    var price : Float!
    var bed : Float!
    var bath : Float!
    var address: String!
    var post_text : String!
    var post_url : URL!
//    var lease : Bool?
//    var sublet : Bool?
//    var utilities : String?
    var latitude : Float!
    var longitude : Float!
//    var images_lowquality : [URL]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(listingTitle)
        setupView()

        // Do any additional setup after loading the view.
    }
    

    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView(){
        let labelRect1 = CGRect(x: 30, y: self.view.center.y - 130, width: 250, height: 150)
        let label1 = UILabel(frame: labelRect1)
        label1.text = listingTitle
        label1.font = UIFont.boldSystemFont(ofSize: 50)
        label1.textColor = UIColor.white
        label1.numberOfLines = 2
        view.addSubview(label1)
        
        backBtn()
        titleLabel()
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
        titleLabel.text = "Detailed Listing"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor.black
    }
    
    

}
