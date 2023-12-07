//
//  TrayApp.swift
//  Tray
//
//  Created by LA on 30/11/2023.
//
// Following tutorial
// Tray: https://sarunw.com/posts/swiftui-menu-bar-app/
// Joke: https://www.freecodecamp.org/news/make-rest-api-call-in-swiftui-in-2-minutes/

import SwiftUI
import Foundation

@main
struct TrayApp: App {
    @State var currentNumber: String = "1"
    @State private var joke: String = ""
    
    var test = JokeService.fetchJoke
        var body: some Scene {
            
            MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
                ContentView().frame(width: 300, height: 200)
//                // 3
//                Button("One") {
//                    currentNumber = "1"
//                }
//                Button("Two") {
//                    currentNumber = "2"
//                }
//                Button("Three") {
//                    currentNumber = "3"
//                }
//                Button {
//                    Task {
//                        let (data, _) = try await URLSession.shared.data(from: URL(string:"https://api.chucknorris.io/jokes/random")!)
//                        let decodedResponse = try? JSONDecoder().decode(Joke.self, from: data)
//                        joke = decodedResponse?.value ?? ""
//                    }
//                } label: {
//                    Text("Fetch Joke")
//                }
//                Text(joke)
//                Text("Hello, world!")
//                Divider()
//                   Button("Quit") {
//                       NSApplication.shared.terminate(nil)
//                   }
            }.menuBarExtraStyle(.window)
        }
}
