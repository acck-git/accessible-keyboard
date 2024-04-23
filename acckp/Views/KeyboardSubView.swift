//
//  Keyboard sub view
//

import SwiftUI
import SwiftData

struct KeyboardSubView: View {
  @EnvironmentObject var gVars: GlobalVars
  //[Keys data]--------------------------------
  var row1: [String] = Keys.letterRow1.reversed()
  var row2: [String] = Keys.letterRow2.reversed()
  var row3: [String] = Keys.letterRow3.reversed()
  var row4: [String] = Keys.letterRow4.reversed()
  var vowelsRow: [String] = Keys.vowelsRow.reversed()
  var extraLets: [String] = Keys.extraLetters
  var endLets: [String] = Keys.endLetters
  var vowels: [String] = Keys.vowels
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
        HStack(spacing: 10.0) {
          ForEach(vowelsRow.indices, id:\.self) { index in
            VowelButton(text: vowelsRow[index], action: {
              gVars.board = vowelsRow.count - index - 1
            })
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: 823)
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
        SettingsButton(image: "gear", action: {gVars.screen = GlobalVars.screens.settings})
      }
      .padding(.horizontal, 15.0)
    }
    .frame(maxWidth: .infinity,maxHeight: .infinity)
    .background(Color(uiColor:UIColor.systemGray5))
  }
}

#Preview {
  KeyboardSubView().environmentObject(GlobalVars(board: 0))
}
#Preview {
  KeyboardSubView().environmentObject(GlobalVars(board: 4))
}
