//
//  Keyboard sub view
//

import SwiftUI
import SwiftData

struct KeyboardSubView: View {
  var board: Int
  @EnvironmentObject var input: Input
  //[Keys data]--------------------------------
  var row1: [String] = Keys.letterRow1.reversed()
  var row2: [String] = Keys.letterRow2.reversed()
  var row3: [String] = Keys.letterRow3.reversed()
  var row4: [String] = Keys.letterRow4.reversed()
  var vowelsRow: [String] = Keys.vowelsRow.reversed()
  var extraLets: [String] = Keys.extraLetters
  var vowels: [String] = Keys.vowels
  var body: some View {
    //[Kayboard container]---------------------
    VStack (spacing: 20){
      //[Row 1]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row1, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[board], action: {
            input.inputText += letter+vowels[board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 2]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row2, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[board], action: {
            input.inputText += letter+vowels[board]
          })
        }
      }
      .padding(.horizontal, 3.0)
      //[Row 3]--------------------------------
      HStack(spacing: 13.0) {
        ForEach(row3, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[board], action: {
            input.inputText += letter+vowels[board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 4]--------------------------------
      HStack(spacing: 13.0) {
        if [0,1,2].contains(board) {
          LGreenButton(text: extraLets[0], action: {}).disabled(true).opacity(0.3)
        }
        else {
          HiddenButton()
        }
        HiddenButton()
        ForEach(row4, id:\.self) { letter in
          BlackWhiteButton(text: letter+vowels[board], action: {
            input.inputText += letter+vowels[board]
          })
        }
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      //[Row 5]--------------------------------
      HStack(spacing:13){
        if [0,1,2].contains(board) {
          LGreenButton(text: extraLets[1], action: {}).disabled(true).opacity(0.3)
        }
        else {
          HiddenButton()
        }
        HiddenButton()
        HStack(spacing: 10.0) {
          ForEach(vowelsRow, id:\.self) { vowel in
            LYellowButton(text: vowel, action: {}).disabled(true).opacity(0.3)
          }
        }
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        .frame(maxWidth: 823)
      }
      //[Row 6]--------------------------------
      HStack(spacing: 13.0) {
        if [0,1,2].contains(board) {
          LGreenButton(text: extraLets[2], action: {}).disabled(true).opacity(0.3)
        }
        else {
          HiddenButton()
        }
        LRedButton(text: "מחק מילה", action: {}).disabled(true).opacity(0.3)
        LRedButton(text: "מחק תו", action: {
          input.inputText = String(input.inputText.dropLast())
        })
        LPurpleLongButton(text: "רווח", action: {
          input.inputText += " "
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
  KeyboardSubView(board: 0).environmentObject(Input())
}
#Preview {
  KeyboardSubView(board: 4).environmentObject(Input())
}
