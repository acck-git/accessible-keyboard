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
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .padding(.trailing, -5.0)
        .environment(\.layoutDirection,.rightToLeft)
        .accessibilityIdentifier("textbox")
    }.frame(maxWidth: .infinity, minHeight: 80, alignment: .trailing)
      .padding(.horizontal)
      .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(.black, lineWidth: 2))
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
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(.white)
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
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:0xDBF7E0))
    .cornerRadius(15)
  }
}
//[Hidden key]---------------------------------
struct HiddenButton: View {
  var body: some View {
    Button(action: {}, label: { Text("")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    })
    .hidden()
  }
}
//[Vowel key]----------------------------------
struct VowelButton: View {
  var image: String
  var action: (() -> Void)
  var enabled: Bool
  var body: some View {
    let button = Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(.black, lineWidth: 2)
        )
    })
    if enabled {
      button.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/).cornerRadius(50)
    }
    else {
      button.background(Color(hex:0xFFEB99)).cornerRadius(50)
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
        .foregroundColor(.black)
        .font(.system(size: 35))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:0xCDCCF3))
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
        .foregroundColor(.black)
        .font(.system(size: 35))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:0xFF766E))
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
        .foregroundColor(.black)
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(hex:0xCCE4FF))
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
        .foregroundColor(.black)
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(.white)
    .cornerRadius(15)
  }
}

//------------------------------------------------
//preview stuff
struct MainPresetsPreview: View {
  var body: some View {
    VStack {
      TextInput(text: "היי")
      LetterButton(text: "א", action: {})
      ExtraLetterButton(text: "א", action: {})
      //HiddenButton()
      HStack(spacing: 10.0) {
        VowelButton(image: "a", action: {}, enabled: true)
        VowelButton(image: "b", action: {}, enabled: false)
        VowelButton(image: "c", action: {}, enabled: false)
        VowelButton(image: "d", action: {}, enabled: false)
        VowelButton(image: "e", action: {}, enabled: false)
        VowelButton(image: "f", action: {}, enabled: false)
      }.padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/).frame(maxWidth: 823)
      SpaceButton(text: "א", action: {})
      DeleteButton(text: "א", action: {})
      SettingsButton(image: "gear", action: {})
      TTSButton(image: "eraser", action: {})
    }
  }
}
#Preview {
  MainPresetsPreview()
}
