//
//  Order.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import Foundation

@Observable
class Order
{
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
}
