//
//  Double+extention.swift
//  iTunesSearchAPI
//
//  Created by Sunjay Kalsi on 29/10/2022.
//

import Foundation

extension Double {
    static func doubleUnwrap(doubleOne: Double?, doubleTwo: Double?) -> Double{
        let hdPrice = doubleOne
        let sdPrice = doubleTwo
        if hdPrice != nil {
            return hdPrice ?? 0.0
        } else {
            return sdPrice ?? 0.0
        }
    }
}
