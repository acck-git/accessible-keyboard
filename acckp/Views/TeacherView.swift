//
//  Teacher View
//

import SwiftUI
import SwiftData

struct TeacherView: View {
  @ObservedObject var gVars = GlobalVars.get()
  @State var boards = StaticData.boards
  @State var NewName: String = ""
  init () {
    if gVars.user_edit != nil {
      _boards = State(wrappedValue: gVars.user_edit!.boards)
    }
  }
  var body: some View {
    //[Teacher container]----------------------
    VStack(spacing:20){
      HStack (spacing: 15) {
        VStack(spacing: 15){
          //[Adding students]------------------
          VStack(spacing:15){
            Text("תלמידים")
              .lineLimit(1)
              .foregroundColor(.black)
              .font(.system(size: 25, weight: .heavy))
            StudentPickerTeacher(array: gVars.getStudents(add:true), onChange: {
              print(gVars.student)})
            HStack(spacing:20){
              StudentEditInput(placeholder: "הקלד שם...", text: $NewName)
              Text("שם:")
                .lineLimit(1)
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .heavy))
            }
            HStack(spacing:10)
            {
              DeleteTeacherButton(text: "מחק", action: {})
              SaveButton(text: "שמור", action: {})
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
          .hidden()
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 2))
          //[Opening boards]-------------------
          VStack(spacing: 15){
            Text("פתיחת לוחות")
              .lineLimit(1)
              .foregroundColor(.black)
              .font(.system(size: 25, weight: .heavy))
            StudentPickerTeacher(array: gVars.getStudents(add:false), onChange: {
              print(gVars.student)})
            VStack(spacing:0){
              ForEach(StaticData.boardNames.indices, id:\.self) { index in
                ToggleBoard(text: "לוח " + StaticData.boardNames[index], ison: $boards[index], onChange: {
                  gVars.updateBoard(index: index, state: boards[index])
                })
              }
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .frame(minHeight: StaticData.screenheight * 0.5)
          .padding(.vertical, 10)
          .padding(.horizontal, 20)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 2))
        }
        .frame(maxWidth: StaticData.screenwidth/3, maxHeight: .infinity)
        //[Adding images]---------------------
        VStack(){
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2))
      }
      //[Bottom row]--------------------------
      HStack(){
        SaveButton(text: "סטטיסטיקת תלמידים", action: {
          gVars.screen = GlobalVars.screens.stats
        })
        .frame(width: StaticData.screenwidth/3)
        HiddenButton().frame(maxWidth:.infinity)
        SettingsButton(image: "arrowshape.right", action: {
          gVars.screen = GlobalVars.screens.settings})
      }
      .frame(height: StaticData.screenheight/9)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
    .background(Color(uiColor:UIColor.systemGray5))
  }
}

#Preview {
  TeacherView()
}
