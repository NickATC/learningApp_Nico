//
//  ContentModel.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 20/01/22.
//

import Foundation
import SwiftUI
import CoreMedia

class ContentModel: ObservableObject{
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //CUrrent Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //Current description
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    //Current selected Content and test
    @Published var currentContentSelected: Int?
    
    @Published var currentTestSelected: Int?
    
    @Published var currentQuestion: Question?
    @Published var currentQuestionIndex = 0
    
    
    init(){
        getLocalData()  // To get the file in this bundle
        getRemoteData() // To get the file from the internet!!!
        
    }

    //MARK: - Data methods
    func getLocalData() {
        //get url to JSON file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        //Read the file into data object
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            
            //try to decode te JSON into an array

            let jsonDecoder = JSONDecoder()
            
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
            //assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            //TODO log erro
            print("Couldn parse local data")
        }
        
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do{
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
        }
        catch{
            print("couldn't parse style data")
        }
    }
    
    func getRemoteData() {
        //To get the data from the internet, and then parse it
        
        //String path
        let urlString = "https://nickatc.github.io/learningAppData/data2.json"
        
        //Create URL object
        let url = URL(string: urlString)
        
        guard url != nil  else {
            //Couldn't create url
            return
        }
        
        //Create a URLRequest object
        let request = URLRequest(url: url!)
        
        //Get the session and kick off the task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) {( data, response, error) in
            
            //Check if there is an error from the response from the server/Webpage
            guard error == nil else {
                //There was an error
                return
            }
            
            //Handle the response
            do {
                //1.  Create JSON decoder
                let decoder = JSONDecoder()
                
                //2.  Decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                //3.  Append parsed modules into property (array)
                self.modules += modules
            } catch {
                //Couldn't parse json
            }
            
            
            
            
        }
        
        //Kick off the data task
        
        dataTask.resume()
        
    }
    
    
    //MARK: -Module Navigation methods
    
    func beginModule(_ moduleid: Int){
        
        //Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid{
                currentModuleIndex = index
                break
            }
        }
        
        //Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
    func beginLesson(_ lessonIndex: Int){
        //Check that the lesson index is within range o module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        //set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        //Set the current lesson description
        codeText = addStyling(currentLesson!.explanation)
        
    }
    
    func nextLesson() {
        //Advance the lesson index
        currentLessonIndex += 1
        
        //Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count{
            //Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        } else {
            //Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    func beginTest(_ moduleId: Int) {
            
        //Set the current module
        beginModule(moduleId)
        
        //Set the current question
        currentQuestionIndex = 0
        
        //If there are questions, set the current question to the first one.
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            //Set the question content
            codeText = addStyling(currentQuestion!.content)
        }
        
    }
    
    func nextQuestion() {
        //Advance the quetion index
        currentQuestionIndex += 1
        
        //Check that it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            //Set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        ///if not, reset values
        else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    
    
    //MARK: Code Styling
    
    private func addStyling(_ htmlString: String) ->NSAttributedString{
        var resultString = NSAttributedString()
        var data = Data()
        
        //Add the styling data\
        if styleData != nil {
            data.append(self.styleData!)
        }
        
        //Add the HTML data
        data.append(Data(htmlString.utf8))
        
        //Convert the attribute string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }

        return resultString
    }
    
}
