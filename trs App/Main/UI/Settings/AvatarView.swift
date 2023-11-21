//
//  AvatarView.swift
//  trs App
//
//  Created by Nicole Yu on 2023/11/17.
//

import SwiftUI

struct AvatarView: View {
    
    @State var showingAvatarView = false
    
    var body: some View {
        
        
        VStack{
            
            Image(systemName:"circle")
                .resizable()
                .foregroundColor(.purple)
                .scaledToFit()
                .frame(width:150)
                .frame(height:150)
            
            Text("Me")
                .font(.largeTitle)
            
            HStack(spacing:40){
                
                VStack{
                    Button{}label:{
                        Image("bow tie (10c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("cap (10c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("cat ears (30c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("chef (20c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("crown (20c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("devil horns (30c)")
                            .resizable()
                    }
                }
                VStack{
                    Button{}label:{
                        Image("flower crown (10c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("graduation hat (20c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("headphones (40c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("mexican hat (40c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("party hat (10c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("plant (30c)")
                            .resizable()
                    }
                }
                VStack{
                    Button{}label:{
                        Image("rabbit ears (30c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("santa hat (50c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("tiara (50c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("top hat (40c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("viking helmet (20c)")
                            .resizable()
                    }
                    Button{}label:{
                        Image("witch hat (20c)")
                            .resizable()
                    }
                }
            }
        }
        
        .scaledToFit()
        .frame(height:600)
        .frame(width:400)
        
    }
    
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView()
    }
}

//cap (10c),cat ears (30c),chef (20c),crown (20c)
//devil horns (30c),flower crown (10c)
//graduation hat (20c)
//headphones (40c)
//mexican hat (40c)
//party hat (10c)
//plant (30c)
//rabbit ears (30c)
//santa hat (50c)
//tiara (50c)
//top hat (40c)
//viking helmet (20c)
//witch hat (20c)
