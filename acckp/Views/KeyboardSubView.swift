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
        if extra.contains(gVars.board) {
          LGreenButton(text: extraLets[0], action: {
            gVars.inputText += extraLets[0]
          })
        }
        else if end.contains(gVars.board){
          LGreenButton(text: endLets[1], action: {
            gVars.inputText += endLets[1]
          })
        }
        else {
          HiddenButton()
        }
        if end.contains(gVars.board){
          LGreenButton(text: endLets[0], action: {
            gVars.inputText += endLets[0]
          })
        }
        else {
          HiddenButton()
        }
        ForEach(row4, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[gVars.board], action: {
            gVars.inputText += letter+vowels[gVars.board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 5]--------------------------------
      HStack(spacing:13){
        if extra.contains(gVars.board) {
          LGreenButton(text: extraLets[1], action:{
            gVars.inputText += extraLets[1]
          })
        }
        else if end.contains(gVars.board){
          LGreenButton(text: endLets[3], action: {
            gVars.inputText += endLets[3]
          })
        }
        else {
          HiddenButton()
        }
        if end.contains(gVars.board){
          LGreenButton(text: endLets[2], action: {
            gVars.inputText += endLets[2]
          })
        }
        else {
          HiddenButton()
        }
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
        if extra.contains(gVars.board) {
          LGreenButton(text: extraLets[2], action: {
            gVars.inputText += extraLets[2]
          })
        }
        else if end.contains(gVars.board){
          LGreenButton(text: endLets[4], action: {
            gVars.inputText += endLets[4]
          })
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
  KeyboardSubView().environmentObject(GlobalVars(board:0))
}
#Preview {
  KeyboardSubView().environmentObject(GlobalVars(board:4))
}