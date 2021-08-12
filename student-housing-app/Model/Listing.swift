//
//  Listing.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-23.
//

import Foundation

public struct Listing {
    let listing_title : String
    let price : Float
    let bed : Float
    let bath : Float
    let address: String
    let post_text : String
    let post_url : URL
    let lease : Bool
    let sublet : Bool
    let latitude : Float?
    let longitude : Float?
    let images_lowquality : [URL]?
    let walk_time : Float
    let bus_time : Float
    let car_time : Float
}
