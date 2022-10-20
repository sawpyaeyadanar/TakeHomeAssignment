//
//  ListVM.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/13/22.
//

import Foundation
class ListViewModel {

    // MARK:- loading Callbacks
    var beforeApiCall : (() -> Void)?
    var afterApiCall : (() -> Void)?
    var response: [ListData]?

    func getListData(success: @escaping (([ListData]) -> Void),
                  failure: @escaping ((APPError?) -> Void)) {
        beforeApiCall?()
        APIManager.sharedInstance.dataRequest(with: Constants.getList(), objectType: [ListData].self) { (result: Result) in
            self.afterApiCall?()
            switch result {
            case .success(let res):
                self.response = res
                success(res)
            case .failure(let aPPError):
                failure(aPPError)
                debugPrint(aPPError)
            }
        }
    }
}
