//
//  ContentView.swift
//  Tray
//
//  Created by LA on 30/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading: Bool = false
    @State private var isError: Bool = false
    @State private var joke: String = ""
    
    func startFetchNorris() {
        Task {
            await fetchNorris()
        }
    }
    
    func fetchNorris() async {
        isLoading = true
        isError = false
        
        let url = URL(string: "https://api.chucknoreris.io/jokes/random")!
        
        let task = URLSession.shared.dataTask(with: url) {( data, response, error ) in
            // Error fetching ?
            guard let data = data else {
                isError = true
                return
            }
            // Seems alright
            print(String(data: data, encoding: .utf8)!)
            let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
            joke = decodedResponse?.value ?? ""
            isLoading = false
            print("HERE 1!")
        }
        
        // Async call can be too quick or fail
        // Added delay so it actually shows the spinner
        try? await Task.sleep(nanoseconds: 500_000_000)
        
        isLoading = false
        task.resume()
        print("HERE 2!")
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Joke")
                .bold()
                .padding(.top, 5)
            VStack {
                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                        .offset(y: -5)
                } else {
                    if isError {
                        Text("There was an error")
                    } else {
                        Text(joke)
                            .font(.system(size: 20))
                            .lineLimit(nil)
                    }
                }
            }.padding(.vertical, 2)
            
            Divider()
            
            Button("FetchNorris") {
                startFetchNorris()
            }.buttonStyle(PlainButtonStyle())
             .onAppear {
                startFetchNorris()
             }.padding(.vertical, 2)
            
            Divider()
            
            Button("Quit") {
               NSApplication.shared.terminate(nil)
            }.buttonStyle(PlainButtonStyle())
        }
        .padding(10)
        .frame(alignment: Alignment.leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
