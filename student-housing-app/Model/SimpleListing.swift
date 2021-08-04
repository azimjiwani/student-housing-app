//
//  SimpleListing.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-22.
//

import Foundation

public struct SimpleListing: Codable {
    let listing_title : String
    let price : Float
    let bed : Float
    let bath : Float
    let address: String
    let post_text : String
    let post_url : URL
    let lease : Bool?
    let sublet : Bool?
//    let utilities : String?
    let latitude : Float
    let longitude : Float
    let images_lowquality : [URL]?
}
