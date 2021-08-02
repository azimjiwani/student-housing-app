//
//  DetailedListing.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-23.
//

import UIKit

class DetailedListing: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    var postURL : URL!
    var imageURL : URL!
//    var lease : Bool?
//    var sublet : Bool?
//    var utilities : String?
    var latitude : Float!
    var longitude : Float!
//    var images_lowquality : [URL]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView(){
        backBtn()
        setupScrollView()
        setupListing()
        listingUrl()
//        loadListingImage()
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
        
        contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
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
        backBtn.titleLabel?.textAlignment = .left
        backBtn.backgroundColor = UIColor.white
        backBtn.setTitleColor(UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnPressed), for: .touchUpInside)
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupListing(){
        listingTitle.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingTitle)
        NSLayoutConstraint.activate([
            listingTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listingTitle.topAnchor.constraint(equalTo: contentView.topAnchor),
            listingTitle.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30)
        ])
        
        listingAddress.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingAddress)
        NSLayoutConstraint.activate([
            listingAddress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingAddress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listingAddress.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            listingAddress.topAnchor.constraint(equalTo: self.listingTitle.bottomAnchor, constant: 10)
        ])
        
        listingBed.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingBed)
        NSLayoutConstraint.activate([
            listingBed.heightAnchor.constraint(equalToConstant: 25),
            listingBed.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingBed.topAnchor.constraint(equalTo: self.listingAddress.bottomAnchor, constant: 10),
        ])
        
        listingBath.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingBath)
        NSLayoutConstraint.activate([
            listingBath.heightAnchor.constraint(equalToConstant: 25),
            listingBath.leadingAnchor.constraint(equalTo: self.listingBed.trailingAnchor),
            listingBath.topAnchor.constraint(equalTo: self.listingAddress.bottomAnchor, constant: 10)
        ])
        
        listingPrice.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingPrice)
        NSLayoutConstraint.activate([
            listingPrice.heightAnchor.constraint(equalToConstant: 25),
            listingPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingPrice.topAnchor.constraint(equalTo: self.listingBath.bottomAnchor, constant: 10)
        ])
        
        listingText.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(listingText)
        NSLayoutConstraint.activate([
            listingText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            listingText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            listingText.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -30),
            listingText.topAnchor.constraint(equalTo: self.listingPrice.bottomAnchor, constant: 30)
        ])
    }
    
//    func loadListingImage(){
//        let imageUrlString = "http://swiftdeveloperblog.com/wp-content/uploads/2015/07/1.jpeg"
//        let imageUrl:URL = URL(string: imageUrlString)!
//
//        // Start background thread so that image loading does not make app unresponsive
//         DispatchQueue.global(qos: .userInitiated).async {
//            let imageData:NSData = NSData(contentsOf: imageUrl)!
//            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
//            imageView.center = self.view.center
//
//            // When from background thread, UI needs to be updated on main_queue
//           DispatchQueue.main.async {
//                let image = UIImage(data: imageData as Data)
//                imageView.image = image
//               imageView.contentMode = UIView.ContentMode.scaleAspectFit
//                self.view.addSubview(imageView)
//            }
//         }
//    }
    
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        return label
    }()
    
    let listingBed:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
        label.sizeToFit()
        return label
    }()
    
    let listingBath:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
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
        view.addSubview(urlBtn)
        NSLayoutConstraint.activate([
            urlBtn.heightAnchor.constraint(equalToConstant: 25),
            urlBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15),
            urlBtn.topAnchor.constraint(equalTo: self.listingText.bottomAnchor, constant: 10)
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

//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}