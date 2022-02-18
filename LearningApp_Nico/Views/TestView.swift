//
//  TestView.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 12/02/22.
//

import SwiftUI
import CoreAudio



struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex: Int?
    @State var submitted = false
    
    @State var numCorrect = 0 //To track the correct answer
    
    var body: some View {
        //
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading){
            //Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
            //Question
                CodeTextView()
                    .padding(.horizontal, 20)
            
            //Answers/Buttons
                ScrollView{
                    VStack{
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            
                            Button {
                                //Track the selected index
                                selectedAnswerIndex = index
                            } label: {
                                ZStack{
                                    //Make the button selecte by user gray
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    } else {
                                        //Answer has been submitted
                                        
                                        
                                        //If selected and it IS the correct answer, green background!
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                            
                                        } else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex{
                                            //If selected and it IS NOT the correct answer, RED background!
                                            RectangleCard(color: .red)
                                                .frame(height: 48)
                                            
                                        } else if index == model.currentQuestion!.correctIndex {
                                            //Shows the correct answer if it's different than the selected by user!
                                            RectangleCard(color: .green)
                                                .frame(height: 48)
                                        } else {
                                            RectangleCard(color: .white)
                                                .frame(height: 48)
                                        }
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }
                            .disabled(submitted)
                            
                        }
                    }
                    .tint(.black)
                    .padding()
                }
            
            //Submit Button
                Button {
                    //check if answer has been submitted
                    if submitted == true {
                        //answer has been submitted
                        model.nextQuestion()
                        
                        //reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    } else {
                        //Submit the answer
                        
                        //Change submitted state to true
                        submitted = true
                        
                        //Check the answer
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    }
                } label: {
                    ZStack{
                        RectangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                            
                    }
                    .padding()

                }
                .disabled(selectedAnswerIndex == nil)

                
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        } else {
            // Test hasn't loaded yet// Another bug when this View is not fired using the .onAppear()
            ProgressView()
        }
            
        
        //
    }
    
    var buttonText: String {
        if submitted == true {
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
                return "Finish!"
            } else {
                return "Next"
            }
        } else {
            return "Submit"
        }
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
