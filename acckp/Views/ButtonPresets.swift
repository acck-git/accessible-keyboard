//
//  Button designs
//

import SwiftUI

//[Letter key]---------------------------------
struct BlackWhiteButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(width: 155, height: 95)
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(.white)
    .cornerRadius(15)
  }
}

//[Extra Letter key]---------------------------
struct LGreenButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(width: 155, height: 95)
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(hex:0xDBF7E0))
    .cornerRadius(15)
  }
}

//[Hidden key]---------------------------------
struct HiddenButton: View {
  var body: some View {
    Button(action: {}, label: { Text("")
        .frame(width: 155, height: 95)
    })
    .hidden()
  }
}

//[Vowel key]----------------------------------
struct LYellowButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity, maxHeight: 95)
        .foregroundColor(.black)
        .font(.system(size: 35, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(hex:0xFFEB99))
    .cornerRadius(50)
  }
}

//[Space key]----------------------------------
struct LPurpleLongButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity, maxHeight: 95)
        .foregroundColor(.black)
        .font(.system(size: 35))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(hex:0xCDCCF3))
    .cornerRadius(15)
  }
}

//[Delete key]---------------------------------
struct LRedButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(width: 180, height: 95)
        .foregroundColor(.black)
        .font(.system(size: 35))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(hex:0xFF766E))
    .cornerRadius(15)
  }
}

//[Settings key]-------------------------------
struct LBlueImageButton: View {
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
struct LGreyImageButton: View {
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

//preview stuff
struct ButtonPresetsPreview: View {
  var body: some View {
    VStack {
      BlackWhiteButton(text: "א", action: {})
      LGreenButton(text: "א", action: {})
      HiddenButton()
      LYellowButton(text: "א", action: {})
      LPurpleLongButton(text: "א", action: {})
      LRedButton(text: "א", action: {})
      LBlueImageButton(image: "eraser", action: {})
      LGreyImageButton(image: "eraser", action: {})
    }
  }
}

#Preview {
  ButtonPresetsPreview()
}
