//
//  UI tests
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
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testFirstBoard() throws {
    let app = XCUIApplication()
    app.launch()
    sleep(1)
    
    let textbox = app.staticTexts["textbox"]
    XCTAssertTrue(textbox.exists, "Textbox wasn't found")
    XCTAssertEqual(textbox.label, "" ,"Textbox isn't empty")
    
    let board: Int = 0
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
    let text = "אָבָבָּגָדָהָוָזָחָטָיָכָכָּלָמָנָסָעָפָפָּצָקָרָשָׁשָֹתָאהע"
    XCTAssertEqual(textbox.label, text ,"Board typed the wrong letters")
  }
}
