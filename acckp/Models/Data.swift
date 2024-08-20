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
  var player: AVAudioPlayer?
  //App states
  enum screens {case main, settings, teacher, stats, blank, images}
  @Published var screen: screens          //currently displayed screen (uses enum)
  @Published var colorSet: Int            //currently displayed color set
  @Published var board: Int               //currently displayed vowels board
  @Published var inputText: String        //displayed text in text input (main screen)
  @Published var image: String            //currently selected image (image typing mode)
  @Published var imageZoom: Bool = false  //show overlay of selected image
  @Published var images: ImageData!       //
  @Published var imageBoard1: [String: String] = StaticData.imgDesc1
  @Published var imageBoard2: [String: String] = StaticData.imgDesc2
  @Published var imageBoard3: [String: String] = StaticData.imgDesc3
  @Published var imageBoard4: [String: String] = StaticData.imgDesc4
  @Published var imageBoard5: [String: String] = StaticData.imgDesc5
  @Published var imageBoard6: [String: String] = StaticData.imgDesc6
  //[Users]--------------------------------------
  @Published var users: [UserData] = []   //existing users in database
  @Published var user: UserData!          //object of the logged in user
  @Published var user_edit: UserData!     //object of the user viewed by the teacher
  @Published var student: String          //name of the logged in user
  @Published var student_edit: String     //name of the user being viewed by the teacher
  //[Default values]-----------------------------
  static let example = "טֶקסט לֶהָמחָשָה"
  static let student_def = "תלמיד"
  static let student_new = "תלמיד חדש"
  private init(screen: screens = screens.main, colorSet: Int = 0, board: Int = 0, image: String = "") {
    self.screen = screen
    self.colorSet = colorSet
    self.board = board
    self.image = image
    self.inputText = ""
    self.student = GlobalVars.student_def
    self.student_edit = GlobalVars.student_def
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch { print(error) }
  }
  static func get(screen: screens = screens.main, colorSet: Int = 0, board: Int = 0, image: String = "") -> GlobalVars {
    if (GlobalVars.singleton != nil) { return GlobalVars.singleton }
    GlobalVars.singleton = GlobalVars(screen: screen, colorSet: colorSet, board: board, image: image)
    return GlobalVars.singleton
  }
  
  //[TTS]-------------------------------------
  //Say single letter
  @IBAction func type(text: String, tts: Bool) {
    self.inputText += text
    if !tts { return }
    var txt = text
    if txt == "א" || txt == "ה" || txt == "ע"{
      return
    }
    switch text{
    case "ב\u{05BC}":
      txt = "ב_u{05BC}"
    case "כ\u{05BC}":
      txt = "כ_u{05BC}"
    case "פ\u{05BC}":
      txt = "פ_u{05BC}"
    case "ש\u{05C1}":
      txt = "ש_u{05C1}"
    case "ש\u{05C2}":
      txt = "ש_u{05C2}"
    case "ך":
      txt = "כ"
    case "ם":
      txt = "מ"
    case "ן":
      txt = "נ"
    case "ף":
      txt = "פ"
    case "ץ":
      txt = "צ"
    default:
      break
    }
    if self.board == 4 {
      guard let url = Bundle.main.url(forResource: txt, withExtension: ".mp4") else { return }
      do {
        print(txt)
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
      } catch let error {
        print("Error playing recording sound. \(error.localizedDescription)")
      }
      return
    }
    
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
    
    //--------------------------------Delete to fix login--------------------------------------
    screen = screens.teacher
    return (!correct,message,json)
    //--------------------------------Delete to fix login--------------------------------------
    
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
    var login_user: UserData?
    for u in users {
      if u.loggedIn {
        user = u
        user_edit = u
        student = u.student
        colorSet = u.colorSet
        return nil
      }
    }
    login_user = UserData(student: GlobalVars.student_def, loggedIn: true)
    user = login_user
    users.append(user)
    user_edit = user
    student = user.student
    colorSet = user.colorSet
    return login_user
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
          self.colorSet = u.colorSet
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
          //u.printUser()
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
    //self.user_edit!.printUser()
  }
  //Save change to color set
  func updateColor(colorSet: Int) {
    self.colorSet = colorSet
    if self.user == nil { return }
    self.user!.toggleColors(colorSet: colorSet)
    //self.user!.printUser()
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
    //self.user_edit!.printUser()
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
  func loadImages() {
    images.board1.forEach { imageBoard1[$0] = $1 }
    images.board2.forEach { imageBoard2[$0] = $1 }
    images.board3.forEach { imageBoard3[$0] = $1 }
    images.board4.forEach { imageBoard4[$0] = $1 }
    images.board5.forEach { imageBoard5[$0] = $1 }
    images.board6.forEach { imageBoard6[$0] = $1 }
  }
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
    //user!.printUser()
    
    //[Clear selected image]---------------------
    image = ""
    inputText = ""
  }
}

//[Static data]----------------------------------
final class StaticData {
  static let screenwidth:CGFloat = UIScreen.main.bounds.width
  static let screenheight:CGFloat = UIScreen.main.bounds.height
  //[Color]--------------------------------------
  static let vowel_col: [UInt] = [0xFFEB99,0x997a00,0xE2E2E2,0x997a00]
  static let board_col: [UInt] = [0xFFD119,0xcca300,0xFFFFFF,0xcca300]
  static let space_col: [UInt] = [0xCDCCF3,0x3E3C96,0xCDCCF3,0x3E3C96]
  static let delete_col: [UInt] = [0xFF766E,0x99231D,0xFF766E,0x99231D]
  static let extra_col: [UInt] = [0xDBF7E0,0x359846,0xDBF7E0,0x359846]
  static let settings_col: [UInt] = [0xCCE4FF,0x0055B3,0xCCE4FF,0x0055B3]
  static let confirm_col: [UInt] = [0x359846,0xDBF7E0,0x359846,0xDBF7E0]
  static let bg1_col: [UInt] = [0xFFFFFF,0x000000,0xFFCC00,0x000000]
  static let bg2_col: [UInt] = [0xE2E2E2,0x1E1E1E,0xFFEB99,0x1E1E1E]
  static  let text_col: [UInt] = [0x000000,0xFFFFFF,0x000000,0xFFCC00]
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
  static let vowelsRow = [
    ["a","2_a","a","3_a"],
    ["b","2_b","b","3_b"],
    ["c","2_c","c","3_c"],
    ["d","2_d","d","3_d"],
    ["e","e","e","e"],
    ["f","2_f","f","3_f"]]
  static let noVowel = "\u{05B0}"
  static let fakeNoVowel = "\u{05B6}"
  static let records = ["ב", "ג" ,"ד" ,"ו" ,"ז" ,"ח" ,"ט" ,"י" ,"כ" ,"ל" ,"מ" ,"נ" ,"ס" ,"פ" ,"צ" ,"ק" ,"ר" ,"ת"]
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
  static let imgDesc1 = [
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
    "a12":"צָמָה"
  ]
  static let imgDesc2 = [
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
    "b12":"טִיפָּה"
  ]
  static let imgDesc3 = [
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
    "c12":"תֶה"
  ]
  static let imgDesc4 = [
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
    "d12":"יוֹנָה"
  ]
  static let imgDesc5 = [
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
    "e12":"קֶשֶׁת"
  ]
  static let imgDesc6 = [
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
