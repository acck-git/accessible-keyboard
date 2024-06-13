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
  //App states
  enum screens {case main, settings, teacher}
  @Published var screen: screens          //currently displayed screen (uses enum)
  @Published var board: Int               //currently displayed vowels board
  @Published var inputText: String        //displayed text in text input (main screen)
  @Published var student: String          //name of the logged in user
  @Published var user: UserData?          //object of the logged in user
  @Published var image: String            //currently selected image (image typing mode)
  @Published var imageZoom: Bool = false  //show overlay of selected image
  //Default values
  static let example = "טֶקסט לֶהָמחָשָה"
  static let student_def = "תלמיד"
  init(board: Int = 0, inputText: String = "", screen: screens = screens.main, student: String = student_def, image: String = "") {
    self.board = board
    self.inputText = inputText
    self.screen = screen
    self.student = student
    self.image = image
    Task { await loginStudent(student: student) }
    do {
      try AVAudioSession.sharedInstance().setCategory(.playback)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch { print(error) }
  }
  
  //[Typing]-------------------------------------
  @IBAction func type(text: String, tts: Bool){
    self.inputText += text
    if !tts { return }
    var txt = text
    if txt == "א" || txt == "ה" || txt == "ע"{ txt += StaticData.fakeNoVowel }
    else if self.board == 4 { txt += StaticData.noVowel }
    
    let utterance = AVSpeechUtterance(string: txt)
    utterance.rate = 0.5
    utterance.volume = 1
    utterance.voice = AVSpeechSynthesisVoice(language: "he-IL")
    syntheziser.speak(utterance)
  }
  
  //[Teacher Login]-------------------------------
  var temppass: [String] = ["passcheck", "teacherpage", "dev"]
  func checkPass(pass: String) -> (Bool,String,Data) {
    //return false -> hides textfield
    //return true -> keeps textfield visible
    var correct = true
    var message = ""
    var json:Data = Data()
    switch temppass.firstIndex(of: pass){
    case 0:
      message = "Correct password."
      print(message)
    case 1:
      //Teacher screen redirect
      screen = screens.teacher
    case 2:
      //Dev export
      //message = user!.exportJSON()
      json = user!.fetchJSON()
      //print(message)
    default:
      //Incorrect password
      message = "Wrong password."
      print(message)
      correct = false
    }
    return (!correct,message,json)
  }
  
  //[Student Login]-------------------------------
  static func getStudents() -> [String] {
    //will load existing students in the future
    return [student_def]
  }
  
  //Get object for selected username (or create new)
  @MainActor func loginStudent(student: String) {
    let context = GlobalVars.container!.mainContext
    let query = FetchDescriptor<UserData>(
      predicate: #Predicate { user in
        user.student == student
      }
    )
    let users: [UserData] = try! context.fetch(query)
    if users.count == 0 {
      user = UserData(student: student)
      context.insert(user!)
      print("Created user \(student).")
    }
    else {
      user = users.last!
      print("Loaded user \(student).")
    }
  }
  
  //[Images data]--------------------------------
  func checkSpelling(){
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
  //[Keys]---------------------------------------
  static let letterRow1 = ["א" ,"ב" ,"ב\u{05BC}", "ג" ,"ד" ,"ה" ,"ו"]
  static let letterRow2 = ["ז" ,"ח" ,"ט" ,"י" ,"כ" ,"כ\u{05BC}", "ל"]
  static let letterRow3 = ["מ" ,"נ" ,"ס" ,"ע" ,"פ" ,"פ\u{05BC}", "צ"]
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
