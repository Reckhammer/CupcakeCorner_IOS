//
//  Order.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import Foundation

@Observable
class Order: Codable
{
    enum CodingKeys: String, CodingKey
    {
        case _type = "type";
        case _quantity = "quantity";
        case _specialRequestedEnabled = "specialRequestedEnabled";
        case _extraFrosting = "extraFrosting";
        case _addSprinkles = "addSprinkles"
        case _name = "name";
        case _city = "city";
        case _streetAddress = "streetAddress";
        case _zip = "zip";
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate"];
    
    var type = 0;
    var quantity = 3;
    
    var specialRequestedEnabled = false 
    {
        didSet
        {
            if (specialRequestedEnabled == false)
            {
                extraFrosting = false;
                addSprinkles = false;
            }
        }
    }
    
    var extraFrosting = false;
    var addSprinkles = false;
    
    var name = "";
    var streetAddress = "";
    var city = "";
    var zip = "";
    
    var hasValidAddress: Bool
    {
        if (name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty)
        {
            return false;
        }
        
        return true;
    }
    
    var cost: Double
    {
        var cost = Double(quantity) * 2;
        
        cost += (Double(type) / 2);
        
        if (extraFrosting)
        {
            cost += Double(quantity);
        }
        
        if (addSprinkles)
        {
            cost += Double(quantity) / 2;
        }
        
        return cost;
    }
}
