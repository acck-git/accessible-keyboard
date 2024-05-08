//
//  Keyboard sub view
//

import SwiftUI
import SwiftData

struct KeyboardSubView: View {
  @EnvironmentObject var gVars: GlobalVars
  //[Keys data]--------------------------------
  var row1: [String] = StaticData.letterRow1.reversed()
  var row2: [String] = StaticData.letterRow2.reversed()
  var row3: [String] = StaticData.letterRow3.reversed()
  var row4: [String] = StaticData.letterRow4.reversed()
  var vowelsRow: [String] = StaticData.vowelsRow.reversed()
  var extraLets: [String] = StaticData.extraLetters
  var endLets: [String] = StaticData.endLetters
  var vowels: [String] = StaticData.vowels
  var extra: [Int] = [0,1,2]
  var end: [Int] = [4]
  var body: some View {
    //[KaygVars.board container]---------------------
    VStack (spacing: 20){
      //[Row 1]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row1, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 2]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row2, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
      .padding(.horizontal, 3.0)
      //[Row 3]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row3, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 4]--------------------------------
      HStack(spacing: 13.0) {
        if extra.contains(gVars.board) {
          ExtraLetterButton(text: extraLets[0], action: {
            gVars.type(text: extraLets[0], tts: true)
          })
        }
        else if end.contains(gVars.board) {
          ExtraLetterButton(text: endLets[1], action: {
            gVars.type(text: endLets[1], tts: true)
          })
        }
        else { HiddenButton() }
        if end.contains(gVars.board) {
          ExtraLetterButton(text: endLets[0], action: {
            gVars.type(text: endLets[0], tts: true)
          })
        }
        else { HiddenButton() }
        ForEach(row4, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 5]--------------------------------
      HStack(spacing:13){
        if extra.contains(gVars.board) {
          ExtraLetterButton(text: extraLets[1], action: {
            gVars.type(text: extraLets[1], tts: true)
          })
        }
        else if end.contains(gVars.board){
          ExtraLetterButton(text: endLets[3], action: {
            gVars.type(text: endLets[3], tts: true)
          })
        }
        else { HiddenButton() }
        if end.contains(gVars.board){
          ExtraLetterButton(text: endLets[2], action: {
            gVars.type(text: endLets[2], tts: true)
          })
        }
        else { HiddenButton() }
        //HStack(spacing: 10.0) {
        //  ForEach(vowelsRow.indices, id:\.self) { index in
        //    VowelButton(image: vowelsRow[index], action: {
        //      gVars.board = vowelsRow.count - index - 1
        //    })
        //  }
          HiddenButton()
          VowelButton(image: vowelsRow[0], action: {
            gVars.board = vowelsRow.count - 0 - 1
          })
          VowelButton(image: vowelsRow[1], action: {
            gVars.board = vowelsRow.count - 1 - 1
          })
          VowelButton(image: vowelsRow[2], action: {
            gVars.board = vowelsRow.count - 2 - 1
          })
          VowelButton(image: vowelsRow[3], action: {
            gVars.board = vowelsRow.count - 3 - 1
          })
          VowelButton(image: vowelsRow[4], action: {
            gVars.board = vowelsRow.count - 4 - 1
          })
          VowelButton(image: vowelsRow[5], action: {
            gVars.board = vowelsRow.count - 5 - 1
          })
        //}
        //.padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        //.frame(width: 823)
      }
      //[Row 6]--------------------------------
      HStack(spacing: 13.0) {
        if extra.contains(gVars.board) {
          ExtraLetterButton(text: extraLets[2], action: {
            gVars.type(text: extraLets[2], tts: true)
          })
        }
        else if end.contains(gVars.board) {
          ExtraLetterButton(text: endLets[4], action: {
            gVars.type(text: endLets[4], tts: true)
          })
        }
        else { HiddenButton() }
        DeleteButton(text: "מחק מילה", action: {
          if gVars.inputText.last == " "{
            while gVars.inputText.last == " "{
              gVars.inputText = String(gVars.inputText.dropLast())
            }
          }
          gVars.inputText = String(gVars.inputText.components(separatedBy: " ").dropLast().joined(separator: " "))
          if gVars.inputText != ""{
            gVars.inputText += " "
          }
        })
        DeleteButton(text: "מחק תו", action: {
          gVars.inputText = String(gVars.inputText.dropLast())
        })
        SpaceButton(text: "רווח", action: {
          gVars.inputText += " "
        })
        SettingsButton(image: "gear", action: {
          gVars.screen = GlobalVars.screens.settings
        })
      }
    }
    .frame(maxWidth: .infinity,maxHeight: .infinity)
    .padding(.horizontal, 15.0)
    .background(Color(uiColor:UIColor.systemGray5))
  }
}

#Preview {
  KeyboardSubView().environmentObject(GlobalVars(board: 0))
}
#Preview {
  KeyboardSubView().environmentObject(GlobalVars(board: 4))
}
