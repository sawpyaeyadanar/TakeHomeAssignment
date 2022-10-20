//
//  Constants.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/13/22.
//

import Foundation
struct Constants {

    struct API {
        static let baseURL = "https://ninetyninedotco-b7299.asia-southeast1.firebasedatabase.app/"
    }
    static func getList() -> String{
        return API.baseURL +  "listings.json"
    }

    static func getDetails() -> String{
        return API.baseURL +  "details/"
    }

}
