//
//  User.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import Foundation

@Observable
class User: Codable
{
    enum CodingKeys: String, CodingKey
    {
        case _name = "name";
    }
    
    var name = "Joshua";
}
