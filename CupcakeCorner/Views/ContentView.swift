//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Joshua Rechkemmer on 4/18/24.
//

import SwiftUI
import CoreHaptics

struct ContentView: View 
{
    @State private var results = [Result]();
    
    @State private var username = "";
    @State private var email = "";
    
    @State private var counter = 0;
    
    @State private var engine: CHHapticEngine?;
    
    var disableForm: Bool
    {
        username.count < 5 || email.count < 5;
    }
    
    var body: some View
    {
        VStack
        {
            Button("Encode User", action: encodeUser);
            
            Button("Tap Count: \(counter)")
            {
                counter += 1;
            }
            .sensoryFeedback(.increase, trigger: counter);
            
            Form
            {
                Section
                {
                    TextField("Username", text: $username);
                    TextField("Email", text: $email);
                }
                
                Section
                {
                    Button("Create Account")
                    {
                        print("Creating account...");
                    }
                }
                .disabled(disableForm);
            }
            
            Button("Tap Me", action: complexSuccess)
                .onAppear(perform: prepareHaptics);
            
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
    
    func encodeUser()
    {
        let data = try! JSONEncoder().encode(User());
        let str = String(decoding: data, as: UTF8.self);
        print(str);
    }
    
    func prepareHaptics()
    {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return};
        
        do
        {
            engine = try CHHapticEngine();
            try engine?.start();
        }
        catch
        {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func complexSuccess()
    {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return};
        var events = [CHHapticEvent]();
        
        // create one instense, sharp tap
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1);
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1);
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0);
        events.append(event);
        
        // convert those events into a pattern and play it immediately
        do
        {
            let pattern = try CHHapticPattern(events: events, parameters: []);
            let player = try engine?.makePlayer(with: pattern);
            try player?.start(atTime:0);
        }
        catch
        {
            print("Failed to play pattern: \(error.localizedDescription)");
        }
    }
}

#Preview {
    ContentView()
}
