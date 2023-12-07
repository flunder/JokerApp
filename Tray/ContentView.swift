//
//  ContentView.swift
//  Tray
//
//  Created by LA on 30/11/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAlert = false

    func favoriteAlbum(name: String) {
        print("it's 7 ways \(name)")
    }
    
    func fetchNorris() {
        let url = URL(string: "http://www.stackoverflow.com")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!!!")
            Button("FetchNorris") {
                fetchNorris()
            }
            Button("My Button") {
                favoriteAlbum(name: "xxx");
            }
            Button("Next") {
                print("x")
                showingAlert = true
            }.alert("Important message", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
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
