////
////  SimplePostCell.swift
////  student-housing-app
////
////  Created by Azim Jiwani on 2021-07-23.
////
//
//import UIKit
//
//class SimplePostCell: UITableViewCell {
//    
//    var listing:Listing? {
//        didSet {
//            guard let listingItem = listing else {return}
//            let title = listingItem.listing_title
//            let price = listingItem.price
//            let bed = listingItem.bed
//            let bath = listingItem.bath
//            let address = listingItem.address
////            let listingLatitude = listing?.latitude
////            let listingLongitude = listing?.longitude
////            let listingText = listing?.post_text
////            let listingURL = listing?.post_url
//        }
//    }
//    
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
////        self.contentView.addSubview(profileImageView)
//        containerView.addSubview(nameLabel)
//        containerView.addSubview(jobTitleDetailedLabel)
//        self.contentView.addSubview(containerView)
//        
////        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
////        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
////        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
////        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
//        
//        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
//        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:10).isActive = true
//        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
//        
//        listingTitle.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
//        listingTitle.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//        listingTitle.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
//        
//        jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.listingTitle.bottomAnchor).isActive = true
//        jobTitleDetailedLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//        jobTitleDetailedLabel.topAnchor.constraint(equalTo:self.listingTitle.bottomAnchor).isActive = true
//        
//     }
//
//     required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//    }
//    
//    let profileImageView:UIImageView = {
//         let img = UIImageView()
//         img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
//         img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
//         img.layer.cornerRadius = 35
//         img.clipsToBounds = true
//        return img
//     }()
//    
//    let listingTitle:UILabel = {
//            let label = UILabel()
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//        label.textColor =  UIColor(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1.0)
//            label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = lis
//            return label
//    }()
//    
//    let jobTitleDetailedLabel:UILabel = {
//      let label = UILabel()
//      label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.textColor =  UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        label.backgroundColor =  UIColor(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1.0)
//      label.layer.cornerRadius = 5
//      label.clipsToBounds = true
//      label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = listingTitle
//       return label
//    }()
//    
//    let containerView:UIView = {
//      let view = UIView()
//      view.translatesAutoresizingMaskIntoConstraints = false
//      view.clipsToBounds = true // this will make sure its children do not go out of the boundary
//      return view
//    }()
//
//}
