//
//  Teacher View
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
  @ObservedObject var gVars = GlobalVars.get()
  var stats: [dayStats] = []
  init () {
    if gVars.user != nil {
      stats = gVars.user!.stats
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
          .padding(.top, 20.0)
        StudentPickerTeacher(array: gVars.getStudents(add:false), onChange: {
          print(gVars.student)
        })
        .frame(width: StaticData.screenwidth/3)
        HStack {
          VStack(spacing: 13.0) {
            if stats.count > 0 {
              Table(stats) {
                TableColumn("שגיאות כתיב") { stat in
                  Text(String((stat.typos/stat.total_letters)*100)+"%").font(.system(size: 25))
                }
                TableColumn("סה״כ אותיות") { stat in
                  Text(String(stat.total_letters)).font(.system(size: 25))
                }
                
                TableColumn("מילים נכונות") { stat in
                  Text(String((stat.correct_words/stat.total_words)*100)+"%").font(.system(size: 25))
                }
                TableColumn("סה״כ מילים") { stat in
                  Text(String(stat.total_words)).font(.system(size: 25))
                }
                TableColumn("תאריך") { stat in
                  Text(String(stat.day)).font(.system(size: 25))
                }
              }
            }
            else {
              Text("לא נמצאו נתונים להצגה").font(.system(size: 25))
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(.black, lineWidth: 2))
        }
        .padding(.all, 20)
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
