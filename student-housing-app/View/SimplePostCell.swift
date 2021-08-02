//
//  SimplePostCell.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-23.
//

import UIKit

class SimplePostCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        cellImage.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
//        cellImage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
//        cellImage.widthAnchor.constraint(equalToConstant:70).isActive = true
//        cellImage.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor),
//            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
//            containerView.leadingAnchor.constraint(equalTo:self.cellImage.trailingAnchor, constant:10),
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:20),
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10),
            containerView.heightAnchor.constraint(equalToConstant:100)
        ])
        
        
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(cellTitle)
        NSLayoutConstraint.activate([
            cellTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant:5),
            cellTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            cellTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor)
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
    }
    
    required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
    }
    
    let containerView:UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.clipsToBounds = true // this will make sure its children do not go out of the boundary
           return view
    }()
    
//    let cellImage:UIImageView = {
//            let img = UIImageView()
//            img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
//            img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
//            img.layer.cornerRadius = 35
//            img.clipsToBounds = true
//            return img
//    }()
    
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
}
