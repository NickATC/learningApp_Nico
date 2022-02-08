//
//  ContentDetailView.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 4/02/22.
//

import SwiftUI
import AVKit //library to show videos

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    
    
    var body: some View {
        //
        let lesson = model.currentLesson
        let url =  URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        
        VStack{
            //Only show video if we get a valid URL
            if url != nil {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)

            }
            //TODO:  Description
            CodeTextView()
            
            
            //Next Lesson Button
            //Show button only if there is a next lesson
            if model.hasNextLesson(){
                Button {
                    //Advance the lesson
                    model.nextLesson()
                } label: {
                    
                    ZStack{
                        Rectangle()
                            .frame(height: 48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        //Next lesson name... that's why the +1 exists!
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                    
                    
                }
            }
            

        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
        
        
        //
    }
}

