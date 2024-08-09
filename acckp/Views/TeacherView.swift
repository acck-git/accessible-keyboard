//
//  Teacher View
//

import SwiftUI
import SwiftData

struct TeacherView: View {
  @Environment(\.modelContext) private var ModelContext
  @ObservedObject var gVars = GlobalVars.get()
  //[User names]-------------------------------
  @FocusState var textFieldFocus: Bool
  @State var newName: String = ""
  @State var alert: Bool = false
  @State var alertMessage = ""
  @State var confirm: Bool = false
  //[User boards]------------------------------
  @FocusState var pickerFieldFocus: Bool
  @State var boards = StaticData.boards
  //[Piker]------------------------------------
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
              .foregroundColor(Color(hex:StaticData.text_col[0]))
              .font(.system(size: 25, weight: .heavy))
            StudentPickerTeacher(array: students_new, onChange: {
              if gVars.student_edit == GlobalVars.student_new {
                students = students_new
              }
              else {
                students = students_plain
              }
              gVars.swapStudent(login: false)
            }).focused($pickerFieldFocus)
            
            HStack(spacing:10) {
              StudentEditInput(placeholder: "הקלד שם...", text: $newName)
                .focused($textFieldFocus)
              Text("שם חדש:")
                .lineLimit(1)
                .foregroundColor(Color(hex:StaticData.text_col[0]))
                .font(.system(size: 20, weight: .heavy))
            }
            HStack(spacing:10) {
              if gVars.student_edit != GlobalVars.student_new {
                DeleteTeacherButton(text: "מחק", action: {
                  deleteUser()
                  confirm = true
                  newName = ""
                  textFieldFocus = false
                })
                .confirmationDialog("לא ניתן לבטל פעולה זו. המשך?", isPresented: $confirm) {
                  Button("מחק", role: .destructive) {
                    deleteUser()
                    confirm = false
                  }} message: {
                    Text("לא ניתן לבטל פעולה זו. המשך?")
                  }
              }
              SaveButton(text: "שמור", action: {
                if addUser() {
                  newName = ""
                  textFieldFocus = false
                }
              })
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .padding(.horizontal, 20)
          .padding(.vertical, 10)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
          //[Opening boards]-------------------
          VStack(spacing: 15) {
            Text("פתיחת לוחות")
              .lineLimit(1)
              .foregroundColor(Color(hex:StaticData.text_col[0]))
              .font(.system(size: 25, weight: .heavy))
            StudentPickerTeacher(array: students, onChange: {
              //print(gVars.student_edit)
              gVars.swapStudent(login: false)
              boards = gVars.user_edit != nil ? gVars.user_edit!.boards : StaticData.boards
              //print(boards)
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
            .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
        }
        .frame(maxWidth: StaticData.screenwidth/3, maxHeight: .infinity)
        //[Adding images]---------------------
        VStack() {
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
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
    .onChange(of: pickerFieldFocus) {
      print(pickerFieldFocus)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
    .background(Color(hex:StaticData.bg2_col[0]))
    .alert(alertMessage, isPresented: $alert, actions: {})
  }
  //[Add user to database]------------
  @MainActor private func addUser() -> Bool {
    //Rename/add new
    var user: UserData?
    var clearField = false
    (user,alertMessage,clearField) = gVars.updateStudent(name: newName)
    //Add new
    if user != nil {
      ModelContext.insert(user!)
      //try ModelContext.save()
      user!.printUser()
      print("Created user \(user!.student).")
    }
    if (clearField) {
      students_plain = gVars.getStudents(add:false)
      students_new = gVars.getStudents(add:true)
      students = students_plain
    }
    if alertMessage != "" { alert = true }
    return clearField
  }
  //[Delete user from database]------------
  @MainActor private func deleteUser() {
    if !confirm { return }
    let (user_del,def_user) = gVars.deleteStudent()
    if user_del != nil {
      ModelContext.delete(user_del!)
      //try ModelContext.save()
      print("Deleted user")
    }
    if def_user != nil {
      ModelContext.insert(def_user!)
      //try ModelContext.save()
      def_user!.printUser()
      print("Created user \(def_user!.student).")
    }
    students_plain = gVars.getStudents(add:false)
    students_new = gVars.getStudents(add:true)
    students = students_plain
  }
}

#Preview {
  TeacherView()
}
