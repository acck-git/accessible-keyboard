//
//  UI tests (black box testing)
//

import XCTest

final class acckpUITests: XCTestCase {
  let letterRow1 = ["א" ,"ב\u{05BC}" ,"ב", "ג" ,"ד" ,"ה" ,"ו"]
  let letterRow2 = ["ז" ,"ח" ,"ט" ,"י" ,"כ\u{05BC}" ,"כ", "ל"]
  let letterRow3 = ["מ" ,"נ" ,"ס" ,"ע" ,"פ\u{05BC}" ,"פ", "צ"]
  let letterRow4 = ["ק" ,"ר" ,"ש\u{05C1}", "ש\u{05C2}", "ת"]
  let extraLetters = ["א" ,"ה" ,"ע"]
  let endLetters = ["ך" ,"ם" ,"ן" ,"ף" ,"ץ"]
  let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "ו\u{05B9}", "", "ו\u{05BC}"]
  let vowelsRow = [
    ["a","2_a","a","3_a"],
    ["b","2_b","b","3_b"],
    ["c","2_c","c","3_c"],
    ["d","2_d","d","3_d"],
    ["e","e","e","e"],
    ["f","2_f","f","3_f"]]
  var extra: [Int] = [0,1,2]
  var end: [Int] = [4]
  
  //Runs before every test
  override func setUpWithError() throws {
    
    continueAfterFailure = false //stops after failure
  }
  //Runs after every test
  override func tearDownWithError() throws {
    //Clearing textbox after every run
    let app = XCUIApplication()
    let textbox = app.staticTexts["textbox"]
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")
    let deleteButton = app.buttons["מחק מילה"]
    while ((textbox.label == "") == false) {
      print(textbox.label)
      deleteButton.tap()
    }
    XCTAssertEqual(textbox.label, "" ,"Couldn't clear textbox")
  }
  
  func testAppLaunch() throws {
    let app = XCUIApplication()
    app.launch()
    sleep(1)
    
    let textbox = app.staticTexts["textbox"]
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")
  }
  func testFirstBoard() throws {checkBoard(board: 0)}
  func testSecondBoard() throws {checkBoard(board: 1)}
  func testThirdBoard() throws {checkBoard(board: 2)}
  func testFourthBoard() throws {checkBoard(board: 3)}
  func testFifthBoard() throws {checkBoard(board: 4)}
  func testSixthBoard() throws {checkBoard(board: 5)}
  
  //[Aid functions]------------------------------
  //Check all letters in selected board
  func checkBoard(board: Int){
    let app = XCUIApplication()
    app.launch()
    sleep(1)
    
    let textbox = app.staticTexts["textbox"]
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")
    
    let text = runBoard(app: app, board: board)
    print(text)
    XCTAssertEqual(textbox.label, text ,"Board \(board) typed the wrong letters")
  }
  //Press all letters in a selected board
  func runBoard(app: XCUIApplication, board: Int) -> String{
    var boardButton = app.buttons[vowelsRow[board][0]]
    if !boardButton.exists {
      boardButton = app.buttons[vowelsRow[board][1]]
      if !boardButton.exists {
        boardButton = app.buttons[vowelsRow[board][2]]
        if !boardButton.exists {
          boardButton = app.buttons[vowelsRow[board][3]]
          XCTAssertTrue(boardButton.exists, "Vowel button wasn't found")
        }
      }
    }
    boardButton.tap()
    
    letterRow1.forEach{ letter in
      let button = app.buttons[letter+vowels[board]]
      button.tap()
    }
    letterRow2.forEach{ letter in
      let button = app.buttons[letter+vowels[board]]
      button.tap()
    }
    letterRow3.forEach{ letter in
      let button = app.buttons[letter+vowels[board]]
      button.tap()
    }
    letterRow4.forEach{ letter in
      let button = app.buttons[letter+vowels[board]]
      button.tap()
    }
    if extra.contains(board){
      extraLetters.forEach{ letter in
        let button = app.buttons[letter]
        button.tap()
      }
    }
    else if end.contains(board) {
      endLetters.forEach{ letter in
        let button = app.buttons[letter]
        button.tap()
      }
    }
    var text = ""
    for letter in letterRow1{text += letter+vowels[board]}
    for letter in letterRow2{text += letter+vowels[board]}
    for letter in letterRow3{text += letter+vowels[board]}
    for letter in letterRow4{text += letter+vowels[board]}
    if extra.contains(board){
      for letter in extraLetters{text += letter}
    }
    else if end.contains(board) {
      for letter in endLetters{text += letter}
    }
    return text
  }
}
