//
//  ContentModel.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 20/01/22.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject{
    
    //List of modules
    @Published var modules = [Module]()
    
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    //CUrrent Lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    init(){
        getLocalData()
        
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
        
    }
    
    func nextLesson() {
        //Advance the lesson index
        currentLessonIndex += 1
        
        //Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count{
            //Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        } else {
            //Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
}
