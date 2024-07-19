//
//  Teacher View
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
  @ObservedObject var gVars = GlobalVars.get()
  @State var stats: [dayStats] = []
  init () {
    if gVars.user != nil {
      _stats = State(wrappedValue: gVars.user!.stats)
      print("not nil")
    }
    print(stats)
    print("teach")
  }
  var body: some View {
    VStack(spacing:20){
      VStack(){
        Text("סטטיסטיקה לתלמיד")
          .lineLimit(1)
          .foregroundColor(.black)
          .font(.system(size: 30, weight: .heavy))
        StudentPickerTeacher(array: GlobalVars.getStudents(add:false), onChange: {
          print(gVars.student)
        })
          .frame(width: StaticData.screenwidth/3)
        
        
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(RoundedRectangle(cornerRadius: 15)
        .stroke(.black, lineWidth: 2))
      
      
      HStack(){
        HiddenButton().frame(maxWidth:.infinity)
        SettingsButton(image: "arrowshape.right", action: {
          gVars.screen = GlobalVars.screens.teacher})
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
  StatisticsView()
}
