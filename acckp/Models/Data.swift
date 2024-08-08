//
//  Global variables and functions
//

import Foundation
import UIKit
import SwiftData
import AVKit
var syntheziser = AVSpeechSynthesizer()

//[Global vars & funcs]--------------------------
class GlobalVars: ObservableObject {
  static var container: ModelContainer?
  static var singleton: GlobalVars!
  //App states
  enum screens {case main, settings, teacher, stats}
  @Published var screen: screens          //currently displayed screen (uses enum)
  @Published var board: Int               //currently displayed vowels board
  @Published var inputText: String        //displayed text in text input (main screen)
  @Published var student_edit: String
  @Published var student: String          //name of the logged in user
  @Published var user: UserData!          //object of the logged in user
  @Published var user_edit: UserData!     //object of the user viewed by the teacher
  @Published var users: [UserData] = []   //existing users in database
  @Published var image: String            //currently selected image (image typing mode)
  @Published var imageZoom: Bool = false  //show overlay of selected image
  //Default values
  static let example = "טֶקסט לֶהָמחָשָה"
  static let student_def = "תלמיד"
  static let student_new = "תלמיד חדש"
  private init(board: Int = 0, inputText: String = "", screen: screens = screens.main, student: String = student_def, image: String = "") {
    self.board = board
    self.inputText = inputText
    self.screen = screen
    self.student = student
    self.student_edit = student
    self.image = image
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch { print(error) }
  }
  static func get(board: Int = 0, inputText: String = "", screen: screens = screens.main, student: String = student_def, image: String = "") -> GlobalVars {
    if (GlobalVars.singleton != nil) { return GlobalVars.singleton }
    GlobalVars.singleton = GlobalVars(board: board, inputText: inputText, screen: screen, student: student, image: image)
    return GlobalVars.singleton
  }
  
  //[TTS]-------------------------------------
  //Say single letter
  @IBAction func type(text: String, tts: Bool) {
    self.inputText += text
    if !tts { return }
    let txt = text
    if txt == "א" || txt == "ה" || txt == "ע" || self.board == 4 { return }
    
    let utterance = AVSpeechUtterance(string: txt)
    utterance.rate = 0.5
    utterance.volume = 1
    utterance.voice = AVSpeechSynthesisVoice(language: "he-IL")
    syntheziser.speak(utterance)
  }
  //Say entire sentence
  @IBAction func speak() {
    let utterance = AVSpeechUtterance(string: self.inputText)
    utterance.rate = 0.3
    utterance.volume = 1
    utterance.voice = AVSpeechSynthesisVoice(language: "he-IL")
    syntheziser.speak(utterance)
  }
  
  //[Teacher Login]-------------------------------
  var temppass: [String] = ["passcheck", "ttt", "dev"]
  func checkPass(pass: String) -> (Bool,String,Data) {
    //return false -> hides textfield
    //return true -> keeps textfield visible
    var correct = true
    var message = ""
    var json:Data = Data()
    screen = screens.teacher
    return (!correct,message,json)
    //-----------------------------------
    switch temppass.firstIndex(of: pass) {
    case 0:
      message = "Correct password."
      print(message)
    case 1:
      //Teacher screen redirect
      screen = screens.teacher
    case 2:
      //Dev export
      json = user!.fetchJSON()
    default:
      //Incorrect password
      message = "Wrong password."
      print(message)
      correct = false
    }
    return (!correct,message,json)
  }
  
