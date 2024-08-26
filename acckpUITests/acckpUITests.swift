//
//  UI & Integration tests (black box testing)
//

import XCTest

final class acckpUITests: XCTestCase {
  //Aid data
  let boardNames = ["קמץ","חיריק","סגול","חולם","עיצור","שורוק"]
  let deleteNames = ["מחק תו","מחק מילה"]
  let spaceName = "רווח"
  let teacherName = "כניסת מורה"
  let teacherPass = "teacher123"
  let sets = ["a","b","c","d","e","f"]
  let letterRow1 = ["א" ,"ב\u{05BC}" ,"ב", "ג" ,"ד" ,"ה" ,"ו"]
  let letterRow2 = ["ז" ,"ח" ,"ט" ,"י" ,"כ\u{05BC}" ,"כ", "ל"]
  let letterRow3 = ["מ" ,"נ" ,"ס" ,"ע" ,"פ\u{05BC}" ,"פ", "צ"]
  let letterRow4 = ["ק" ,"ר" ,"ש\u{05C1}", "ש\u{05C2}", "ת"]
  let extraLetters = ["א" ,"ה" ,"ע"]
  let endLetters = ["ך" ,"ם" ,"ן" ,"ף" ,"ץ"]
  let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "ו\u{05B9}", "", "ו\u{05BC}"]
  let vowelsRow = [
    ["a","2_a","a","2_a"],
    ["b","2_b","b","2_b"],
    ["c","2_c","c","2_c"],
    ["d","2_d","d","2_d"],
    ["e","e","e","e"],
    ["f","2_f","f","2_f"]]
  let extra: [Int] = [0,1,2]
  let end: [Int] = [4]
  let imgDesc = [
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
  //UI components
  var app: XCUIApplication!
  var textbox: XCUIElement!
  var spaceButton: XCUIElement!
  var deleteButton1: XCUIElement!
  var deleteButton2: XCUIElement!
  var settingsButton: XCUIElement!
  var boardButtons: [XCUIElement] = []
  
  //Runs before every test
  override func setUpWithError() throws {
    continueAfterFailure = false //stops after failure
    
    //Launch app if not open yet
    if app == nil { getComponents() }
  }
  //Runs after every test
  override func tearDownWithError() throws {
    //Clearing textbox after every run
    returnHome()
    while ((textbox.label == "") == false) {
      deleteButton2.tap()
    }
    XCTAssertEqual(textbox.label, "" ,"Couldn't clear textbox")
  }
  
  func testAppLaunch() throws {
    XCTAssertTrue(app.exists, "App wasn't lunched")
  }
  
  //Find textbox, delete, and vowel keys
  func getComponents() {
    app = XCUIApplication()
    app.launch()
    sleep(1)
    
    //Textbox
    textbox = app.staticTexts["textbox"]
    
    //Space key
    spaceButton = app.buttons[spaceName]
    
    //Delete keys
    deleteButton1 = app.buttons[deleteNames[0]]
    deleteButton2 = app.buttons[deleteNames[1]]
    
    //Settings key
    settingsButton = app.buttons["settings"]
    
    //Vowel bottons
    for board in 0...5 {
      var boardButton = app.buttons[vowelsRow[board][0]]
      if !boardButton.exists {
        boardButton = app.buttons[vowelsRow[board][1]]
        if !boardButton.exists {
          boardButton = app.buttons[vowelsRow[board][2]]
          if !boardButton.exists {
            boardButton = app.buttons[vowelsRow[board][3]]
          }
        }
      }
      boardButtons.append(boardButton)
    }
  }
  
  //[Unit tests]---------------------------------
  func testTextboxExists() throws {
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")
  }
  func testSpaceKeyExists() throws {
    XCTAssertTrue(spaceButton.exists, "Space button wasn't found")
  }
  func testDeleteKeysExist() throws {
    XCTAssertTrue(deleteButton1.exists, "Delete \(deleteNames[0]) button wasn't found")
    XCTAssertTrue(deleteButton2.exists, "Delete \(deleteNames[1]) button wasn't found")
  }
  func testSettingsKeyExists() throws {
    XCTAssertTrue(settingsButton.exists, "Settings button wasn't found")
  }
  func testBoardKeysExist() throws {
    for (board, button) in boardButtons.enumerated() {
      XCTAssertTrue(button.exists, "Vowel \(boardNames[board]) button wasn't found")
    }
  }
  
  //[Integration tests]--------------------------
  //Check switching between boards works
  func testBoardSwitching() throws {
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")   //check in case
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")//check in case
    XCTAssertTrue(boardButtons.count == 6, "Couldn't find all vowel buttons")//check in case
    //Press buttons
    for (board, button) in boardButtons.enumerated() {
      XCTAssertTrue(button.exists, "Vowel \(boardNames[board]) button wasn't found")//check in case
      XCTAssertEqual(button.isEnabled, true, "Board \(boardNames[board]) is disabled, couldn't complete test. Please switch user in the Simulator")//check in case
      button.tap()
      let letButton = app.buttons[letterRow1[0]+vowels[board]]
      XCTAssertTrue(button.exists, "Letter \(letterRow1[0]+vowels[board]) button wasn't found")
      letButton.tap()
    }
    //Build text to compare to
    var text = ""
    for vowel in vowels { text += letterRow1[0]+vowel }
    XCTAssertEqual(textbox.label, text ,"Switching between boards didn't work")
  }
  //Switch to first board -> type entire board -> check output is correct
  func testFirstBoard() throws { checkBoard(board: 0) }
  //Switch to second board -> type entire board -> check output is correct
  func testSecondBoard() throws { checkBoard(board: 1) }
  //Switch to third board -> type entire board -> check output is correct
  func testThirdBoard() throws { checkBoard(board: 2) }
  //Switch to fourth board -> type entire board -> check output is correct
  func testFourthBoard() throws { checkBoard(board: 3) }
  //Switch to fifth board -> type entire board -> check output is correct
  func testFifthBoard() throws { checkBoard(board: 4) }
  //Switch to sixth board -> type entire board -> check output is correct
  func testSixthBoard() throws { checkBoard(board: 5) }
  //Switch to settings page -> select first board -> check all images are valid
  func testImageBoardOne() throws { checkImageBoards(board: 0) }
  //Switch to settings page -> select second board -> check all images are valid
  func testImageBoardTwo() throws { checkImageBoards(board: 1) }
  //Switch to settings page -> select third board -> check all images are valid
  func testImageBoardThree() throws { checkImageBoards(board: 2) }
  //Switch to settings page -> select fourth board -> check all images are valid
  func testImageBoardFour() throws { checkImageBoards(board: 3) }
  //Switch to settings page -> select fifth board -> check all images are valid
  func testImageBoardFive() throws { checkImageBoards(board: 4) }
  //Switch to settings page -> select sixth board -> check all images are valid
  func testImageBoardSix() throws { checkImageBoards(board: 5) }
  //Switch to settings page -> login to teacher -> check login worked
  func testTeacherLogin() throws {
    teacherLogin()
    var label = app.staticTexts["תלמידים"]
    XCTAssertTrue(label.exists, "Couldn't login")
    label = app.staticTexts["מאגר תמונות"]
    XCTAssertTrue(label.exists, "Couldn't login")
    label = app.staticTexts["פתיחת לוחות"]
    XCTAssertTrue(label.exists, "Couldn't login")
  }
  //Switch to settings page -> login to teacher -> check image descriptions
  func testImageDescsOne() { checkImageDescriptions(board: 0) }
  //Switch to settings page -> login to teacher -> check image descriptions
  func testImageDescsTwo() { checkImageDescriptions(board: 1) }
  //Switch to settings page -> login to teacher -> check image descriptions
  func testImageDescsThree() { checkImageDescriptions(board: 2) }
  //Switch to settings page -> login to teacher -> check image descriptions
  func testImageDescsFour() { checkImageDescriptions(board: 3) }
  //Switch to settings page -> login to teacher -> check image descriptions
  func testImageDescsFive() { checkImageDescriptions(board: 4) }
  //Switch to settings page -> login to teacher -> check image descriptions
  func testImageDescsSix() { checkImageDescriptions(board: 5) }
  //Switch to settings page -> login to teacher -> close board -> check closing worked -> open board -> check open worked
  func testBoardOpeningClosing() throws {
    teacherLogin()
    let toggle = app.switches["לוח " + boardNames[1]]
    XCTAssertTrue(toggle.exists, "Board \(boardNames[1]) toggle wasn't found")
    toggle.switches.firstMatch.tap()
    returnHome()
    //check closed board
    XCTAssertFalse(boardButtons[1].isEnabled, "Board \(boardNames[1]) wasn't disabled")
    //reopen board
    teacherLogin()
    toggle.switches.firstMatch.tap()
    returnHome()
    XCTAssertTrue(boardButtons[1].isEnabled, "Board \(boardNames[1]) was still disabled")
  }
  //Switch to settings page -> login to teacher -> rename student -> check rename worked -> rename back -> check rename worked
  func testUpadeStudentName() throws {
    teacherLogin()
    let picker = app.buttons["studentpicker"]
    XCTAssertTrue(picker.exists, "Picker wasn't found")
    let studentName = picker.label
    let newName = "testname"
    let input = app.textFields["studentnameinput"]
    XCTAssertTrue(input.exists, "Input wasn't found")
    input.tap()
    input.typeText(newName)
    let button = app.buttons["עדכן"]
    XCTAssertTrue(button.exists, "Save button wasn't found")
    button.tap()
    XCTAssertEqual(picker.label, newName, "Student wasn't renamed")
    input.tap()
    input.typeText(studentName)
    button.tap()
    XCTAssertEqual(picker.label, studentName, "Student wasn't renamed back")
  }
  //[Aid functions]------------------------------
  //Return to home screen
  func returnHome() {
    while !textbox.exists {
      let backButton = app.buttons["settings"]
      XCTAssertTrue(backButton.exists, "Back button wasn't found")
      backButton.tap()
    }
  }
  //Check full images board
  func checkImageBoards(board: Int) {
    XCTAssertTrue(settingsButton.exists, "Settings button wasn't found")
    settingsButton.tap()
    var boardButton = app.buttons[vowelsRow[board][0]]
    if !boardButton.exists {
      boardButton = app.buttons[vowelsRow[board][1]]
      if !boardButton.exists {
        boardButton = app.buttons[vowelsRow[board][2]]
        if !boardButton.exists {
          boardButton = app.buttons[vowelsRow[board][3]]
        }
      }
    }
    XCTAssertTrue(boardButton.exists, "Vowel \(boardNames[board]) button wasn't found")//check in case
    XCTAssertEqual(boardButton.isEnabled, true, "Board \(boardNames[board]) is disabled, couldn't complete test. Please switch user in the Simulator")//check in case
    boardButton.tap()
    for index in 1...6 {
      let image = app.buttons[sets[board]+String(index)]
      XCTAssertTrue(image.exists, "Image \(sets[board]+String(index)) wasn't found")
    }
    let button = app.buttons["leftarrow"]
    XCTAssertTrue(button.exists, "Arrow button wasn't found")
    button.tap()
    for index in 7...12 {
      let image = app.buttons[sets[board]+String(index)]
      XCTAssertTrue(image.exists, "Image \(sets[board]+String(index)) wasn't found")
    }
  }
  //Log into teacher
  func teacherLogin() {
    XCTAssertTrue(settingsButton.exists, "Settings button wasn't found")
    settingsButton.tap()
    let teacherButton = app.buttons[teacherName]
    XCTAssertTrue(teacherButton.exists, "Teacher button wasn't found")
    teacherButton.tap()
    let teacherPassword = app.secureTextFields["password"]
    XCTAssertTrue(teacherPassword.exists, "Teacher input wasn't found")
    teacherPassword.tap()
    teacherPassword.typeText(teacherPass)
    teacherButton.tap()
  }
  //check image descriptions in a given board
  func checkImageDescriptions(board: Int) {
    teacherLogin()
    let label = app.textFields["imagename"]
    XCTAssertTrue(label.exists, "Couldn't find text field")
    let picker = app.buttons["boardpicker"]
    XCTAssertTrue(picker.exists, "Couldn't find picker")
    picker.tap()
    let vowelbutton = app.buttons[boardNames[board]]
    XCTAssertTrue(vowelbutton.exists, "Couldn't change board")
    vowelbutton.tap()
    for index in 1...6 {
      let image = app.buttons[sets[board]+String(index)]
      XCTAssertTrue(image.exists, "Image \(sets[board]+String(index)) wasn't found")
      image.tap()
      XCTAssertEqual(label.value as? String, imgDesc[sets[board] + String(index)], "Incorrect description in image \(sets[board] + String(index))")
    }
    let button = app.buttons["leftarrow"]
    XCTAssertTrue(button.exists, "Arrow button wasn't found")
    button.tap()
    for index in 7...12 {
      let image = app.buttons[sets[board]+String(index)]
      XCTAssertTrue(image.exists, "Image \(sets[board]+String(index)) wasn't found")
      image.tap()
      XCTAssertEqual(label.value as? String, imgDesc[sets[board] + String(index)], "Incorrect description in image \(sets[board] + String(index))")
    }
  }
  //Check all letters in selected board
  func checkBoard(board: Int) {
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")   //check in case
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")//check in case
    //Press buttons
    let text = runBoard(board: board)
    //Build text to compare to
    XCTAssertEqual(textbox.label, text ,"Board \(boardNames[board]) typed the wrong letters")
  }
  //Press all letters in a selected board
  func runBoard(board: Int) -> String {
    XCTAssertTrue(boardButtons[board].exists, "Vowel \(boardNames[board]) button wasn't found")//check in case
    XCTAssertEqual(boardButtons[board].isEnabled, true, "Board \(boardNames[board]) is disabled, couldn't complete test. Please switch user in the Simulator")//check in case
    boardButtons[board].tap()
    //Press buttons
    letterRow1.forEach { letter in
      let button = app.buttons[letter+vowels[board]]
      XCTAssertTrue(button.exists, "Letter \(letter+vowels[board]) button wasn't found")
      button.tap()
    }
    letterRow2.forEach { letter in
      let button = app.buttons[letter+vowels[board]]
      XCTAssertTrue(button.exists, "Letter \(letter+vowels[board]) button wasn't found")
      button.tap()
    }
    letterRow3.forEach { letter in
      let button = app.buttons[letter+vowels[board]]
      XCTAssertTrue(button.exists, "Letter \(letter+vowels[board]) button wasn't found")
      button.tap()
    }
    letterRow4.forEach { letter in
      let button = app.buttons[letter+vowels[board]]
      XCTAssertTrue(button.exists, "Letter \(letter+vowels[board]) button wasn't found")
      button.tap()
    }
    if extra.contains(board) {
      extraLetters.forEach{ letter in
        let button = app.buttons[letter]
        XCTAssertTrue(button.exists, "Letter \(letter+vowels[board]) button wasn't found")
        button.tap()
      }
    }
    else if end.contains(board) {
      endLetters.forEach{ letter in
        let button = app.buttons[letter]
        XCTAssertTrue(button.exists, "Letter \(letter+vowels[board]) button wasn't found")
        button.tap()
      }
    }
    //Build text to compare to
    var text = ""
    for letter in letterRow1 { text += letter+vowels[board] }
    for letter in letterRow2 { text += letter+vowels[board] }
    for letter in letterRow3 { text += letter+vowels[board] }
    for letter in letterRow4 { text += letter+vowels[board] }
    if extra.contains(board) {
      for letter in extraLetters { text += letter}
    }
    else if end.contains(board) {
      for letter in endLetters { text += letter }
    }
    return text
  }
}
