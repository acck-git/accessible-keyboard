//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct ToplineSubView: View {
  @ObservedObject var gVars = GlobalVars.get()
  var body: some View {
    //[Top line container]---------------------
    if gVars.image == "" {
      HStack(spacing:20) {
        TTSButton(image: "speaker.fill", action: {
          gVars.speak()
        })
          .padding(.leading, 20.0)
        TextInput(text: gVars.inputText)
      }
      .padding(.trailing, 20.0)
    }
    else {
      HStack(spacing:10) {
        ImageSubmitButton(image:"checkmark",action: {
          gVars.checkSpelling()
        })
        TinyImageButton(image: gVars.image, action: {
          gVars.imageZoom = true
        })
        TTSButton(image: "speaker.fill", action: {
          gVars.speak()
        })
          .padding(.trailing, 15.0)
        TextInput(text: gVars.inputText)
      }
      
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
    }
  }
}

#Preview {
  ToplineSubView()
}
