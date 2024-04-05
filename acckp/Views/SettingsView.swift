//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct SettingsView: View {
  @EnvironmentObject var gVars: GlobalVars
  var students: [String] = ["תלמיד"]
  @State var index: Int = 0
  @State var set: String = "b"
  @State var login: Bool = false
  @State var pass: String = ""
  var temppass: String = "pass"
  var vowelsRow: [String] = Keys.vowelsRow.reversed()
  var body: some View {
    //[Top line container]---------------------
    VStack(spacing: 0.0){
      HStack(spacing: 10) {
        TeacherLoginButton(text: "כניסת מורה", action: {
          if login == false{
            login = true
          }
          else{
            if pass == temppass{
              print("success!")
            }
            else{
              print("wrong password")
            }
          }
        })
        if login{
          SecureField("הקלד סיסמה...", text: $pass)
            .foregroundColor(.black)
            .font(.system(size: 35, weight: .heavy))
            .frame(width: 300, height: 80, alignment:.trailing)
            .padding(.horizontal,6)
            .environment(\.layoutDirection,.rightToLeft)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
        }
        HiddenButton()
          .frame(maxWidth:.infinity)
        StudentPicker(array: students, onChange:{
          print(gVars.student)}).environmentObject(gVars).disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
      .padding(.vertical, 20.0)
      .frame(maxWidth:.infinity, maxHeight: 123)
      
      //---------------------
      Divider()
        .frame(height: 5.0)
        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .overlay(.black)
      //------------------
      VStack(spacing: 20){
        HStack(spacing: 10){
          ArrowButton(image: "arrowtriangle.left.fill",action: {
            index += 6
            if index > 6{
              index = 0
            }
          })
          VStack(spacing:20){
            HStack(spacing: 20){
              ForEach((1...3).reversed(), id: \.self){ i in
                ImageButton(image: set+String(index+i), action: {})
              }
            }
            HStack(spacing: 20){
              ForEach((4...6).reversed(), id: \.self){ i in
                ImageButton(image: set+String(index+i), action:{})
              }
            }
          }
          ArrowButton(image: "arrowtriangle.right.fill",action: {
            index -= 6
            if index < 0{
              index = 6
            }
          })
        }
        HStack(spacing: 10.0) {
          ForEach(vowelsRow.indices, id:\.self) { index in
            LYellowButton(text: vowelsRow[index], action: {
              gVars.board = vowelsRow.count - index - 1
            })
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: 823)
        HStack(spacing:13){
          HiddenButton()
            .frame(maxWidth:.infinity)
          LBlueImageButton(image: "arrowshape.right", action: {
            gVars.screen = 0})
        }.padding(.horizontal,15)
      }
      .frame(maxWidth:.infinity,maxHeight:.infinity)
      .background(Color(uiColor:UIColor.systemGray5))
    }
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity
    )
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, -22.0)
    .ignoresSafeArea(.keyboard)
  }
}

#Preview {
  SettingsView().environmentObject(GlobalVars())
}
