//
//  Teacher View
//

import SwiftUI
import SwiftData

struct TeacherView: View {
  @EnvironmentObject var gVars: GlobalVars
  @State var NewName: String = ""
  @State var toggleBools: [Bool] = [false, false, false, false, false, false]
  var body: some View {
    VStack(spacing:20){
      HStack (spacing: 15) {
        VStack(spacing: 15){
          VStack(spacing: 15){
            Text("פתיחת לוחות")
              .lineLimit(1)
              .foregroundColor(.black)
              .font(.system(size: 20, weight: .heavy))
            StudentPickerTeacher(array: GlobalVars.getStudents(add:false), onChange: {
              print(gVars.student)}).environmentObject(gVars)
            VStack(spacing:0){
              ForEach(StaticData.boardNames.indices, id:\.self) { index in
                ToggleBoard(text: "לוח " + StaticData.boardNames[index], ison: $toggleBools[index], onChange: {})
                  
              }
            }
          }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .frame(minHeight: StaticData.screenheight * 0.5)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .overlay(RoundedRectangle(cornerRadius: 15)
              .stroke(.black, lineWidth: 2))
          VStack(spacing:15){
            Text("תלמידים")
              .lineLimit(1)
              .foregroundColor(.black)
              .font(.system(size: 20, weight: .heavy))
            StudentPickerTeacher(array: GlobalVars.getStudents(add:true), onChange: {
              print(gVars.student)}).environmentObject(gVars)
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
            .overlay(RoundedRectangle(cornerRadius: 15)
              .stroke(.black, lineWidth: 2))
        }
        .frame(maxWidth: StaticData.screenwidth/3, maxHeight: .infinity)
        VStack(){
        }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 2))
      }
      HStack(){
        HiddenButton().frame(maxWidth:.infinity)
        SettingsButton(image: "arrowshape.right", action: {
          gVars.screen = GlobalVars.screens.main})
      }
        .frame(height: StaticData.screenheight/9)
    }
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
    .background(Color(uiColor:UIColor.systemGray5))
  }
}

#Preview {
  TeacherView().environmentObject(GlobalVars())
}
