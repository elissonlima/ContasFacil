//
//  ContasFacilApp.swift
//  ContasFacil
//
//  Created by Elisson Silva on 21/05/24.
//

import Amplify
import AWSCognitoAuthPlugin
import SwiftUI

@main
struct ContasFacilApp: App {
    
    @State var isUserSignedIn = false
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            
//            NavigationStack(path: $router.navPath) {
//                
//                if (isUserSignedIn) {
//                    HomeView()
//                } else {
//                    LoginView()
//                    .navigationDestination(for: Router.Destination.self) { destination in
//                        switch destination {
//                        case .signup:
//                            SignUpView()
//                        case .signupconfirmation(let email):
//                            SignUpConfirmationView(email: email)
//                        }
//                    }
//                }
//                   
//            }
//            .toolbar(.hidden)
//            .task {
//                isUserSignedIn = await fetchCurrentAuthSession()
//            }
//            .environmentObject(router)
        }
    }
    
    
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            
            print("Amplify configured with auth plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
    
    func fetchCurrentAuthSession() async -> Bool {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            return session.isSignedIn
        } catch let error as AuthError {
            print("Fetch session failed with error \(error)")
            return false
        } catch {
            print("Unexpected error: \(error)")
            return false
        }
    }
}
