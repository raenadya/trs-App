import SwiftUI

struct AvatarView: View {
    
    @State var showingAvatarView = false
    @State var avatarImage: Image = Image("defaultAvatar")
    @State private var profileImage: UIImage? = nil
    
    var body: some View {
        
        VStack {
            ZStack {
                
                avatarImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 110, height: 110)
                    .position(x: 130, y: 70)
                
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .foregroundColor(.purple)
                        .scaledToFit()
                        .fontWeight(.light)
                        .frame(width: 150, height: 150)
                    
                }
            }
                
                HStack (spacing:40) {
                    
                    VStack{
                        
                        Button {
                            self.avatarImage = Image("")
                        } label: {
                            Image("no avatar")
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Button {
                            self.avatarImage = Image("bow tie (10c)")
                        } label: {
                            Image("bow tie (10c)")
                                .resizable()
                                .scaledToFit()
                        }
                        
                        Button{
                            self.avatarImage = Image("cap (10c)")
                        }label:{
                            Image("cap (10c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("cat ears (30c)")
                        }label:{
                            Image("cat ears (30c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("chef (20c)")
                        }label:{
                            Image("chef (20c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("crown (20c)")
                        }label:{
                            Image("crown (20c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("devil horns (30c)")
                        }label:{
                            Image("devil horns (30c)")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    VStack{
                        Button{
                            self.avatarImage = Image("flower crown (10c)")
                        }label:{
                            Image("flower crown (10c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("graduation hat (20c)")
                        }label:{
                            Image("graduation hat (20c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("headphones (40c)")
                        }label:{
                            Image("headphones (40c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("mexican hat (40c)")
                        }label:{
                            Image("mexican hat (40c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("party hat (10c)")
                        }label:{
                            Image("party hat (10c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("plant (30c)")
                        }label:{
                            Image("plant (30c)")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    VStack{
                        Button{
                            self.avatarImage = Image("rabbit ears (30c)")
                        }label:{
                            Image("rabbit ears (30c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("santa hat (50c)")
                        }label:{
                            Image("santa hat (50c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("tiara (50c)")
                        }label:{
                            Image("tiara (50c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("top hat (40c)")
                        }label:{
                            Image("top hat (40c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("viking helmet (20c)")
                        }label:{
                            Image("viking helmet (20c)")
                                .resizable()
                                .scaledToFit()
                        }
                        Button{
                            self.avatarImage = Image("witch hat (20c)")
                        }label:{
                            Image("witch hat (20c)")
                                .resizable()
                                .scaledToFit()
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
