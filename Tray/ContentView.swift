//
//  ContentView.swift
//  Tray
//
//  Created by LA on 30/11/2023.
//

import SwiftUI

struct OsButton: ButtonStyle {
    @State private var hovered = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 2)
            .padding(.horizontal, 8)
            .background(Color(red: 0, green: 0, blue: 0, opacity: hovered ? 0.1 : 0))
            .cornerRadius(5)
            .foregroundStyle(.black)
            .onHover { isHovered in
                self.hovered = isHovered
            }
    }
}

struct ContentView: View {
    @State private var isLoading: Bool = false
    @State private var isError: String = ""
    @State private var setup: String = ""
    @State private var punchline: String = ""
    
    struct Joke: Codable {
        let type: String
        let setup: String
        let punchline: String
        let id: Int
    }
    
    let url = URL(string: "https://official-joke-api.appspot.com/random_joke")!
    
    func startFetchNorris() {
        Task {
            await fetchNorris()
        }
    }
    
    func fetchNorris() async {
        isError = "";
        isLoading = true
        
        URLSession.shared.dataTask(with: url) {( data, response, error ) in
            guard let jsonData = data else {
                isLoading = false
                isError = "Error fetching joke"
                return
            }
            // print(String(data: jsonData, encoding: .utf8)!)
            let decodedResponse = try? JSONDecoder().decode(Joke.self, from: jsonData)
            self.setup = decodedResponse?.setup ?? ""
            self.punchline = decodedResponse?.punchline ?? ""
            isLoading = false
        }.resume()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Joke")
                .bold()
                .padding(.top, 5)
                .padding(.horizontal, 8)
            
            VStack(alignment: .leading) {
                if isLoading {
                    ProgressView()
                        .controlSize(.small)
                        .offset(y: -5)
                } else {
                    if isError != "" {
                        Text(isError)
                    } else {
                        VStack(alignment: .leading) {
                            Text(setup)
                                .lineLimit(nil)
                            Text(punchline)
                                .lineLimit(nil)
                                .padding(.top, 5)
                        }
                    }
                }
            }.padding(.vertical, 2)
             .padding(.horizontal, 8)
            
            Divider().padding(.horizontal, 8)
            
            Button("FetchNorris") {
                startFetchNorris()
            }.buttonStyle(OsButton())
             .onAppear {
                startFetchNorris()
             }
            
            Divider().padding(.horizontal, 8)
            
            Button("Quit") {
               NSApplication.shared.terminate(nil)
            }
            .buttonStyle(OsButton())
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
