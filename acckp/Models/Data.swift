//
//  Global variables and functions
//

import Foundation

class GlobalVars: ObservableObject {
  //[App States]---------------------------------
  enum screens {case main, settings, teacher}
  @Published var screen: screens
  @Published var board: Int
  @Published var inputText: String
  @Published var student: String
  @Published var image: String
  @Published var imageZoom: Bool = false
  var example = "טֶקסט לֶהָמחָשָה"
  //default values
  init(board: Int = 0, inputText: String = "", screen: screens = screens.main, student: String = student_def, image: String = ""){
    self.board = board
    self.inputText = inputText
    self.screen = screen
    self.student = student
    self.image = image
  }
  
  //[Teacher Login]-------------------------------
  var temppass: [String] = ["pass","teach", "dev"]
  func checkPass(pass: String){
    switch temppass.firstIndex(of: pass){
    case 0: print("correct password")
    case 1: screen = screens.teacher
    default:
      screen = screen
      print("wrong password")
    }
  }
  //[Student Login]-------------------------------
  static var student_def = "תלמיד"
  static func getStudents() -> [String]{
    //will load existing students in the future
    return [student_def]
  }
}
//[Images data]----------------------------------
final class Images{
  static let sets = ["a","b","c","d","e","f"]
  static let imgDesc = [
    "a1":"מָתָנָה"
  ]
  static func checkSpelling(gVars: GlobalVars){
    var expected = imgDesc[gVars.image]!
    var recieved = gVars.inputText
    let length = max(expected.count,recieved.count)
    expected += String(repeating: "*", count: length - expected.count)
    recieved += String(repeating: "*", count: length - recieved.count)
    print(expected)
    print(recieved)
    let typos = zip(Array(expected),Array(recieved)).filter{$0 != $1}
    print(typos)
    let typosAmount = typos.count
    print(typosAmount)
    
    gVars.image = ""
  }
}
//[Letters data]----------------------------------
final class Keys {
  static let letterRow1 = ["א", "ב", "בּ", "ג", "ד", "ה", "ו"]
  static let letterRow2 = ["ז", "ח", "ט", "י", "כ", "כּ", "ל"]
  static let letterRow3 = ["מ", "נ", "ס" ,"ע", "פ", "פּ", "צ"]
  static let letterRow4 = ["ק", "ר", "שׁ", "שֹ", "ת"]
  static let extraLetters = ["א", "ה", "ע"]
  static let endLetters = ["ך","ם","ן","ף","ץ"]
  static let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "וֹ", "", "וּ"]
  static let vowelsRow = ["\u{05B8}  ", "\u{05B4}י  ", "\u{05B6}  ", "וֹ", " ", "וּ"]
}

