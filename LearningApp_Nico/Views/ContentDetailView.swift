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
            //Description
            CodeTextView()
            
            //Next Lesson Button
            //Show button only if there is a next lesson
            if model.hasNextLesson(){
                Button {
                    //Advance the lesson
                    model.nextLesson()
                } label: {
                    
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        //Next lesson name... that's why the +1 exists!
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
            }
            else {
                Button {
                //Show button only where it's the last module
                    //This will take the user to main menu
                    model.currentContentSelected = nil
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text("Complete")
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

