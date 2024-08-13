//
//  Keyboard sub view
//

import SwiftUI
import SwiftData

struct KeyboardSubView: View {
  @ObservedObject var gVars = GlobalVars.get()
  var boards: [Bool] = StaticData.boards
  //[Keys data]--------------------------------
  var row1: [String] = StaticData.letterRow1.reversed()
  var row2: [String] = StaticData.letterRow2.reversed()
  var row3: [String] = StaticData.letterRow3.reversed()
  var row4: [String] = StaticData.letterRow4.reversed()
  var vowelsRow: [[String]] = StaticData.vowelsRow.reversed()
  var extraLets: [String] = StaticData.extraLetters
  var endLets: [String] = StaticData.endLetters
  var vowels: [String] = StaticData.vowels
  var extra: [Int] = [0,1,2]
  var end: [Int] = [4]
  init () {
    if gVars.user != nil { boards = gVars.user!.boards }
  }
  var body: some View {
    //[Kayboard container]---------------------
    VStack (spacing: 20) {
      //[Row 1]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row1, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
      //[Row 2]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row2, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
      //[Row 3]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row3, id:\.self) { letter in
          LetterButton(text: letter+vowels[gVars.board], action: {
            gVars.type(text: letter+vowels[gVars.board], tts: true)
          })
        }
      }
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
      //[Row 5]--------------------------------
      HStack(spacing:13) {
        HStack(spacing: 13) {
          if extra.contains(gVars.board) {
            ExtraLetterButton(text: extraLets[1], action: {
              gVars.type(text: extraLets[1], tts: true)
            })
          }
          else if end.contains(gVars.board) {
            ExtraLetterButton(text: endLets[3], action: {
              gVars.type(text: endLets[3], tts: true)
            })
          }
          else { HiddenButton() }
          if end.contains(gVars.board) {
            ExtraLetterButton(text: endLets[2], action: {
              gVars.type(text: endLets[2], tts: true)
            })
          }
          else { HiddenButton() }
        }
        .frame(width: (StaticData.screenwidth * (2/7)) - 19)
        ForEach(vowelsRow.indices, id:\.self) { index in
          VowelButton(image: vowelsRow[index][gVars.colorSet], action: {
            gVars.board = vowelsRow.count - index - 1
          }, enabled: boards[vowelsRow.count - index - 1], selected: vowelsRow.count - index - 1 == gVars.board)
        }
      }
      //[Row 6]--------------------------------
      HStack(spacing: 13.0) {
        HStack() {
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
        }
        .frame(width: (StaticData.screenwidth * (1/7)) - 16)
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
    .padding(.horizontal, 18.0)
    .padding(.top, 20)
    .padding(.bottom, 10)
    .background(Color(hex:StaticData.bg2_col[gVars.colorSet]))
  }
}

#Preview {
  KeyboardSubView()
}
