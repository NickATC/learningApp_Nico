//
//  LearningApp_NicoApp.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 20/01/22.
//

import SwiftUI

@main
struct LearningApp_Nico: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
