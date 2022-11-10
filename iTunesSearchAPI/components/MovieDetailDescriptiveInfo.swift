//
//  MovieDetailDescriptiveInfo.swift
//  iTunesSearchAPI
//
//  Created by Maurice Hunter on 11/9/22.
//

import SwiftUI

struct MovieDetailDescriptiveInfo: View {
    
    var price: Double?
    var rating: String
    var runtime: Int?
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Purchase Price")
            Text("$\(Double.doubleUnwrap(doubleOne: price, doubleTwo: price), specifier: "%.2f")", comment: "currency")
            Text("Rating: \(rating)")
            Text("Runtime: \(Int.intUnwrap(millisecond: runtime)) minutes")
        }
    }
}

struct MovieDetailDescriptiveInfo_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailDescriptiveInfo(price: Double.doubleUnwrap(doubleOne: 10.00, doubleTwo: 10.00), rating: "R", runtime: 100000)
    }
}
