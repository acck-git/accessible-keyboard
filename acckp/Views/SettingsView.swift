//
//  Settings view
//

import SwiftUI
import SwiftData

struct SettingsView: View {
  @ObservedObject var gVars = GlobalVars.get()
  var boards: [Bool] = StaticData.boards
  @State var students: [String] = []
  //[Login]------------------------------------
  @State var login: Bool = false
  @State var pass: String = ""
  @State var alert: Bool = false
  @State var alertMessage = ""
  @State var json:Data = Data()
  //[Images]-----------------------------------
  @State var set: String = "a"
  @State var currboard: [imageInfo] = StaticData.imgDesc1
  @State var tempboard: [imageInfo] = []
  @State var subSet: Int = 0
  var NilData = Data()
  var vowelsRow: [[String]] = StaticData.vowelsRow.reversed()
  var sets: [String] = StaticData.sets
  init () {
    if gVars.user != nil {
      boards = gVars.user!.boards
      _students = State(wrappedValue: gVars.getStudents(add:false))
    }
    if gVars.images != nil {
      _currboard = State(wrappedValue: gVars.imageBoard1)
    }
    _tempboard = State(wrappedValue: Array(currboard[0..<6]))
  }
  var body: some View {
    if !json.isEmpty {
      ShareLink("Save File",item: json,
                preview: SharePreview("title.json")
      )
    }
    //[Settings container]---------------------
    VStack(spacing: 0.0) {
      HStack(spacing: 10) {
        TeacherLoginButton(text: "כניסת מורה", action: {
          if login == false { login = true }
          else {
            (login,alertMessage,json) = gVars.checkPass(pass: pass)
            if alertMessage != "" { alert = true }
            pass = ""
          }
        })
        if login {
          TeacherLoginInput(placeholder: "הקלד סיסמה...", text: $pass)
            .accessibilityLabel("password")
        }
        HiddenButton().frame(maxWidth: .infinity)
        StudentPicker(array: students, onChange: {
          gVars.swapStudent(login: true)
          set = "a"
          subSet = 0
        })
      }
      .frame(maxWidth: .infinity)
      .frame(height: StaticData.screenheight * (1/7))
      .padding(.horizontal, 20.0)
      .padding(.vertical, 0.0)
      .background(Color(hex:StaticData.bg1_col[gVars.colorSet]))
      //-----------------------
      Divider()
        .frame(height: 5.0)
        .foregroundColor(Color(hex:StaticData.text_col[gVars.colorSet]))
        .overlay(Color(hex:StaticData.text_col[gVars.colorSet]))
      //-----------------------
      VStack(spacing: 20) {
        //[Images container]---------------------
        HStack(spacing: 20) {
          ArrowButton(image: "arrowtriangle.left.fill",action: {
            subSet = subSet+6 >= currboard.count ? 0 : subSet+6
            tempboard = Array(currboard.suffix(currboard.count - subSet).prefix(6))
          })
          .accessibilityIdentifier("leftarrow")
          //-------------------
          VStack(spacing:20) {
            HStack(spacing: 20) {
              ForEach((0..<3).reversed(), id: \.self) { i in
                if i < tempboard.count {
                  if tempboard[i].image != NilData{
                    ImageButtonNew(image: tempboard[i].image!, action: {
                      gVars.image = tempboard[i]
                      gVars.screen = GlobalVars.screens.main
                      gVars.inputText = ""
                    })
                  }
                  else {
                    ImageButton(image: tempboard[i].key, action: {
                      gVars.image = tempboard[i]
                      gVars.screen = GlobalVars.screens.main
                      gVars.inputText = ""
                    })
                  }
                }
                else{
                  HStack{}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(Color.black)
                }
              }
            }
            HStack(spacing: 20) {
              ForEach((3..<6).reversed(), id: \.self) { i in
                if i < tempboard.count {
                  if tempboard[i].image != NilData{
                    ImageButtonNew(image: tempboard[i].image!, action: {
                      gVars.image = tempboard[i]
                      gVars.screen = GlobalVars.screens.main
                      gVars.inputText = ""
                    })
                  }
                  else {
                    ImageButton(image: tempboard[i].key, action: {
                      gVars.image = tempboard[i]
                      gVars.screen = GlobalVars.screens.main
                      gVars.inputText = ""
                    })
                  }
                }
                else{
                  HStack{}
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(Color.black)
                }
              }
            }
          }
          .frame(maxHeight: .infinity)
          //-------------------
          ArrowButton(image: "arrowtriangle.right.fill",action: {
            if subSet-6 < 0 {
              subSet = currboard.count - ((currboard.count)%6)
              if subSet == currboard.count {
                subSet = currboard.count - 6
              }
            }
            else { subSet -= 6 }
            tempboard = Array(currboard.suffix(currboard.count - subSet).prefix(6))
          })
        }
        //[Board buttons]--------------------------------
        HStack(spacing: 10.0) {
          ForEach(vowelsRow.indices, id:\.self) { index in
            VowelButton(image: vowelsRow[index][gVars.colorSet], action: {
              subSet = 0
              set = sets[vowelsRow.count - index - 1]
              currboard = gVars.fetchImages(set: set)
              tempboard = Array(currboard.prefix(6))
            }, enabled: boards[vowelsRow.count - index - 1], selected: sets[vowelsRow.count - index - 1] == set)
          }
        }
        .frame(height: StaticData.screenheight * 1/9)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 20.0)
        //[Bottom row]---------------------------
        HStack(spacing: 20) {
          ColorButton(text: "טֶקסט", set: 3)
          ColorButton(text: "טֶקסט", set: 2)
          ColorButton(text: "טֶקסט", set: 1)
          ColorButton(text: "טֶקסט", set: 0)
          SettingsButton(image: "arrowshape.right", action: {
            gVars.screen = GlobalVars.screens.main
          })
        }
        .frame(height: StaticData.screenheight/9)
      }
      .frame(maxWidth:.infinity,maxHeight:.infinity)
      .padding(.top, 20)
      .padding(.bottom, 10)
      .padding(.horizontal, 20)
      .background(Color(hex:StaticData.bg2_col[gVars.colorSet]))
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.horizontal, 0.0)
    .ignoresSafeArea(.keyboard)
    .alert(alertMessage, isPresented: $alert, actions: {})
  }
}

#Preview {
  SettingsView()
}