  //[Student Login]-------------------------------
  func getStudents(add: Bool) -> [String] {
    //will load existing students in the future
    var students = users.map { $0.student }
    if add { students.append(GlobalVars.student_new) }
    //print(students)
    return students
  }
  //Find logged in user
  func loginStudent() -> UserData? {
    for u in users {
      if u.loggedIn {
        user = u
        user_edit = u
        student = u.student
        return nil
      }
    }
    user = UserData(student: GlobalVars.student_def, loggedIn: true)
    user_edit = user
    student = user.student
    users.append(user)
    return user
  }
  //Change the selected student
  func swapStudent(login: Bool = false) {
    var changed = false
    for u in users {
      if login {
        if u.student == student{
          u.toggleLogin(state: true)
          self.user = u
          self.user_edit = u
          self.student_edit = student
          self.board = 0
          self.image = ""
          self.inputText = ""
          //u.printUser()
          changed = true
        }
        else {
          u.toggleLogin(state: false)
          //u.printUser()
        }
      }
      else {
        if u.student == student_edit {
          self.user_edit = u
          u.printUser()
          changed = true
          break
        }
      }
    }
    if !changed {
      self.user_edit = nil
    }
  }
  //Save change to boards
  func updateBoard(index: Int, state: Bool) {
    if self.user_edit == nil { return }
    self.user_edit!.toggleBoard(index: index, state: state)
    self.user_edit!.printUser()
  }
  //Save change to boards
  func updateStudent(name: String) -> (UserData?,String,Bool) {
    var newUser: UserData?
    var message = ""
    //Name isn't in use
    for u in users {
      if u.student == name { return (nil, "שם זה כבר בשימוש.", false) }
    }
    //New user
    if self.student_edit == GlobalVars.student_new {
      user = UserData(student: name)
      user_edit = user
      users.append(user)
      newUser = user
      message = "משתמש נוסף בהצלחה."
    }
    //Update user
    else {
      if self.user_edit == nil { return (nil,"",true) }
      user_edit.renameStudent(student: name)
      message = "משתמש עודכן בהצלחה."
    }
    student_edit = name
    self.user_edit!.printUser()
    return (newUser,message,true)
  }
  //Save change to boards
  func deleteStudent() -> (UserData?,UserData?) {
    if student_edit == GlobalVars.student_new { return (nil,nil) }
    let user_del = user_edit
    var def_user: UserData?
    self.users = users.filter({ $0.student != user_del!.student })
    if users.count == 0 {
      def_user = UserData(student: GlobalVars.student_def)
      self.users.append(def_user!)
    }
    self.user_edit = self.users[0]
    self.student_edit = self.user_edit.student
    if student == user_del?.student {
      self.student = self.users[0].student
      self.swapStudent(login: true)
    }
    return (user_del!,def_user)
  }
  
  //[Images data]--------------------------------
  func checkSpelling() {
    //[Calculate typos]--------------------------
    if inputText.count == 0 {
      image = ""
      return
    }
    guard let desc = StaticData.imgDesc[image] else {
      print("Image description for \"\(image)\" not found in system.")
      image = ""
      return
    }
    var expected = Array(desc)
    let recieved = Array(inputText)
    
    //missing letters -> typo
    var typosAmount = expected.count > recieved.count ? expected.count-recieved.count : 0
    
    //extra letters -> typo
    var correct : [Character] = []
    for rLet in recieved {
      if expected.contains(rLet) {
        correct.append(rLet)
        expected.remove(at: (expected.firstIndex(of: rLet)!))
      }
      else { typosAmount += 1 }
    }
    expected = Array(desc)
    
    //swapped -> typo
    var eIndex1 = 0
    var eIndex2 = 0
    var cIndex = 0
    while cIndex+1 < correct.count {
      eIndex1 = expected.firstIndex(of: correct[cIndex])!
      expected.remove(at: eIndex1)
      eIndex2 = expected.firstIndex(of: correct[cIndex+1])!
      if eIndex1 > eIndex2 {
        typosAmount += 1
      }
      cIndex += 1
    }
    print("Typos: \(typosAmount).")
    
    //[Update user]------------------------------
    user!.update(correct_words: typosAmount == 0 ? 1 : 0, total_letters: desc.count, typos: typosAmount)
    print("Updated user \(user!).")
    user!.printUser()
    
    //[Clear selected image]---------------------
    image = ""
    inputText = ""
  }
}

