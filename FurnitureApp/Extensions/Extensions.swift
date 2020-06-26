//
//  Extensions.swift
//  FurnitureApp
//
//  Created by Aakash on 26/06/2020.
//  Copyright © 2020 Aakash. All rights reserved.
//

import Foundation

extension Array{
    
    func collection(into size :Int) -> [[Element]]{
        return stride(from: 0, to: count, by:size).map{
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
