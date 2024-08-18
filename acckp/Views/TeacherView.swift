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
  @State var boards = StaticData.boards
  @State var boardNames = StaticData.boardNames
  //[Piker]------------------------------------
  @State var students: [String] = []
  @State var students_plain: [String] = []
  @State var students_new: [String] = []
  //[Images]-----------------------------------
  @State var set: String = "a"
  @State var subSet: Int = 0
  @State var newImageName: String = ""
  @State var confirmImage: Bool = false
  var sets: [String] = StaticData.sets
  //-------------------
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
              else { students = students_plain }
              gVars.swapStudent(login: false)
            })
            //-------------------
            HStack(spacing:10) {
              StudentEditInput(placeholder: "הקלד שם...", text: $newName)
                .focused($textFieldFocus)
              Text("שם חדש:")
                .lineLimit(1)
                .foregroundColor(Color(hex:StaticData.text_col[0]))
                .font(.system(size: 20, weight: .heavy))
            }
            //-------------------
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
              //-------------------
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
              gVars.swapStudent(login: false)
              boards = gVars.user_edit != nil ? gVars.user_edit!.boards : StaticData.boards
            })
            //-------------------
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
        VStack(spacing:20){
          Text("מאגר תמונות")
            .lineLimit(1)
            .foregroundColor(Color(hex:StaticData.text_col[0]))
            .font(.system(size: 25, weight: .heavy))
          //-------------------
          HStack(spacing: 15) {
            //-------------------
            DeleteTeacherButton(text: "מחק", action: {
            })
            .confirmationDialog("לא ניתן לבטל פעולה זו. המשך?", isPresented: $confirmImage) {
              Button("מחק", role: .destructive) {
                
              }} message: {
                Text("לא ניתן לבטל פעולה זו. המשך?")
              }
            //-------------------
            SaveButton(text: "שמור", action: {
              
            })
            //temp
            //-------------------
            ImageEditInput(placeholder: "", text: $newImageName)
              .focused($textFieldFocus)
            //----
            Text("תיאור:")
              .lineLimit(1)
              .foregroundColor(Color(hex:StaticData.text_col[0]))
              .font(.system(size: 20, weight: .heavy))
            //-------------------
            //temp
            BoardPickerImages(array: boardNames, onChange: {
            },selectedBoard: $set)
            //----
            Text("לוח:")
              .lineLimit(1)
              .foregroundColor(Color(hex:StaticData.text_col[0]))
              .font(.system(size: 20, weight: .heavy))
          }.frame(height: 50)
          HStack{
            ArrowButtonSmall(image: "arrowtriangle.left.fill",action: {
              subSet = subSet+6 > 6 ? 0 : subSet+6
            })
            VStack(spacing:20) {
              HStack(spacing: 20) {
                ForEach((1...3).reversed(), id: \.self) { i in
                  ImageButton(image: set+String(subSet+i), action: {
                    newImageName = StaticData.imgDesc[set+String(subSet+i)] != nil ? StaticData.imgDesc[set+String(subSet+i)]! : ""
                  })
                }
              }
              HStack(spacing: 20) {
                ForEach((4...6).reversed(), id: \.self) { i in
                  ImageButton(image: set+String(subSet+i), action: {
                    newImageName = StaticData.imgDesc[set+String(subSet+i)] != nil ? StaticData.imgDesc[set+String(subSet+i)]! : ""
                  })
                }
              }
            }
            //.frame(maxHeight: .infinity)
            .padding(.horizontal, 20)
            ArrowButtonSmall(image: "arrowtriangle.right.fill",action: {
              subSet = subSet-6 < 0 ? 6 : subSet-6
            })
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
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
    //Add new if relevant
    if user != nil {
      ModelContext.insert(user!)
      //try ModelContext.save()
      print("Created user \(user!.student).")
    }
    if (clearField) {
      students_plain = gVars.getStudents(add:false)
      students_new = gVars.getStudents(add:true)
      students = students_plain
    }
    //Popup message
    if alertMessage != "" { alert = true }
    return clearField
  }
  //[Delete user from database]------------
  @MainActor private func deleteUser() {
    if !confirm { return }
    let (user_del,def_user) = gVars.deleteStudent()
    //Delete user if valid
    if user_del != nil {
      ModelContext.delete(user_del!)
      //try ModelContext.save()
      print("Deleted user")
    }
    //Create default user if needed
    if def_user != nil {
      ModelContext.insert(def_user!)
      //try ModelContext.save()
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
