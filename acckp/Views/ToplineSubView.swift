//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct ToplineSubView: View {
  @EnvironmentObject var gVars: GlobalVars
  var body: some View {
    //[Top line container]---------------------
    
    if gVars.image == ""{
      HStack(spacing:20) {
        //TTSButton(image: "speaker.fill", action: {}).disabled(true).opacity(0.3)
        TextInput(text: gVars.inputText)
          .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
          .padding(.vertical, 20.0)
          .frame(maxWidth:.infinity, maxHeight:123)
      }
    }
    else{
      HStack(spacing:10) {
        ImageSubmitButton(image:"checkmark",action:{
          Images.checkSpelling(gVars:gVars)
        })
        TinyImageButton(image: gVars.image, action: {
          gVars.imageZoom = true
        })
        //TTSButton(image: "speaker.fill", action: {}).disabled(true).opacity(0.3)
        TextInput(text: gVars.inputText)
      }
      
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
      .padding(.vertical, 20.0)
      .frame(maxWidth:.infinity, maxHeight:123)
    }
  }
}

#Preview {
  ToplineSubView().environmentObject(GlobalVars(image:"a1"))
}
