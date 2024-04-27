//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct SettingsView: View {
  @EnvironmentObject var gVars: GlobalVars
  //login
  @State var login: Bool = false
  @State var pass: String = ""
  //images
  @State var set: String = "a"
  @State var subSet: Int = 0
  var vowelsRow: [String] = Keys.vowelsRow.reversed()
  var sets: [String] = Images.sets
  var body: some View {
    //[Top line container]---------------------
    VStack(spacing: 0.0){
      HStack(spacing: 10) {
        TeacherLoginButton(text: "כניסת מורה", action: {
          if login == false { login = true }
          else { gVars.checkPass(pass: pass) }
        })
        if login {
          TeacherLoginInput(placeholder: "הקלד סיסמה...", text: $pass)
        }
        HiddenButton().frame(maxWidth: .infinity)
        StudentPicker(array: GlobalVars.getStudents(), onChange: {
          print(gVars.student)}).environmentObject(gVars)
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
      .padding(.vertical, 20.0)
      .frame(maxWidth: .infinity, maxHeight: 123)
      
      //---------------------
      Divider()
        .frame(height: 5.0)
        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .overlay(.black)
      //------------------
      VStack(spacing: 20){
        HStack(spacing: 10){
          ArrowButton(image: "arrowtriangle.left.fill",action: {
            subSet = subSet+6 > 6 ? 0 : subSet+6
          })
          VStack(spacing:20){
            HStack(spacing: 20){
              ForEach((1...3).reversed(), id: \.self){ i in
                ImageButton(image: set+String(subSet+i), action: {
                  gVars.image = set+String(subSet+i)
                  gVars.screen = GlobalVars.screens.main
                  gVars.inputText = ""
                })
              }
            }
            HStack(spacing: 20){
              ForEach((4...6).reversed(), id: \.self){ i in
                ImageButton(image: set+String(subSet+i), action: {
                  gVars.image = set+String(subSet+i)
                  gVars.screen = GlobalVars.screens.main
                  gVars.inputText = ""
                })
              }
            }
          }
          ArrowButton(image: "arrowtriangle.right.fill",action: {
            subSet = subSet-6 < 0 ? 6 : subSet-6
          })
        }
        HStack(spacing: 10.0) {
          ForEach(vowelsRow.indices, id:\.self) { index in
            VowelButton(image: vowelsRow[index], action: {
              set = sets[vowelsRow.count - index - 1]
              subSet = 0
            })
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: 823)
        HStack(spacing:13){
          HiddenButton().frame(maxWidth:.infinity)
          SettingsButton(image: "arrowshape.right", action: {
            gVars.screen = GlobalVars.screens.main})
        }.padding(.horizontal,15)
      }
      .frame(maxWidth:.infinity,maxHeight:.infinity)
      .background(Color(uiColor:UIColor.systemGray5))
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, -22.0)
    .ignoresSafeArea(.keyboard)
  }
}

#Preview {
  SettingsView().environmentObject(GlobalVars())
}
