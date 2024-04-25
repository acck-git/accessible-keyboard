//
//  Global variables and functions
//

import Foundation
import UIKit
import AVKit
import SwiftData

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
  //[Typing]-------------------------------------
  var syntheziser = AVSpeechSynthesizer()
  @IBAction func type(text: String, tts: Bool){
    self.inputText += text
    if !tts { return }
    var txt = text
    if txt == "א" || txt == "ה" || txt == "ע"{ txt += Keys.fakeNoVowel }
    else if self.board == 4 { txt += Keys.noVowel }
    print(txt)
    
    let utterance = AVSpeechUtterance(string: txt)
    utterance.rate = 0.5
    utterance.volume = 1
    utterance.voice = AVSpeechSynthesisVoice(language: "he-IL")
    syntheziser.speak(utterance)
  }
  
  //[Teacher Login]-------------------------------
  var temppass: [String] = ["pass","teach", "dev"]
  func checkPass(pass: String){
    switch temppass.firstIndex(of: pass){
    case 0: print("Correct password.")
    case 1: screen = screens.teacher
    default:
      screen = screen
      print("Wrong password.")
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
  static func checkSpelling(gVars: GlobalVars, users: [UserData], context: ModelContext){
    if gVars.inputText.count == 0 { return }
    guard let desc = imgDesc[gVars.image] else {
      print("Image description for \"\(gVars.image)\" not found in system.")
      gVars.image = ""
      return}
    var expected = Array(desc)
    //print("Input: \(gVars.inputText)")
    let recieved = Array(gVars.inputText)
    //print("Expected: \(expected)")
    //print("Recieved : \(recieved)")
    
    //missing letters -> typo
    var typosAmount = expected.count > recieved.count ? expected.count-recieved.count : 0
    //print("Typos 1: \(typosAmount).")
 
    //extra letters -> typo
    var correct : [Character] = []
    for rLet in recieved {
      if expected.contains(rLet) {
        correct.append(rLet)
        expected.remove(at: (expected.firstIndex(of: rLet)!))
        print (expected)
      }
      else { typosAmount += 1 }
    }
    expected = Array(desc)
    //print("Correct : \(correct)")
    //print("Typos 2: \(typosAmount).")
    
    //swapped -> typo
    var eIndex1 = 0
    var eIndex2 = 0
    var cIndex = 0
    while cIndex+1 < correct.count {
      eIndex1 = expected.firstIndex(of: correct[cIndex])!
      expected.remove(at: eIndex1)
      eIndex2 = expected.firstIndex(of: correct[cIndex+1])!
      //print("Compare: \(correct[cIndex]) \(correct[cIndex+1])")
      if eIndex1 > eIndex2 {
        typosAmount += 1
      }
      cIndex += 1
    }
    //print("Typos 3: \(typosAmount).")
    
    
    print("Typos: \(typosAmount).")
    
    var user: UserData
    if users.count == 0 {
      user = UserData(student: gVars.student)
      context.insert(user)
    }
    else { user = users.last! }
    user.update(correct_words: typosAmount == 0 ? 1 : 0, total_letters: expected.count, typos: typosAmount)
    
    
    //gVars.image = ""
    gVars.inputText = ""
  }
}
//[Letters data]----------------------------------
final class Keys {
  static let letterRow1 = ["א" ,"ב" ,"ב\u{05BC}", "ג" ,"ד" ,"ה" ,"ו"]
  static let letterRow2 = ["ז" ,"ח" ,"ט" ,"י" ,"כ" ,"כ\u{05BC}", "ל"]
  static let letterRow3 = ["מ" ,"נ" ,"ס" ,"ע" ,"פ" ,"פ\u{05BC}", "צ"]
  static let letterRow4 = ["ק" ,"ר" ,"ש\u{05C1}", "ש\u{05C2}", "ת"]
  static let extraLetters = ["א" ,"ה" ,"ע"]
  static let endLetters = ["ך" ,"ם" ,"ן" ,"ף" ,"ץ"]
  static let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "ו\u{05B9}", "", "ו\u{05BC}"]
  static let vowelsRow = ["\u{05B8}  ", "\u{05B4}י  ", "\u{05B6}  ", "ו\u{05B9}", " ", "ו\u{05BC}"]
  static let noVowel = "\u{05B0}"
  static let fakeNoVowel = "\u{05B6}"
}

