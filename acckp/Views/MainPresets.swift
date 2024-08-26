//
//  Designs for main screen
//

import SwiftUI
import iDummyCursor

//[Text field]---------------------------------
struct TextInput: View {
  var text: String
  var body: some View {
    HStack{
      iDummyCursor().fontSize(45)
      Text(text)
        .lineLimit(1)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .font(.system(size: 35, weight: .heavy))
        .padding(.trailing, -5.0)
        .environment(\.layoutDirection,.rightToLeft)
        .accessibilityIdentifier("textbox")
    }.frame(maxWidth: .infinity, minHeight: 80, alignment: .trailing)
      .padding(.horizontal)
      .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2))
      .cornerRadius(5)
  }
}
//[Letter key]---------------------------------
struct LetterButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.bg1_col[GlobalVars.get().colorSet]))
    .cornerRadius(15)
  }
}
//[Extra Letter key]---------------------------
struct ExtraLetterButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.extra_col[GlobalVars.get().colorSet]))
    .cornerRadius(15)
  }
}
//[Hidden key]---------------------------------
struct HiddenButton: View {
  var body: some View {
    VStack {}
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .hidden()
  }
}
//[Vowel key]----------------------------------
struct VowelButton: View {
  var image: String
  var action: (() -> Void)
  var enabled: Bool = false
  var selected: Bool = false
  var body: some View {
    let button = Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    if enabled {
      if selected {
        button.background(Color(hex:StaticData.board_col[GlobalVars.get().colorSet])).cornerRadius(50)
      }
      else {
        button.background(Color(hex:StaticData.vowel_col[GlobalVars.get().colorSet])).cornerRadius(50)
      }
    }
    else {
      button.disabled(true).cornerRadius(50)
    }
  }
}
//[Space key]----------------------------------
struct SpaceButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .font(.system(size: 35))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.space_col[GlobalVars.get().colorSet]))
    .cornerRadius(15)
  }
}
//[Delete key]---------------------------------
struct DeleteButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(width: 180)
        .frame(maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .font(.system(size: 35))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.delete_col[GlobalVars.get().colorSet]))
    .cornerRadius(15)
  }
}
//[Settings key]-------------------------------
struct SettingsButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(systemName: image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
        .frame(width: 95, height: 95)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
        .accessibilityIdentifier("settings")
    })
    .background(Color(hex:StaticData.settings_col[GlobalVars.get().colorSet]))
    .cornerRadius(50)
  }
}
//[Audio key]----------------------------------
struct TTSButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(systemName: image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
        .frame(width: 80, height: 80)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .background(Color(hex:StaticData.bg1_col[GlobalVars.get().colorSet]))
    .cornerRadius(15)
  }
}
