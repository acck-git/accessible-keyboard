//
//  Top line sub view
//

import SwiftUI
import SwiftData

struct SettingsView: View {
  @ObservedObject var gVars = GlobalVars.get()
  var boards: [Bool] = StaticData.boards
  //login
  @State var login: Bool = false
  @State var pass: String = ""
  @State var alert: Bool = false
  @State var alertMessage = ""
  @State var json:Data = Data()
  //images
  @State var set: String = "a"
  @State var subSet: Int = 0
  var vowelsRow: [String] = StaticData.vowelsRow.reversed()
  var sets: [String] = StaticData.sets
  init () {
    if gVars.user != nil { boards = gVars.user!.boards }
  }
  var body: some View {
    if !json.isEmpty {
      ShareLink(
          "Save File",
          item: json,
          preview: SharePreview("title.json")
      )
    }
    //[Settings container]---------------------
    VStack(spacing: 0.0){
      HStack(spacing: 10) {
        TeacherLoginButton(text: "כניסת מורה", action: {
          gVars.screen = GlobalVars.screens.stats
          /*if login == false { login = true }
          else {
            (login,alertMessage,json) = gVars.checkPass(pass: pass)
            if alertMessage != "" { alert = true }
            
            pass = ""
          }*/
        })
        if login {
          TeacherLoginInput(placeholder: "הקלד סיסמה...", text: $pass)
        }
        HiddenButton().frame(maxWidth: .infinity)
        StudentPicker(array: gVars.getStudents(add:false), onChange: {
          print(gVars.student)})
      }
      .frame(maxWidth: .infinity)
      .frame(height: StaticData.screenheight * (1/7))
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
      .padding(.vertical, 0.0)
      
      //-----------------------
      Divider()
        .frame(height: 5.0)
        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .overlay(.black)
      //-----------------------
      VStack(spacing: 20){
        HStack(spacing: 20){
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
          .frame(maxHeight: .infinity)
          ArrowButton(image: "arrowtriangle.right.fill",action: {
            subSet = subSet-6 < 0 ? 6 : subSet-6
          })
        }
        HStack(spacing: 10.0) {
          ForEach(vowelsRow.indices, id:\.self) { index in
            VowelButton(image: vowelsRow[index], action: {
              set = sets[vowelsRow.count - index - 1]
              subSet = 0
            }, enabled: boards[vowelsRow.count - index - 1])
          }
        }
        .frame(height: StaticData.screenheight * 1/9)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20.0)
        HStack(){
          HiddenButton().frame(maxWidth:.infinity)
          SettingsButton(image: "arrowshape.right", action: {
            gVars.screen = GlobalVars.screens.main})
        }
          .frame(height: StaticData.screenheight/9)
      }
      .frame(maxWidth:.infinity,maxHeight:.infinity)
      .padding(.top, 20)
      .padding(.bottom, 10)
      .padding(.horizontal, 20)
      .background(Color(uiColor:UIColor.systemGray5))
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .ignoresSafeArea(.keyboard)
    .alert(alertMessage, isPresented: $alert, actions: {})
  }
}



#Preview {
  SettingsView()
}
