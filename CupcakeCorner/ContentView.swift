//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import SwiftUI

struct ContentView: View 
{
    @State private var results = [Result]();
    
    var body: some View
    {
        List(results, id: \.trackId)
        {   item in
            
            VStack(alignment: .leading)
            {
                AsyncImage(url: URL(string: "https://hws.dev/img/bad.png"))
                { phase in
                    if let image = phase.image
                    {
                        image
                            .resizable()
                            .scaledToFit();
                    }
                    else if phase.error != nil
                    {
                        Text("There was an error loading the image.");
                    }
                    else
                    {
                        ProgressView();
                    }
                }
                Text(item.trackName)
                    .font(.headline);
                Text(item.collectionName);
            }
        }
        .task {
            await loadData();
        }
    }
    
    func loadData() async
    {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL");
            return;
        }
        
        do
        {
            let (data, _) = try await URLSession.shared.data(from:url);
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) 
            {
                results = decodedResponse.results;
            }
        }
        catch
        {
            print("Invalid data");
        }
    }
}

#Preview {
    ContentView()
}
