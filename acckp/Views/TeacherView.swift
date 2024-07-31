//
//  Teacher View
//

import SwiftUI
import SwiftData

struct TeacherView: View {
  @ObservedObject var gVars = GlobalVars.get()
  @State var boards = StaticData.boards
  @State var NewName: String = ""
  @State var students: [String] = []
  @State var students_plain: [String] = []
  @State var students_new: [String] = []
  init () {
    if gVars.user_edit != nil {
      _boards = State(wrappedValue: gVars.user_edit!.boards)
      _students_plain = State(wrappedValue: gVars.getStudents(add:false))
      _students_new = State(wrappedValue: gVars.getStudents(add:true))
      _students = _students_plain
    }
  }
  var body: some View {
    //[Teacher container]----------------------
    VStack(spacing:20) {
      HStack (spacing: 15) {
        VStack(spacing: 15) {
          //[Adding students]------------------
          VStack(spacing:15) {
            Text("תלמידים")
              .lineLimit(1)
              .foregroundColor(.black)
              .font(.system(size: 25, weight: .heavy))
            StudentPickerTeacher(array: students_new, onChange: {
              if gVars.student_edit == GlobalVars.student_new {
                students = students_new
              }
              else {
                students = students_plain
              }
              gVars.swapStudent(login: false)
            })
            HStack(spacing:20) {
              StudentEditInput(placeholder: "הקלד שם...", text: $NewName)
              Text("שם:")
                .lineLimit(1)
                .foregroundColor(.black)
                .font(.system(size: 20, weight: .heavy))
            }
            HStack(spacing:10)
            {
              DeleteTeacherButton(text: "מחק", action: {})
              SaveButton(text: "שמור", action: {
                gVars.updateStudent(name: NewName)
                students_plain = gVars.getStudents(add:false)
                students_new = gVars.getStudents(add:true)
                students = students_plain
              })
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 2))
          //[Opening boards]-------------------
          VStack(spacing: 15) {
            Text("פתיחת לוחות")
              .lineLimit(1)
              .foregroundColor(.black)
              .font(.system(size: 25, weight: .heavy))
            StudentPickerTeacher(array: students, onChange: {
              //print(gVars.student_edit)
              gVars.swapStudent(login: false)
              if gVars.user_edit != nil {
                boards = gVars.user_edit!.boards
                print(boards)
              }
              else {
                boards = StaticData.boards
              }
            })
            VStack(spacing:0) {
              ForEach(StaticData.boardNames.indices, id:\.self) { index in
                ToggleBoard(text: "לוח " + StaticData.boardNames[index], ison: $boards[index], onChange: {
                  gVars.updateBoard(index: index, state: boards[index])
                })
              }
            }
          }
          .disabled(gVars.student_edit == GlobalVars.student_new)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .frame(minHeight: StaticData.screenheight * 0.5)
          .padding(.vertical, 10)
          .padding(.horizontal, 20)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 2))
        }
        .frame(maxWidth: StaticData.screenwidth/3, maxHeight: .infinity)
        //[Adding images]---------------------
        VStack() {
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(.black, lineWidth: 2))
      }
      //[Bottom row]--------------------------
      HStack() {
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
