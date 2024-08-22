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
  @Published var image: imageInfo?        //currently selected image (image typing mode)
  @Published var imageZoom: Bool = false  //show overlay of selected image
  @Published var images: ImageData!
  @Published var imageBoard1: [imageInfo] = StaticData.imgDesc1
  @Published var imageBoard2: [imageInfo] = StaticData.imgDesc2
  @Published var imageBoard3: [imageInfo] = StaticData.imgDesc3
  @Published var imageBoard4: [imageInfo] = StaticData.imgDesc4
  @Published var imageBoard5: [imageInfo] = StaticData.imgDesc5
  @Published var imageBoard6: [imageInfo] = StaticData.imgDesc6
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
  private init(screen: screens = screens.main, colorSet: Int = 0, board: Int = 0) {
    self.screen = screen
    self.colorSet = colorSet
    self.board = board
    self.inputText = ""
    self.student = GlobalVars.student_def
    self.student_edit = GlobalVars.student_def
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch { print(error) }
  }
  static func get(screen: screens = screens.main, colorSet: Int = 0, board: Int = 0) -> GlobalVars {
    if (GlobalVars.singleton != nil) { return GlobalVars.singleton }
    GlobalVars.singleton = GlobalVars(screen: screen, colorSet: colorSet, board: board)
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
  var temppass: [String] = ["מורה123","teacher123", "devexport"]
  func checkPass(pass: String) -> (Bool,String,Data) {
    //return false -> hides textfield
    //return true -> keeps textfield visible
    var correct = true
    var message = ""
    var json:Data = Data()
    
    switch temppass.firstIndex(of: pass) {
    case 0,1:
      //Teacher screen redirect
      screen = screens.teacher
    case 2:
      //Dev export
      json = user!.fetchJSON()
    default:
      //Incorrect password
      message = "סיסמה לא נכונה."
      correct = false
    }
    return (!correct,message,json)
  }
  
  //[Student Login]-------------------------------
  func getStudents(add: Bool) -> [String] {
    var students = users.map { $0.student }
    if add { students.append(GlobalVars.student_new) }
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
          self.image = nil
          self.inputText = ""
          changed = true
        }
        else {
          u.toggleLogin(state: false)
        }
      }
      else {
        if u.student == student_edit {
          self.user_edit = u
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
  }
  //Save change to color set
  func updateColor(colorSet: Int) {
    self.colorSet = colorSet
    if self.user == nil { return }
    self.user!.toggleColors(colorSet: colorSet)
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
    imageBoard1 = StaticData.imgDesc1 + images.board1
    imageBoard2 = StaticData.imgDesc2 + images.board2
    imageBoard3 = StaticData.imgDesc3 + images.board3
    imageBoard4 = StaticData.imgDesc4 + images.board4
    imageBoard5 = StaticData.imgDesc5 + images.board5
    imageBoard6 = StaticData.imgDesc6 + images.board6
  }
  func fetchImages(set: String , all: Bool = true) -> [imageInfo] {
    switch set{
    case "a":
      return all ? imageBoard1 : images.board1
    case "b":
      return all ? imageBoard2 : images.board2
    case "c":
      return all ? imageBoard3 : images.board3
    case "d":
      return all ? imageBoard4 : images.board4
    case "e":
      return all ? imageBoard5 : images.board5
    case "f":
      return all ? imageBoard6 : images.board6
    default:
      return all ? imageBoard1 : images.board1
    }
  }
  func checkSpelling() {
    //[Calculate typos]--------------------------
    if inputText.count == 0 {
      image = nil
      return
    }
    var expected = Array(image!.desc)
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
    expected = Array(image!.desc)
    
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
    
    //[Update user]------------------------------
    user!.update(correct_words: typosAmount == 0 ? 1 : 0, total_letters: image!.desc.count, typos: typosAmount)
    
    //[Clear selected image]---------------------
    image = nil
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
  static let text_col: [UInt] = [0x000000,0xFFFFFF,0x000000,0xFFCC00]
  static let boardNames = ["קמץ","חיריק","סגול","חולם","עיצור","שורוק"]
  static let boards = [false,false,false,false,false,false]
  static let boards_def = [true,true,true,true,true,true]
  //[Keys]---------------------------------------
  static let letterRow1 = ["א" ,"ב\u{05BC}" ,"ב", "ג" ,"ד" ,"ה" ,"ו"]
  static let letterRow2 = ["ז" ,"ח" ,"ט" ,"י" ,"כ\u{05BC}" ,"כ", "ל"]
  static let letterRow3 = ["מ" ,"נ" ,"ס" ,"ע" ,"פ\u{05BC}" ,"פ", "צ"]
  static let letterRow4 = ["ק" ,"ר" ,"ש\u{05C1}", "ש\u{05C2}", "ת"]
  static let extraLetters = ["א" ,"ה" ,"ע"]
  static let endLetters = ["ך" ,"ם" ,"ן" ,"ף" ,"ץ"]
  static let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "ו\u{05B9}", "", "ו\u{05BC}"]
  static let vowelsRow = [
    ["a","2_a","a","2_a"],
    ["b","2_b","b","2_b"],
    ["c","2_c","c","2_c"],
    ["d","2_d","d","2_d"],
    ["e","e","e","e"],
    ["f","2_f","f","2_f"]]
  static let records = ["ב", "ג" ,"ד" ,"ו" ,"ז" ,"ח" ,"ט" ,"י" ,"כ" ,"ל" ,"מ" ,"נ" ,"ס" ,"פ" ,"צ" ,"ק" ,"ר" ,"ת"]
  //[Images]-------------------------------------
  static let sets = ["a","b","c","d","e","f"]
  static let imgDesc1 = [
    imageInfo(key: "a1", desc: "מָתָנָה"),
    imageInfo(key: "a2", desc:"קָרָא"),
    imageInfo(key: "a3", desc:"בָּכָה"),
    imageInfo(key: "a4", desc:"מָכָּה"),
    imageInfo(key: "a5", desc:"חָסָה"),
    imageInfo(key: "a6", desc:"סָבָּא"),
    imageInfo(key: "a7", desc:"תָחָנָה"),
    imageInfo(key: "a8", desc:"צָבָא"),
    imageInfo(key: "a9", desc:"בָּנָנָה"),
    imageInfo(key: "a10", desc:"פָּרָה"),
    imageInfo(key: "a11", desc:"אָבָּא"),
    imageInfo(key: "a12", desc:"צָמָה"),
  ]
  static let imgDesc2 = [
    imageInfo(key: "b1", desc: "פִּיצָה"),
    imageInfo(key: "b2", desc: "מִיטׁה"),
    imageInfo(key: "b3", desc: "עָנִיבָה"),
    imageInfo(key: "b4", desc: "חָבִיתָה"),
    imageInfo(key: "b5", desc: "סִיכָּה"),
    imageInfo(key: "b6", desc: "כִּיפָּה"),
    imageInfo(key: "b7", desc: "גִיטָרָה"),
    imageInfo(key: "b8", desc: "חִיטָה"),
    imageInfo(key: "b9", desc: "חָסִידָה"),
    imageInfo(key: "b10", desc: "גִינָה"),
    imageInfo(key: "b11", desc: "אִישָׁה"),
    imageInfo(key: "b12", desc: "טִיפָּה")
  ]
  static let imgDesc3 = [
    imageInfo(key: "c1", desc: "לֶחִי"),
    imageInfo(key: "c2", desc: "קֶעָרָה"),
    imageInfo(key: "c3", desc: "שֶׁקָע"),
    imageInfo(key: "c4", desc: "פֶּאָה"),
    imageInfo(key: "c5", desc: "שֶבָע"),
    imageInfo(key: "c6", desc: "לֶטָאָה"),
    imageInfo(key: "c7", desc: "נֶמָלָה"),
    imageInfo(key: "c8", desc: "מֶסִיבָּה"),
    imageInfo(key: "c9", desc: "שָׂדֶה"),
    imageInfo(key: "c10", desc: "הֶגֶה"),
    imageInfo(key: "c11", desc: "כִּיסֶא"),
    imageInfo(key: "c12", desc: "תֶה")
  ]
  static let imgDesc4 = [
    imageInfo(key: "d1", desc: "כּוֹבָע"),
    imageInfo(key: "d2", desc: "לֶגוֹ"),
    imageInfo(key: "d3", desc: "פּוֹנִי"),
    imageInfo(key: "d4", desc: "רוֹבֶה"),
    imageInfo(key: "d5", desc: "שוֹקוֹ"),
    imageInfo(key: "d6", desc: "חָגוֹרָה"),
    imageInfo(key: "d7", desc: "אוֹנִייָה"),
    imageInfo(key: "d8", desc: "נוֹצָה"),
    imageInfo(key: "d9", desc: "מֶנוֹרָה"),
    imageInfo(key: "d10", desc: "אוֹטוֹ"),
    imageInfo(key: "d11", desc: "חוֹלָה"),
    imageInfo(key: "d12", desc: "יוֹנָה")
  ]
  static let imgDesc5 = [
    imageInfo(key: "e1", desc: "כּחוֹל"),
    imageInfo(key: "e2", desc: "אָגָס"),
    imageInfo(key: "e3", desc: "בֶּרֶז"),
    imageInfo(key: "e4", desc: "פָּרפָּר"),
    imageInfo(key: "e5", desc: "תִיק"),
    imageInfo(key: "e6", desc: "מָזלֶג"),
    imageInfo(key: "e7", desc: "נָחָש"),
    imageInfo(key: "e8", desc: "כּוֹס"),
    imageInfo(key: "e9", desc: "קָלמָר"),
    imageInfo(key: "e10", desc: "סֶפֶר"),
    imageInfo(key: "e11", desc: "מָסרֶק"),
    imageInfo(key: "e12", desc: "קֶשֶׁת")
  ]
  static let imgDesc6 = [
    imageInfo(key: "f1", desc: "שׁוּם"),
    imageInfo(key: "f2", desc: "תוּת"),
    imageInfo(key: "f3", desc: "חוּם"),
    imageInfo(key: "f4", desc: "חִיתוּל"),
    imageInfo(key: "f5", desc: "גוּפִייָה"),
    imageInfo(key: "f6", desc: "כָּדוּר"),
    imageInfo(key: "f7", desc: "קוּבִּייָה"),
    imageInfo(key: "f8", desc: "חָלוּק"),
    imageInfo(key: "f9", desc: "תָנוּר"),
    imageInfo(key: "f10", desc: "בּוּבָּה"),
    imageInfo(key: "f11", desc: "חוּלצָה"),
    imageInfo(key: "f12", desc: "דוּבִּי")
  ]
}
