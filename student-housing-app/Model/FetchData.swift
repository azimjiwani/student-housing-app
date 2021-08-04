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
        let urlForFetchingData = "http://localhost:5000/get-search-results/"
        
        if let urlToServer = URL.init(string: urlForFetchingData){
            let task = URLSession.shared.dataTask(with: urlToServer) {data, response, error in
                if error != nil || data == nil {
                    print("an error occurred fetching data from api")
                }else{
                    if let responseText = String.init(data: data!, encoding: .ascii){
                        let jsonData = responseText.data(using: .utf8)!
                        listings = try! JSONDecoder().decode([SimpleListing].self, from: jsonData)
                        print(listings)
                        completionHandler(listings)
                    }
                }
            }
            task.resume()
        }
    }
}

//responseText    String    "[\n    {\n        \"listing_title\": \"5 Beds 3 Baths Apartment\",\n        \"price\": 695.0,\n        \"bed\": 5.0,\n        \"bath\": 3.0,\n        \"address\": \"134 Columbia St, Waterloo, Canada\",\n        \"post_text\": \"4 month sublet- September to December 2021 available\\n\\nLocated at 134 Columbia St W\\nWaterloo, ON\\nN2L 3K8\\n\\n1 of 5 rooms, all female unit\\n- All utilities included\\n- Furnished, with a shared kitchen\\n- Includes Internet\\n- Located on the first floor with a bus top right next to the building\\n- 15 min walk to UW\\n- On-site laundry\\n\\nVirtual Tour :\\nhttps://my.matterport.com/show/?m=4ByYrw8PKNc\",\n        \"post_url\": \"https://m.facebook.com/groups/110354088989367/permalink/4524624354228963/\",\n        \"lease\": -1000,\n        \"sublease\": -1000,\n        \"sublet\": true,\n        \"utilities\": -1000,\n        \"latitude\": 42.5265204,\n        \"longitude\": -92.3427487,\n        \"post_id\": \"4524624354228963\"\n    },\n    {\n        \"listing_title\": \"4 Beds \\u00b7 1 Bath \\u00b7 Townhouse\",\n        \"price\": 500.0,\n        \""    
