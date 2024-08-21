//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct ToplineSubView: View {
  @ObservedObject var gVars = GlobalVars.get()
  var NilData = Data()
  var body: some View {
    //[Top line container]---------------------
    if gVars.image == nil {
      HStack(spacing:20) {
        TTSButton(image: "speaker.fill", action: {
          gVars.speak()
        })
        .padding(.leading, 20.0)
        //-----------------------
        TextInput(text: gVars.inputText)
      }
      .padding(.trailing, 20.0)
    }
    else {
      HStack(spacing:10) {
        ImageSubmitButton(image:"checkmark",action: {
          gVars.checkSpelling()
        })
        //-----------------------
        if gVars.image!.image != NilData {
          TinyImageButtonNew(image: gVars.image!.image!, action: {
            gVars.imageZoom = true
          })
        }
        else {
          TinyImageButton(image: gVars.image!.key, action: {
            gVars.imageZoom = true
          })
        }
        //-----------------------
        TTSButton(image: "speaker.fill", action: {
          gVars.speak()
        })
        .padding(.trailing, 15.0)
        //-----------------------
        TextInput(text: gVars.inputText)
      }
      .padding(.horizontal, 20.0)
    }
  }
}

#Preview {
  ToplineSubView()
}
