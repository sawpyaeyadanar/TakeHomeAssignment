//
//  DetailVM.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/17/22.
//

import Foundation
class DetailVM {

    var beforeApiCall : (() -> Void)?
    var afterApiCall : (() -> Void)?
    var details: DetailData?
    var selectedIndex: Int

    init(selectedIndex: Int) {
        self.selectedIndex = selectedIndex
    }
    func getDetailData(success: @escaping ((DetailData) -> Void),
                  failure: @escaping ((APPError?) -> Void)) {
        beforeApiCall?()
        let url = Constants.getDetails().appending(String(selectedIndex)).appending(".json")
        APIManager.sharedInstance.dataRequest(with: url, objectType: DetailData.self) { (result: Result) in
            self.afterApiCall?()
            switch result {
            case .success(let res):
                self.details = res
                success(res)
            case .failure(let aPPError):
                failure(aPPError)
                debugPrint(aPPError)
            }
        }
    }
    
}
