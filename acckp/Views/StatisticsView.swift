//
//  Teacher View
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
  @StateObject var gVars = GlobalVars.get()
  @State var stats: [dayStats] = []
  var body: some View {
    VStack(spacing:20){
      VStack(){
        Text("סטטיסטיקה לתלמיד")
          .lineLimit(1)
          .foregroundColor(.black)
          .font(.system(size: 30, weight: .heavy))
        StudentPickerTeacher(array: GlobalVars.getStudents(add:false), onChange: {
          stats = gVars.getStats()
          print(gVars.student)
        }).environmentObject(gVars)
          .frame(width: StaticData.screenwidth/3)
        
        Chart(stats) { stat in
          BarMark(x: .value("Type", stat.day),
                  y: .value("Total Words", stat.total_words))
          .foregroundStyle(.blue)
          .offset(x: 10)
          
          BarMark(x: .value("Type", ""),
                  y: .value("Correct Words", stat.correct_words))
          .foregroundStyle(.red)
          .offset(x: -10)
        }
        .aspectRatio(1, contentMode: .fit)
        .padding()
        
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
