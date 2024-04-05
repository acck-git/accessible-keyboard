//
//  Letter and Vowel arrays
//

import Foundation

class GlobalVars: ObservableObject {
  @Published var board: Int
  @Published var inputText: String
  @Published var screen: Int
  @Published var student: String
  var example = "טֶקסט לֶהָמחָשָה"
  static var student_def = "תלמיד"
  init(board: Int = 0, inputText: String = "", screen: Int = 0, student: String = student_def ){
    self.board = board
    self.inputText = inputText
    self.screen = screen
    self.student = student
  }
}

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

