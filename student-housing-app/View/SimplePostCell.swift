//
//  SimplePostCell.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-23.
//

import UIKit

class SimplePostCell: UITableViewCell {
    
    var imageURL : URL!
    var listingImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadListingImage()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:20),
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-20),
            containerView.heightAnchor.constraint(equalToConstant:400)
        ])
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellTitle)
        NSLayoutConstraint.activate([
//            cellTitle.topAnchor.constraint(equalTo: listingImage2.bottomAnchor, constant:5),
            cellTitle.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 305),

            cellTitle.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            cellTitle.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ])
        
        cellAddress.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellAddress)
        NSLayoutConstraint.activate([
            cellAddress.topAnchor.constraint(equalTo:self.cellTitle.bottomAnchor, constant:5),
            cellAddress.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
        ])
        
        cellBed.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellBed)
        NSLayoutConstraint.activate([
            cellBed.topAnchor.constraint(equalTo:self.cellAddress.bottomAnchor, constant:5),
            cellBed.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            cellBed.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        cellBath.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellBath)
        NSLayoutConstraint.activate([
            cellBath.topAnchor.constraint(equalTo:self.cellAddress.bottomAnchor, constant:5),
            cellBath.leadingAnchor.constraint(equalTo:self.cellBed.trailingAnchor),
            cellBath.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        
        cellPrice.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellPrice)
        NSLayoutConstraint.activate([
            cellPrice.topAnchor.constraint(equalTo:self.cellBed.bottomAnchor, constant:5),
            cellPrice.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
        ])
        
        cellRentalType.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellRentalType)
        NSLayoutConstraint.activate([
            cellRentalType.topAnchor.constraint(equalTo:self.cellBed.bottomAnchor, constant:5),
            cellRentalType.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),
            cellRentalType.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
            
        super.init(coder: aDecoder)
    }
    
    let containerView:UIView = {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.clipsToBounds = true
       return view
    }()
    
    func loadListingImage(){
        listingImage.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(listingImage)
        NSLayoutConstraint.activate([
            listingImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            listingImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            listingImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            listingImage.bottomAnchor.constraint(equalTo: containerView.topAnchor, constant: 290)
        ])
    
        listingImage.cellImage(withUrl: imageURL)
        listingImage.layer.masksToBounds = true
        listingImage.layer.cornerRadius = 10
    }
    
    let cellTitle:UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 16)
       label.textColor = .black
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let cellPrice:UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 14)
       label.textColor = .black
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let cellAddress:UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 14)
       label.textColor = .gray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let cellBed:UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 14)
       label.textColor = .gray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let cellBath:UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 14)
       label.textColor = .gray
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    let cellRentalType:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 1.0, green: 0.3529, blue: 0.3725, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
}

extension UIImageView {
    func cellImage(withUrl url: URL) {
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
