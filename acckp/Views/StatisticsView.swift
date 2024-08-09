//
//  Statistics View
//

import SwiftUI
import SwiftData
import Charts

struct StatisticsView: View {
  @ObservedObject var gVars = GlobalVars.get()
  @State var students: [String] = []
  @State var stats: [dayStats] = []
  init () {
    if gVars.user_edit != nil {
      _students = State(wrappedValue: gVars.getStudents(add:false))
      _stats = State(wrappedValue: gVars.user_edit!.stats)
    }
  }
  var body: some View {
    //[Statistics container]-------------------
    VStack(spacing:20) {
      VStack() {
        Text("סטטיסטיקה לתלמיד")
          .lineLimit(1)
          .foregroundColor(Color(hex:StaticData.text_col[0]))
          .font(.system(size: 30, weight: .heavy))
          .padding(.top, 20.0)
        StudentPickerTeacher(array: students, onChange: {
          //print(gVars.student_edit)
          gVars.swapStudent(login: false)
          if gVars.user_edit != nil {
            stats = gVars.user_edit!.stats
          }
        })
        .frame(width: StaticData.screenwidth/3)
        //[Stats]------------------------------
        HStack {
          VStack(spacing: 13.0) {
            if stats.count > 0 {
              Table(stats) {
                TableColumn("תאריך") { stat in
                  Text(String(stat.day)).font(.system(size: 25))
                }
                TableColumn("סה״כ מילים") { stat in
                  Text(String(stat.total_words)).font(.system(size: 25))
                }
                TableColumn("מילים נכונות") { stat in
                  Text(String(stat.correct_words)).font(.system(size: 25))
                }
                TableColumn("סה״כ אותיות") { stat in
                  Text(String(stat.total_letters)).font(.system(size: 25))
                }
                TableColumn("שגיאות כתיב") { stat in
                  Text(String(stat.typos)).font(.system(size: 25))
                }
              }
              .environment(\.layoutDirection,.rightToLeft)
            }
            else {
              Text("לא נמצאו נתונים להצגה").font(.system(size: 25))
            }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .overlay(RoundedRectangle(cornerRadius: 15)
            .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
        }
        .padding(.all, 20)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(RoundedRectangle(cornerRadius: 15)
        .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
      //[Bottom row]---------------------------
      HStack() {
        HiddenButton().frame(maxWidth:.infinity)
        SettingsButton(image: "arrowshape.right", action: {
          gVars.screen = GlobalVars.screens.teacher})
      }
      .frame(height: StaticData.screenheight/9)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
    .background(Color(hex:StaticData.bg2_col[0]))
  }
}

#Preview {
  StatisticsView()
}
