//
//  ContentView.swift
//  Tray
//
//  Created by LA on 30/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var joke: String = ""
    
    func fetchNorris() {
        let url = URL(string: "https://api.chucknorris.io/jokes/random")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
            let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
            joke = decodedResponse?.value ?? ""
        }

        task.resume()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(joke)
                .font(.system(size: 20))
                .lineLimit(nil)
            
            Button("FetchNorris") {
                fetchNorris()
            }

            Divider()
               Button("Quit") {
                   NSApplication.shared.terminate(nil)
               }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
