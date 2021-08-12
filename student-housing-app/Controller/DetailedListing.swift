//
//  DetailedListing.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-23.
//

import UIKit

class DetailedListing: UIViewController, UIScrollViewDelegate {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let imageView = UIImageView()
    var postURL : URL!
    var imageURL : URL!
    var rentalType : String!
    var latitude : Float!
    var longitude : Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView(){
        backBtn()
        setupScrollView()
        loadListingImage()
        setupListing()
        listingUrl()
    }
    
    func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 90).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func backBtn(){
        let backBtn = UIButton()
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backBtn)
        NSLayoutConstraint.activate([
            backBtn.widthAnchor.constraint(equalToConstant: 55),
            backBtn.heightAnchor.constraint(equalToConstant: 25),
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
        backBtn.setTitle("Back", for: .normal)
        backBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        backBtn.titleLabel?.textAlignment = .left
        backBtn.backgroundColor = UIColor.white
        backBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadListingImage(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 300)
        ])
        
        imageView.loadImage(withUrl: imageURL)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
    }
    
    func setupListing(){
        listingTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingTitle)
        NSLayoutConstraint.activate([
            listingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listingTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            listingTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30)
        ])
        
        listingAddress.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingAddress)
        NSLayoutConstraint.activate([
            listingAddress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingAddress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listingAddress.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            listingAddress.topAnchor.constraint(equalTo: listingTitle.bottomAnchor, constant: 10)
        ])
        
        listingBed.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingBed)
        NSLayoutConstraint.activate([
            listingBed.heightAnchor.constraint(equalToConstant: 25),
            listingBed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingBed.topAnchor.constraint(equalTo: listingAddress.bottomAnchor, constant: 10),
        ])
        
        listingBath.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingBath)
        NSLayoutConstraint.activate([
            listingBath.heightAnchor.constraint(equalToConstant: 25),
            listingBath.leadingAnchor.constraint(equalTo: listingBed.trailingAnchor),
            listingBath.topAnchor.constraint(equalTo: listingAddress.bottomAnchor, constant: 10)
        ])
        
        walkIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(walkIcon)
        NSLayoutConstraint.activate([
            walkIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            walkIcon.topAnchor.constraint(equalTo: listingBed.bottomAnchor, constant: 10),
            walkIcon.heightAnchor.constraint(equalToConstant: 25),
            walkIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        walkTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(walkTime)
        NSLayoutConstraint.activate([
            walkTime.topAnchor.constraint(equalTo: listingBed.bottomAnchor, constant: 10),
            walkTime.leadingAnchor.constraint(equalTo: walkIcon.trailingAnchor,constant: 5),
//            walkTime.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        busIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(busIcon)
        NSLayoutConstraint.activate([
            busIcon.leadingAnchor.constraint(equalTo: walkTime.trailingAnchor, constant: 10),
            busIcon.topAnchor.constraint(equalTo: listingBed.bottomAnchor, constant: 10),
            busIcon.heightAnchor.constraint(equalToConstant: 25),
            busIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        busTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(busTime)
        NSLayoutConstraint.activate([
            busTime.topAnchor.constraint(equalTo: listingBed.bottomAnchor, constant: 10),
            busTime.leadingAnchor.constraint(equalTo: busIcon.trailingAnchor,constant: 5),
//            busTime.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        carIcon.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(carIcon)
        NSLayoutConstraint.activate([
            carIcon.leadingAnchor.constraint(equalTo: busTime.trailingAnchor, constant: 10),
            carIcon.topAnchor.constraint(equalTo: listingBed.bottomAnchor, constant: 10),
            carIcon.heightAnchor.constraint(equalToConstant: 25),
            carIcon.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        carTime.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(carTime)
        NSLayoutConstraint.activate([
            carTime.topAnchor.constraint(equalTo: listingBed.bottomAnchor, constant: 10),
            carTime.leadingAnchor.constraint(equalTo: carIcon.trailingAnchor,constant: 5),
//            carTime.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        listingType.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingType)
        NSLayoutConstraint.activate([
            listingType.heightAnchor.constraint(equalToConstant: 25),
            listingType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingType.topAnchor.constraint(equalTo: walkTime.bottomAnchor, constant: 10)
        ])
        
        listingPrice.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingPrice)
        NSLayoutConstraint.activate([
            listingPrice.heightAnchor.constraint(equalToConstant: 25),
            listingPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingPrice.topAnchor.constraint(equalTo: listingType.bottomAnchor, constant: 10)
        ])
        
        listingText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingText)
        NSLayoutConstraint.activate([
            listingText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listingText.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            listingText.topAnchor.constraint(equalTo: listingPrice.bottomAnchor, constant: 30)
        ])
    }
    
    let listingTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let listingPrice:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let listingAddress:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let listingBed:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let listingBath:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let walkIcon:UIImageView = {
        let image = UIImage(named:"WalkIconBlack")
        let icon = UIImageView(image: image)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let walkTime:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let busIcon:UIImageView = {
        let image = UIImage(named:"BusIconBlack")
        let icon = UIImageView(image: image)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let busTime:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let carIcon:UIImageView = {
        let image = UIImage(named:"CarIconBlack")
        let icon = UIImageView(image: image)
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let carTime:UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let listingType:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.sizeToFit()
        return label
    }()
    
    let listingText:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    func listingUrl(){
        let urlBtn = UIButton()
        urlBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(urlBtn)
        NSLayoutConstraint.activate([
            urlBtn.heightAnchor.constraint(equalToConstant: 25),
            urlBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            urlBtn.topAnchor.constraint(equalTo: listingText.bottomAnchor, constant: 10),
            urlBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
        urlBtn.setTitle("View on Facebook", for: .normal)
        urlBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        urlBtn.titleLabel?.textAlignment = .left
        urlBtn.backgroundColor = UIColor.white
        urlBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        urlBtn.addTarget(self, action: #selector(urlPressed), for: .touchUpInside)
    }
    
    @objc func urlPressed(){
        UIApplication.shared.open(postURL, options: [:], completionHandler: nil)
    }
}

extension UIImageView {
    func loadImage(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                    }
                }
            }
        }
    }
}

