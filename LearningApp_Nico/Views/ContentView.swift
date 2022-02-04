//
//  ContentView.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 3/02/22.
//

import SwiftUI

struct ContentView: View {
        
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        //
        
        ScrollView{
            
            LazyVStack{
                
                //Confirm the currentModule is set
                if model.currentModule != nil {
                    
                    ForEach(0..<model.currentModule!.content.lessons.count){ index in
                        
                        NavigationLink {
                            ContentDetailView()
                                
                                .onAppear {
                                    model.beginLesson(index)
                                }
                        } label: {
                            ContentViewRow(index: index)
                        }

                        
                        
                    
                    }
                }
            }
            .tint(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
        
        //
    }
}

