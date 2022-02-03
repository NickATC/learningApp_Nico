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
    
}
