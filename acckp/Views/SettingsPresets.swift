//
//  Designs for settings view
//

import SwiftUI

//[Board key]----------------------------------
struct BoardButton: View {
  var image: String
  var action: (() -> Void)
  var selected: Bool = false
  var body: some View {
    let button = Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
        )
    })
    if selected {
      button.background(Color(hex:StaticData.board_col[0])).cornerRadius(50)
    }
    else {
      button.background(Color(hex:StaticData.vowel_col[0])).cornerRadius(50)
    }
  }
}
//[Back Button]-------------------------------------
struct BackButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(systemName: image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
        .frame(width: 95, height: 95)
        .foregroundColor(Color(hex:StaticData.text_col[0]))
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
        )
        .accessibilityIdentifier("settings")
    })
    .background(Color(hex:StaticData.settings_col[0]))
    .cornerRadius(50)
  }
}
//[Login Button]---------------------------------
struct TeacherLoginButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(width: 155, height: 80)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .font(.system(size: 30, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 5)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.bg1_col[GlobalVars.get().colorSet]))
    .cornerRadius(5)
  }
}
//[Login Field]---------------------------------
struct TeacherLoginInput: View {
  var placeholder: String
  @Binding var text: String
  var body: some View {
    SecureField(placeholder, text: $text)
      .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
      .font(.system(size: 35, weight: .heavy))
      .frame(width: 300, height: 80, alignment: .trailing)
      .padding(.horizontal,6)
      .environment(\.layoutDirection,.rightToLeft)
      .border(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
  }
}
//[Student Picker]---------------------------------
struct StudentPicker: View {
  var array: [String]
  var onChange: (() -> Void)
  @State var gVars = GlobalVars.get()
  var body: some View {
    Picker(selection: $gVars.student, label: Text("Picker")) {
      ForEach(array, id:\.self) {
        Text($0)
          .font(.largeTitle)
      }
    }
    .onChange(of: gVars.student, initial: true){onChange()}
    .scaleEffect(2)
    .pickerStyle(.menu)
    .accentColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
    .frame(width: 400, height: 80, alignment: .center)
    .border(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
  }
}
//[Student Picker Teacher]---------------------------------
struct StudentPickerTeacher: View {
  var array: [String]
  var onChange: (() -> Void)
  @State var gVars = GlobalVars.get()
  var body: some View {
    Picker(selection: $gVars.student_edit, label: Text("")) {
      ForEach(array, id:\.self) {
        Text($0)
          .font(.largeTitle)
      }
    }
    .onChange(of: gVars.student_edit, initial: true){onChange()}
    .scaleEffect(1.5)
    .pickerStyle(.menu)
    .accentColor(Color(hex:StaticData.text_col[0]))
    .frame(height: 40, alignment: .center)
    .frame(maxWidth: .infinity)
    .background(Color(hex:StaticData.bg1_col[0]))
    .border(Color(hex:StaticData.text_col[0]))
  }
}

//[Arrow Button]----------------------------------
struct ArrowButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(systemName: image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: -10.0, leading: 20.0, bottom: -10.0, trailing: 20.0))
        .frame(width: 95, height: 200)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .background(Color(hex:StaticData.bg2_col[GlobalVars.get().colorSet]))
    .cornerRadius(50)
  }
}
struct ArrowButtonSmall: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(systemName: image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: -10.0, leading: 20.0, bottom: -10.0, trailing: 20.0))
        .frame(width: 60, height: 160)
        .foregroundColor(Color(hex:StaticData.text_col[0]))
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
        )
    })
    .background(Color(hex:StaticData.bg2_col[0]))
    .cornerRadius(50)
  }
}
//[Image Button]----------------------------------
struct ImageButton: View {
  var image: String
  var selected: Bool = false
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 0)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth:  selected ? 8 : 2)
        )
    })
    .background(Color(hex:StaticData.bg1_col[0]))
    .cornerRadius(0)
  }
}
//[Image Button]----------------------------------
struct ImageButtonNew: View {
  var image: Data
  var selected: Bool = false
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: {
      Image(uiImage: UIImage(data: image)!)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 0)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth:  selected ? 8 : 2)
        )
    })
    .background(Color(hex:StaticData.bg1_col[0]))
    .cornerRadius(0)
  }
}
//[Tiny Image Button]----------------------------------
struct TinyImageButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(width: 100, height: 100)
    })
    .background(Color(hex:StaticData.bg1_col[0]))
  }
}
struct TinyImageButtonNew: View {
  var image: Data
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: {
      Image(uiImage: UIImage(data: image)!)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(width: 100, height: 100)
    })
    .background(Color(hex:StaticData.bg1_col[0]))
  }
}
//[Massive Image Button]-------------------------------
struct MassiveImageButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    })
    .background(Color(hex:StaticData.bg1_col[0]))
  }
}
struct MassiveImageButtonNew: View {
  var image: Data
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: {
      Image(uiImage: UIImage(data: image)!)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    })
    .background(Color(hex:StaticData.bg1_col[0]))
  }
}
//[Submit Image Button]---------------------------------
struct ImageSubmitButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(systemName: image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 20.0, leading: 20.0, bottom: 20.0, trailing: 20.0))
        .frame(width: 80, height: 80)
        .foregroundColor(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]))
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(Color(hex:StaticData.text_col[GlobalVars.get().colorSet]), lineWidth: 2)
        )
    })
    .background(Color(hex:StaticData.confirm_col[GlobalVars.get().colorSet]))
    .cornerRadius(50)
  }
}
//[Login Button]---------------------------------
struct ColorButton: View {
  var text: String
  var set: Int
  var body: some View {
    Button(action: {
      GlobalVars.get().updateColor(colorSet: set)
    }, label: { Text(text)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[set]))
        .font(.system(size: 45, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 5)
          .stroke(Color(hex:StaticData.text_col[set]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.bg1_col[set]))
    .cornerRadius(5)
  }
}

//[Rename students]------------------------------------
struct StudentEditInput: View {
  var placeholder: String
  @Binding var text: String
  var body: some View {
    TextField(placeholder, text: $text)
      .environment(\.layoutDirection,.rightToLeft)
      .foregroundColor(Color(hex:StaticData.text_col[0]))
      .font(.system(size: 20, weight: .heavy))
      .frame(height: 40, alignment: .trailing)
      .frame(maxWidth: .infinity)
      .padding(.horizontal,6)
      .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
      )
      .background(Color(hex:StaticData.bg1_col[0]))
      .accessibilityIdentifier("studentnameinput")
  }
}
//[Save key]---------------------------------
struct PlainButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[0]))
        .font(.system(size: 25))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.bg1_col[0]))
    .cornerRadius(15)
  }
}
//[Text Button]---------------------------------
struct TextButton: View {
  var text: String
  var body: some View {
    Text(text)
      .frame(maxWidth: .infinity)
      .frame(maxHeight: .infinity)
      .foregroundColor(Color(hex:StaticData.text_col[0]))
      .font(.system(size: 25))
      .background(Color(hex:StaticData.bg1_col[0]))
      .cornerRadius(15)
      .overlay(RoundedRectangle(cornerRadius: 15)
        .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
      )
  }
}


