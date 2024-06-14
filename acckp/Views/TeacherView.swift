//
//  Teacher View
//

import SwiftUI
import SwiftData

struct TeacherView: View {
  @EnvironmentObject var gVars: GlobalVars
  @State var NewName: String = ""
  var body: some View {
    VStack(){
      HStack (spacing: 15) {
        VStack(spacing: 15){
          VStack(){}
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(RoundedRectangle(cornerRadius: 15)
              .stroke(.black, lineWidth: 2))
          VStack(){
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
            
            
          }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
