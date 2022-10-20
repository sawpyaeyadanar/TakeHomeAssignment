//
//  Utility.swift
//  CodeTestNinetyNine
//
//  Created by sawpyae on 10/17/22.
//

import Foundation
class Utility {
    static let shared = Utility()
     func currencyFormatter( data: Int) -> String {
        var formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_SG")
        formatter.maximumFractionDigits = 0;
        return formatter.string(from: data as NSNumber) ?? ""
    }
}

