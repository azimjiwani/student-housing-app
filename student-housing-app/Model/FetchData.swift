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
        let urlForFetchingData = "https://student-housing-app-deploy.herokuapp.com/get-search-results/"
        
        if let urlToServer = URL.init(string: urlForFetchingData){
            let task = URLSession.shared.dataTask(with: urlToServer) {data, response, error in
                if error != nil || data == nil {
                    print("an error occurred fetching data from api")
                }else{
                    if let responseText = String.init(data: data!, encoding: .ascii){
                        let jsonData = responseText.data(using: .utf8)!
                        listings = try! JSONDecoder().decode([SimpleListing].self, from: jsonData)
                        //                        print(listings)
                        completionHandler(listings)
                    }
                }
            }
            task.resume()
        }
    }
}

//responseText    String    "[\n    {\n        \"listing_title\": \"1 Bed 1 Bath Apartment\",\n        \"price\": 1.0,\n        \"bed\": 1.0,\n        \"bath\": 1.0,\n        \"address\": \"64 Marshall St, Waterloo, Canada\",\n        \"post_text\": \"LEASE TAKEOVER SEPT 2021-SEPT 2022 - 64 Marshall St - Msg me for inquires.\\n1/5 rooms large bedroom with ensuite bathroom. The apartment has a large kitchen, dishwasher, in-unit laundry and balcony.\\nSTUDENTS ONLY\",\n        \"post_url\": \"https://m.facebook.com/groups/110354088989367/permalink/4532122580145807/\",\n        \"lease\": true,\n        \"sublease\": -1000,\n        \"sublet\": false,\n        \"utilities\": -1000,\n        \"latitude\": 43.4739485,\n        \"longitude\": -80.5204791,\n        \"post_id\": \"4532122580145807\",\n        \"images_lowquality\": [\n            \"https://scontent.fybz2-2.fna.fbcdn.net/v/t1.6435-9/cp0/e15/q65/p180x540/226532779_545820103408689_6771062330804205714_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=07e735&_nc_ohc=lfXUBPsNaTMAX-YCvHu&_nc_ht=scontent.fybz2-2.fna&oh=ccf9051b85e49f9bd0660fafdb5301c0&oe=61300"

// responseText    String    "[\n    {\n        \"listing_title\": \"1 Bed 1 Bath Apartment\",\n        \"price\": 1.0,\n        \"bed\": 1.0,\n        \"bath\": 1.0,\n        \"address\": \"64 Marshall St, Waterloo, Canada\",\n        \"post_text\": \"LEASE TAKEOVER SEPT 2021-SEPT 2022 - 64 Marshall St - Msg me for inquires.\\n1/5 rooms large bedroom with ensuite bathroom. The apartment has a large kitchen, dishwasher, in-unit laundry and balcony.\\nSTUDENTS ONLY\",\n        \"post_url\": \"https://m.facebook.com/groups/110354088989367/permalink/4532122580145807/\",\n        \"lease\": true,\n        \"sublease\": -1000,\n        \"sublet\": false,\n        \"utilities\": -1000,\n        \"latitude\": 43.4739485,\n        \"longitude\": -80.5204791,\n        \"post_id\": \"4532122580145807\",\n        \"images_lowquality\": [\n            \"https://scontent.fybz2-2.fna.fbcdn.net/v/t1.6435-9/cp0/e15/q65/p180x540/226532779_545820103408689_6771062330804205714_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=07e735&_nc_ohc=lfXUBPsNaTMAX-YCvHu&_nc_ht=scontent.fybz2-2.fna&oh=ccf9051b85e49f9bd0660fafdb5301c0&oe=61300"
