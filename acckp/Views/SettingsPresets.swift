//
//  Designs for settings view
//

import SwiftUI

//[Login Button]---------------------------------
struct TeacherLoginButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(width: 155, height: 80)
        .foregroundColor(.black)
        .font(.system(size: 30, weight: .heavy))
        .overlay(RoundedRectangle(cornerRadius: 5)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(.white)
    .cornerRadius(5)
  }
}
//[Login Field]---------------------------------
struct TeacherLoginInput: View {
  var placeholder: String
  @Binding var text: String
  var body: some View {
    SecureField(placeholder, text: $text)
      .foregroundColor(.black)
      .font(.system(size: 35, weight: .heavy))
      .frame(width: 300, height: 80, alignment: .trailing)
      .padding(.horizontal,6)
      .environment(\.layoutDirection,.rightToLeft)
      .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
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
    .accentColor(.black)
    .frame(width: 400, height: 80, alignment: .center)
    .border(Color.black)
  }
}
//[Student Picker Teacher]---------------------------------
struct StudentPickerTeacher: View {
  var array: [String]
  var onChange: (() -> Void)
  @State var gVars = GlobalVars.get()
  var body: some View {
    Picker(selection: $gVars.student_edit, label: Text("Picker")) {
      ForEach(array, id:\.self) {
        Text($0)
          .font(.largeTitle)
      }
    }
    .onChange(of: gVars.student_edit, initial: true){onChange()}
    .scaleEffect(1.5)
    .pickerStyle(.menu)
    .accentColor(.black)
    .frame(height: 40, alignment: .center)
    .frame(maxWidth: .infinity)
    .background(Color.white)
    .border(Color.black)
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
        .foregroundColor(.black)
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(uiColor:UIColor.systemGray5))
    .cornerRadius(50)
  }
}
//[Image Button]----------------------------------
struct ImageButton: View {
  var image: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Image(image)
        .resizable()
        .scaledToFit()
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 0)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(.white)
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
    .background(.white)
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
    .background(.white)
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
        .foregroundColor(.black)
        .overlay(RoundedRectangle(cornerRadius: 50)
          .stroke(.black, lineWidth: 2)
        )
    })
    .background(Color(hex:0x65C466))
    .cornerRadius(50)
  }
}
struct StudentEditInput: View {
  var placeholder: String
  @Binding var text: String
  var body: some View {
    TextField(placeholder, text: $text)
      .environment(\.layoutDirection,.rightToLeft)
      .foregroundColor(.black)
      .font(.system(size: 20, weight: .heavy))
      .frame(height: 40, alignment: .trailing)
      .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
      .padding(.horizontal,6)
      .overlay(RoundedRectangle(cornerRadius: 5)
        .stroke(.black, lineWidth: 2)
      )
      .background(Color(.white))
  }
}
//[Save key]---------------------------------
struct SaveButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(maxHeight: .infinity)
        .foregroundColor(.black)
        .font(.system(size: 25))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(.white))
    .cornerRadius(15)
  }
}
//[DeleteTeacher key]---------------------------------
struct DeleteTeacherButton: View {
  var text: String
  var action: (() -> Void)
  var body: some View {
    Button(action: action, label: { Text(text)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .frame(maxHeight: .infinity)
        .foregroundColor(.black)
        .font(.system(size: 25))
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2)
        )
    })
    .buttonRepeatBehavior(.enabled)
    .background(Color(hex:0xFF766E))
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
    .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    .font(.system(size: 25))
    //.frame(minHeight: 30)
    .padding(.horizontal,10)
    .padding(.vertical, 5)
    .background(Color(.systemGray6))
  }
}

//------------------------------------------------
//preview stuff
struct SettingsPresetsPreview: View {
  var body: some View {
    VStack {
      //TeacherLoginButton(text: "כניסת מורה", action: {})
      //ArrowButton(image:"arrowtriangle.left.fill",action: {})
      //ImageButton(image:"a1", action: {})
      //TinyImageButton(image:"a1", action: {})
      //ImageSubmitButton(image: "checkmark", action: {})
      StudentPicker(array: ["one","two"], onChange: {})
      StudentPickerTeacher(array: ["one","two"], onChange: {})
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, -22.0)
    //.overlay(MassiveImageButton(image: "a1", action: {}))
  }
}
#Preview {
  SettingsPresetsPreview()
}
