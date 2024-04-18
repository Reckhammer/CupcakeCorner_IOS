//
//  Response.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import Foundation

struct Response: Codable
{
    var results: [Result];
}

struct Result: Codable
{
    var trackId: Int;
    var trackName: String;
    var collectionName: String;
}
