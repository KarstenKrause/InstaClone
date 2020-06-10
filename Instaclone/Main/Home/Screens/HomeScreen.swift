//
//  HomeScreen.swift
//  Instaclone
//
//  Created by Karsten Krause on 29.05.20.
//  Copyright © 2020 Karsten Krause. All rights reserved.
//

import SwiftUI
import SwiftUIRefresh

struct HomeScreen: View {
    
    @EnvironmentObject var screenRouter: ScreenRouter
    @State var refreshIsShowing = false
    
    // MARK: - Custom Initializer
    // MARK: Navigation Bars lassen sich allein durch SwiftUI nicht stylen.
    // SwiftUI nutzt für einen NavigationView eine UINavigationBar (schön zu sehen in der Debut View Hierarchy).
    // Durch die UINavigationbar lässt sich dann der Style der NavigationBar der NavigationView von SwiftUI ändern
    init() {
        UINavigationBar.appearance().backgroundColor = .systemBackground
    }
    
    var body: some View {
        VStack {
            
            TabView {
                
                // MARK: - NavigationBar & Homefeed
                NavigationView {
                    PostListScreen()
                        
                        
                        .navigationBarItems(
                            leading:
                            HStack {
                                Button(action: {
                                    self.screenRouter.currentScreen = "loginScreen"
                                    
                                }) {
                                    Image(systemName: "arrow.uturn.left.circle").imageScale(.large).foregroundColor(.primary).frame(width: 40, height: 35, alignment: .leading)
                                }            
                            },
                            
                            trailing:
                            HStack {
                                Button(action: {
                                    print("Messenger öffnen")
                                    self.screenRouter.currentScreen = "messengerScreen"
                                }) {
                                    Image(systemName: "paperplane").imageScale(.large).foregroundColor(.primary).frame(width: 40, height: 30, alignment: .trailing)
                                }
                            }
                    )
                        .navigationBarTitle(
                            Text("Instaclone"), displayMode: .inline)
                    
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .tabItem {Image(systemName: "house").imageScale(.large)}
                .pullToRefresh(isShowing: $refreshIsShowing) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        // MARK: TODO: Firebase-Daten neu laden!
                        print("Lade Daten aus Firebase Datenbank")
                        self.refreshIsShowing = false
                    }
                }
                
                
                // MARK: - SearchScreen
                NavigationView {
                    Text("Suchen Seite")
                }.tabItem{Image(systemName: "magnifyingglass").imageScale(.large)}
                
                // MARK: - PostCreationScreen
                NavigationView {
                    PostCreationScreen()
                        .navigationBarItems(leading:
                            HStack {
                                Text("Neuer Beitrag").bold()
                            }
                    )
                    
                }.tabItem{Image(systemName: "plus.square").imageScale(.large)}
                
                // MARK: - ActivityScreen
                NavigationView {
                    Text("Likes-Liste")
                }.tabItem{Image(systemName: "heart").imageScale(.large)}
                
                // MARK: - ProfileScreen
                NavigationView {
                    Text("Profil-Seite")
                }.tabItem{Image(systemName: "person.circle").imageScale(.large)}
                
            }
            
        }
        
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen().environmentObject(ScreenRouter())
    }
}