//[Rename Images]------------------------------------
struct ImageEditInput: View {
  var placeholder: String
  @Binding var text: String
  var body: some View {
    TextField(placeholder, text: $text)
      .environment(\.layoutDirection,.rightToLeft)
      .foregroundColor(Color(hex:StaticData.text_col[0]))
      .font(.system(size: 20, weight: .heavy))
      .frame(height: 40, alignment: .trailing)
      .frame(maxWidth: .infinity)
      .padding(.horizontal,6)
      .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
      )
      .background(Color(hex:StaticData.bg1_col[0]))
      .accessibilityIdentifier("imagename")
  }
}
//[DeleteTeacher key]---------------------------------
struct DeleteTeacherButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .foregroundColor(Color(hex:StaticData.text_col[0]))
        .font(.system(size: 25))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:StaticData.delete_col[0]))
    .cornerRadius(15)
  }
}
struct ToggleBoard: View {
  var text: String
  @Binding var ison: Bool
  var onChange: (() -> Void)
  var body: some View {
    Toggle(isOn: $ison) {
      Text(text)
    }
    .onChange(of: ison, initial: ison){onChange()}
    .environment(\.layoutDirection,.rightToLeft)
    .frame(width: StaticData.screenwidth/6)
    .frame(maxHeight: .infinity)
    .font(.system(size: 25))
    .padding(.horizontal,10)
    .padding(.vertical, 5)
    .background(Color(hex:StaticData.bg2_col[0]))
  }
}

//[Board Picker for Images]
struct BoardPickerImages: View {
  var onChange: (() -> Void)
  @State var gVars = GlobalVars.get()
  @Binding var selectedBoard: String
  var body: some View {
    Picker(selection: $selectedBoard, label: Text("Picker")) {
      Text("קמץ").tag("a")
      Text("חיריק").tag("b")
      Text("סגול").tag("c")
      Text("חולם").tag("d")
      Text("עיצור").tag("e")
      Text("שורוק").tag("f")
    }
    .onChange(of: selectedBoard, initial: true){onChange()}
    .scaleEffect(1.5)
    .pickerStyle(.menu)
    .accentColor(Color(hex:StaticData.text_col[0]))
    .frame(height: 40, alignment: .center)
    .frame(maxWidth: .infinity)
    .background(Color(hex:StaticData.bg1_col[0]))
    .border(Color(hex:StaticData.text_col[0]))
    .accessibilityIdentifier("boardpicker")
  }
}
