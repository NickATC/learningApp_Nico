//
//  ContentViewRow.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 3/02/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        //
        let lesson = model.currentModule!.content.lessons[index]
        
        //Display lesson card
        ZStack(alignment: .leading){
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 55)
            
            HStack(spacing: 30){
                //Number
                Text("\(index + 1)")
                    .bold()
                
                //Text
                VStack(alignment: .leading){
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                        .font(.caption)
                }
            }
            .padding()
        }
        .padding(.bottom, 2)
        
        //
    }
}
