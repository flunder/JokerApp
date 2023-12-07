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
    
    var body: some Scene {
        MenuBarExtra(currentNumber, systemImage: "\(currentNumber).circle") {
            ContentView().frame(width: 300)
        }.menuBarExtraStyle(.window)
    }
}
