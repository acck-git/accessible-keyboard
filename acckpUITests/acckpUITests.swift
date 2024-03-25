//
//  UI tests (black box testing)
//

import XCTest

final class acckpUITests: XCTestCase {
  let letterRow1 = ["א", "ב", "בּ", "ג", "ד", "ה", "ו"]
  let letterRow2 = ["ז", "ח", "ט", "י", "כ", "כּ", "ל"]
  let letterRow3 = ["מ", "נ", "ס" ,"ע", "פ", "פּ", "צ"]
  let letterRow4 = ["ק", "ר", "שׁ", "שֹ", "ת"]
  let extraLetters = ["א", "ה", "ע"]
  let endLetters = ["ך","ם","ן","ף","ץ"]
  let vowels = ["\u{05B8}", "\u{05B4}י", "\u{05B6}", "וֹ", "", "וּ"]
  let vowelsRow = ["\u{05B8}  ", "\u{05B4}י  ", "\u{05B6}  ", "וֹ", " ", "וּ"]
  
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
    let deleteButton = app.buttons["מחק תו"]
    while ((textbox.label == "") == false) {
      print(textbox.label)
      deleteButton.tap()
    }
    XCTAssertEqual(textbox.label, "" ,"Couldn't clear textbox")
  }
  
  func testFirstBoard() throws {
    let app = XCUIApplication()
    app.launch()
    sleep(1)
    
    let textbox = app.staticTexts["textbox"]
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")
    
    runBoard(app: app, board: 0)
    
    let text = "אָבָבָּגָדָהָוָזָחָטָיָכָכָּלָמָנָסָעָפָפָּצָקָרָשָׁשָֹתָאהע"
    XCTAssertEqual(textbox.label, text ,"Board typed the wrong letters")
    //missing: clearing label after test
  }
  
  //[Aid functions]------------------------------
  //Press all letters in a selected board
  func runBoard(app: XCUIApplication, board: Int){
    let boardButton = app.buttons[vowelsRow[board]]
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
    extraLetters.forEach{ letter in
      let button = app.buttons[letter]
      button.tap()
    }
  }
}
