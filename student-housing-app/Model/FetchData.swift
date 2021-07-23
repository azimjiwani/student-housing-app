//
//  FetchData.swift
//  student-housing-app
//
//  Created by Azim Jiwani on 2021-07-22.
//

import Foundation

class FetchData {
    func fetchData(completionHandler:@escaping ([SimpleListing]) -> Void) {
        var listings = [SimpleListing]()
        let urlForFetchingData = "http://localhost:5000/get-all-processed-posts"
        
        if let urlToServer = URL.init(string: urlForFetchingData){
            let task = URLSession.shared.dataTask(with: urlToServer) {data, response, error in
                if error != nil || data == nil {
                    print("an error occurred fetching data from api")
//                    completionHandler(nil)
                }else{
                    if let responseText = String.init(data: data!, encoding: .ascii){
                        let jsonData = responseText.data(using: .utf8)!
                        listings = try! JSONDecoder().decode([SimpleListing].self, from: jsonData)
                        print(listings)
                        completionHandler(listings)
                    }
//                    let listings = try! JSONDecoder().decode([SimpleListing].self , from: data!)
                }
            }
            task.resume()
        }
        
//        completionHandler(listings)
    }
}
