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
  var vowels: [String] = Keys.vowels
  var body: some View {
    //[KaygVars.board container]---------------------
    VStack (spacing: 20){
      //[Row 1]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row1, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[gVars.board], action: {
            gVars.inputText += letter+vowels[gVars.board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 2]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row2, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[gVars.board], action: {
            gVars.inputText += letter+vowels[gVars.board]
          })
        }
      }
      .padding(.horizontal, 3.0)
      //[Row 3]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row3, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[gVars.board], action: {
            gVars.inputText += letter+vowels[gVars.board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 4]--------------------------------
      HStack(spacing: 13.0) {
        if [0,1,2].contains(gVars.board) {
          LGreenButton(text: extraLets[0], action: {}).disabled(true).opacity(0.3)
        }
        else {
          HiddenButton()
        }
        HiddenButton()
        ForEach(row4, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[gVars.board], action: {
            gVars.inputText += letter+vowels[gVars.board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 5]--------------------------------
      HStack(spacing:13){
        if [0,1,2].contains(gVars.board) {
          LGreenButton(text: extraLets[1], action: {}).disabled(true).opacity(0.3)
        }
        else {
          HiddenButton()
        }
        HiddenButton()
        HStack(spacing: 10.0) {
          ForEach(vowelsRow.indices, id:\.self) { index in
            LYellowButton(text: vowelsRow[index], action: {
              gVars.board = vowelsRow.count - index - 1
            })
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: 823)
      }
      //[Row 6]--------------------------------
      HStack(spacing: 13.0) {
        if [0,1,2].contains(gVars.board) {
          LGreenButton(text: extraLets[2], action: {}).disabled(true).opacity(0.3)
        }
        else {
          HiddenButton()
        }
        LRedButton(text: "מחק מילה", action: {}).disabled(true).opacity(0.3)
        LRedButton(text: "מחק תו", action: {
          gVars.inputText = String(gVars.inputText.dropLast())
        })
        LPurpleLongButton(text: "רווח", action: {
          gVars.inputText += " "
        })
        LBlueImageButton(image: "gear", action: {}).disabled(true).opacity(0.3)
      }
      .padding(.horizontal, 15.0)
    }
    .frame(maxWidth:.infinity,maxHeight:.infinity)
    .background(Color(uiColor:UIColor.systemGray5))
  }
}

#Preview {
  KeyboardSubView().environmentObject(GlobalVars())
}
