//
//  CupcakeContentView.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import SwiftUI

struct CupcakeContentView: View 
{
    @State private var order = Order();
    
    var body: some View
    {
        NavigationStack
        {
            Form
            {
                Section
                {
                    Picker("Select your Cake Flavor", selection: $order.type)
                    {
                        ForEach(Order.types.indices, id: \.self)
                        {
                            Text(Order.types[$0]);
                        }
                    }
                    
                    Stepper("Number of Cakes: \(order.quantity)", value: $order.quantity, in: 3...20);
                }
                
                Section
                {
                    Toggle("Any special requests?", isOn: $order.specialRequestedEnabled);
                    
                    if (order.specialRequestedEnabled)
                    {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting);
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles);
                    }
                }
                
                Section
                {
                    NavigationLink("Delivery Details")
                    {
                        AddressView(order: order);
                    }
                }
            }
            .navigationTitle("Cupcake Corner");
            
        }
    }
}

#Preview {
    CupcakeContentView()
}
