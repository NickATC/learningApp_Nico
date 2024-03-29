//
//  HomeViewRow.swift
//  LearningApp_Nico
//
//  Created by NICOLAS  TAUTIVA on 2/02/22.
//

import SwiftUI

struct HomeViewRow: View {
    
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
        //
        
        
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack{
                //Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())//circle shape!
                
                Spacer()
                
                //Text
                VStack(alignment: .leading, spacing: 10){
                    
                    //Headline
                    Text(title)
                        .bold()
                    
                    //Description
                    Text(description)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    //Icons
                    HStack{
                        //Icon
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        //Number of Lessons / Qeustions
                        Text(count)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        
                        //Icon2
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        //Time
                        Text(time)
                            .font(Font.system(size: 10))
                        
                        
                    }
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 20)
        }
        
        //
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn Swift", description: "some description here!", count: "10 Lessons", time: "2 hours")
    }
}