//[Static data]----------------------------------
final class StaticData {
  static let screenwidth:CGFloat = UIScreen.main.bounds.width
  static let screenheight:CGFloat = UIScreen.main.bounds.height
  static let boardNames = ["קמץ","חיריק","סגול","חולם","עיצור","שורוק"]
  static let boards = [false,false,false,false,false,false]
  static let boards_def = [true,false,false,false,false,false]
  //[Keys]---------------------------------------
  static let letterRow1 = ["א" ,"ב\u{05BC}" ,"ב", "ג" ,"ד" ,"ה" ,"ו"]
  static let letterRow2 = ["ז" ,"ח" ,"ט" ,"י" ,"כ\u{05BC}" ,"כ", "ל"]
  static let letterRow3 = ["מ" ,"נ" ,"ס" ,"ע" ,"פ\u{05BC}" ,"פ", "צ"]
  static let letterRow4 = ["ק" ,"ר" ,"ש\u{05C1}", "ש\u{05C2}", "ת"]
  static let extraLetters = ["א" ,"ה" ,"ע"]
  static let endLetters = ["ך" ,"ם" ,"ן" ,"ף" ,"ץ"]
  static let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "ו\u{05B9}", "", "ו\u{05BC}"]
  static let vowelsRow = ["a", "b", "c", "d", "e", "f"]
  static let noVowel = "\u{05B0}"
  static let fakeNoVowel = "\u{05B6}"
  //[Images]-------------------------------------
  static let sets = ["a","b","c","d","e","f"]
  static let imgDesc = [
    "a1":"מָתָנָה",
    "a2":"קָרָא",
    "a3":"בָּכָה",
    "a4":"מָכָּה",
    "a5":"חָסָה",
    "a6":"סָבָּא",
    "a7":"תָחָנָה",
    "a8":"צָבָא",
    "a9":"בָּנָנָה",
    "a10":"פָּרָה",
    "a11":"אָבָּא",
    "a12":"צָמָה",
    "b1":"פִּיצָה",
    "b2":"מִיטׁה",
    "b3":"עָנִיבָה",
    "b4":"חָבִיתָה",
    "b5":"סִיכָּה",
    "b6":"כִּיפָּה",
    "b7":"גִיטָרָה",
    "b8":"חִיטָה",
    "b9":"חָסִידָה",
    "b10":"גִינָה",
    "b11":"אִישָׁה",
    "b12":"טִיפָּה",
    "c1":"לֶחִי",
    "c2":"קֶעָרָה",
    "c3":"שֶׁקָע",
    "c4":"פֶּאָה",
    "c5":"שֶבָע",
    "c6":"לֶטָאָה",
    "c7":"נֶמָלָה",
    "c8":"מֶסִיבָּה",
    "c9":"שָׂדֶה",
    "c10":"הֶגֶה",
    "c11":"כִּיסֶא",
    "c12":"תֶה",
    "d1":"כּוֹבָע",
    "d2":"לֶגוֹ",
    "d3":"פּוֹנִי",
    "d4":"רוֹבֶה",
    "d5":"שוֹקוֹ",
    "d6":"חָגוֹרָה",
    "d7":"אוֹנִייָה",
    "d8":"נוֹצָה",
    "d9":"מֶנוֹרָה",
    "d10":"אוֹטוֹ",
    "d11":"חוֹלָה",
    "d12":"יוֹנָה",
    "e1":"כּחוֹל",
    "e2":"אָגָס",
    "e3":"בֶּרֶז",
    "e4":"פָּרפָּר",
    "e5":"תִיק",
    "e6":"מָזלֶג",
    "e7":"נָחָש",
    "e8":"כּוֹס",
    "e9":"קָלמָר",
    "e10":"סֶפֶר",
    "e11":"מָסרֶק",
    "e12":"קֶשֶׁת",
    "f1":"שׁוּם",
    "f2":"תוּת",
    "f3":"חוּם",
    "f4":"חִיתוּל",
    "f5":"גוּפִייָה",
    "f6":"כָּדוּר",
    "f7":"קוּבִּייָה",
    "f8":"חָלוּק",
    "f9":"תָנוּר",
    "f10":"בּוּבָּה",
    "f11":"חוּלצָה",
    "f12":"דוּבִּי"
  ]
}
