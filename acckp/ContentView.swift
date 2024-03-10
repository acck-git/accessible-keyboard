//
//  ContentView.swift
//  acckp
//
//  Created by akp sce on 26/02/2024.
//

import SwiftUI
import SwiftData

extension Color {
  init(hex: UInt, alpha: Double = 1) {
    self.init(
      .sRGB,
      red: Double((hex >> 16) & 0xff) / 255,
      green: Double((hex >> 08) & 0xff) / 255,
      blue: Double((hex >> 00) & 0xff) / 255,
      opacity: alpha
    )
  }
}
func letters (row: Int = -1,letter: Int = -1, vowel: Int = -1){
  var blankRow1 = ["א", "ב", "בּ", "ג", "ד", "ה", "ו"]
  var blankRow2 = ["ז", "ח", "ט", "י", "כ", "כּ", "ל"]
  var blankRow3 = ["מ", "נ", "ס" ,"ע", "פ", "פּ", "צ"]
  var blankRow4 = ["ק", "ר", "שׁ", "שֹ", "ת", "", ""]
  var blankLets = [blankRow1,blankRow2,blankRow3,blankRow4]
  var vowels = ["\u{05B8}  ", "\u{05B4}י  ", "\u{05B6}  ", "וֹ", " ", "וּ"]
  var board = 0
  
  var kamRow1: [String] = []
  
  blankRow1.append("x")
}

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  
  var body: some View {
    VStack (spacing: 0.0) {
      
      // Top line, audio button and text input
      HStack(spacing:20) {
        Button(action: {}, label: {
          Image(systemName: "speaker.fill")
            .imageScale(.large)
            .frame(width: 80, height: 80)
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 15)
              .stroke(.black, lineWidth: 2)
            )
        })
        .background(.white)
        .cornerRadius(15)
        
        Text("טֶקסט לֶהָמחָשָה")
          .lineLimit(1)
          .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/ , minHeight: 80, alignment:.trailing)
          .padding(.horizontal)
          .foregroundColor(.black)
          .font(.system(size: 35, weight: .heavy))
          .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(.black, lineWidth: 2))
        
        //TextField("היי", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
        //   .textFieldStyle(.roundedBorder)
        //  .multilineTextAlignment(.trailing)
        // .font(.system(size: 40))
        
        
      }
      .padding(/*@START_MENU_TOKEN@*/.horizontal, 20.0/*@END_MENU_TOKEN@*/)
      .padding(.vertical, 20.0)
      .frame(maxWidth:.infinity, maxHeight:123)
      
      Divider()
        .frame(height: 5.0)
        .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
        .overlay(.black)
      
      // keyboard
      VStack (spacing:20){

        
        ForEach(0..<3){ i in
          HStack(spacing: 13.0) {
            
            ForEach(0..<7) { j in
              Button(action: {}, label: { Text(letters(row: i, letter: j))
                  .frame(width: 155, height: 95)
                  .foregroundColor(.black)
                  .font(.system(size: 35, weight: .heavy))
                  .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 2)
                  )
              })
              .background(.white)
              .cornerRadius(15)
            }
          }
          //.padding(/*@START_MENU_TOKEN@*/.vertical, 13.0/*@END_MENU_TOKEN@*/)
          .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        }
        HStack(spacing: 13.0) {
          Button(action: {}, label: { Text("א")
              .frame(width: 155, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35, weight: .heavy))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          //.opacity(0)
          .background(Color(hex:0xDBF7E0))
          .cornerRadius(15)
          Button(action: {}, label: { Text("")
              .frame(width: 155, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35, weight: .heavy))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          .opacity(0)
          //.background(.white)
          .cornerRadius(15)
          ForEach(0..<5) { j in
            Button(action: {}, label: { Text(letters(row: 3, letter: j))
                .frame(width: 155, height: 95)
                .foregroundColor(.black)
                .font(.system(size: 35, weight: .heavy))
                .overlay(RoundedRectangle(cornerRadius: 15)
                  .stroke(.black, lineWidth: 2)
                )
            })
            .background(.white)
            .cornerRadius(15)
          }
        }
        //.padding(/*@START_MENU_TOKEN@*/.vertical, 13.0/*@END_MENU_TOKEN@*/)
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
        HStack(spacing:13){
          Button(action: {}, label: { Text("ה")
              .frame(width: 155, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35, weight: .heavy))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          //.opacity(0)
          .background(Color(hex:0xDBF7E0))
          .cornerRadius(15)
          Button(action: {}, label: { Text("")
              .frame(width: 155, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35, weight: .heavy))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          .opacity(0)
          //.background(.white)
          .cornerRadius(15)
          HStack(spacing: 10.0) {
            ForEach(0..<6) { j in
              Button(action: {}, label: { Text(letters(vowel: j))
                  .frame(maxWidth: .infinity, maxHeight: 95)
                  .foregroundColor(.black)
                  .font(.system(size: 35, weight: .heavy))
                  .overlay(RoundedRectangle(cornerRadius: 50)
                    .stroke(.black, lineWidth: 2)
                  )
              })
              .background(Color(hex:0xFFEB99))
              .cornerRadius(50)
            }
          }
          //.padding(.vertical, 13.0)
          .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
          .frame(maxWidth: 823)
        }
        HStack(spacing: 13.0) {
          Button(action: {}, label: { Text("ע")
              .frame(width: 155, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35, weight: .heavy))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          //.opacity(0)
          .background(Color(hex:0xDBF7E0))
          .cornerRadius(15)
          Button(action: {}, label: { Text("מחק מילה")
              .frame(width: 180, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          .background(Color(hex:0xFF766E))
          .cornerRadius(15)
          Button(action: {}, label: { Text("מחק תו")
              .frame(width: 180, height: 95)
              .foregroundColor(.black)
              .font(.system(size: 35))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          .background(Color(hex:0xFF766E))
          .cornerRadius(15)
          Button(action: {}, label: { Text("רווח")
              .frame(maxWidth: .infinity, maxHeight: 95)
              .foregroundColor(.black)
              .font(.system(size: 35))
              .overlay(RoundedRectangle(cornerRadius: 15)
                .stroke(.black, lineWidth: 2)
              )
          })
          .background(Color(hex:0xCDCCF3))
          .cornerRadius(15)
          Button(action: {}, label: {
            Image(systemName: "gear")
              .resizable(capInsets: EdgeInsets(top: -8.0, leading: -8.0, bottom: -8.0, trailing: -8.0))
              .frame(width: 95, height: 95)
              .foregroundColor(.black)
              .overlay(RoundedRectangle(cornerRadius: 50)
                .stroke(.black, lineWidth: 2)
              )
          })
          .background(Color(hex:0xCCE4FF))
          .cornerRadius(50)
        }
        //.padding(/*@START_MENU_TOKEN@*/.vertical, 13.0/*@END_MENU_TOKEN@*/)
        .padding(.horizontal, 15.0)
      }
      //.padding(.vertical, 15.0)
      //.padding(.horizontal, 3)
      .frame(maxWidth:.infinity,maxHeight:.infinity)
      //.border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/5/*@END_MENU_TOKEN@*/)
      .background(Color(uiColor:UIColor.systemGray5))
    }
    .frame(
      minWidth: 0,
      maxWidth: .infinity,
      minHeight: 0,
      maxHeight: .infinity
    )
    .padding(/*@START_MENU_TOKEN@*/.horizontal, 0.0/*@END_MENU_TOKEN@*/)
    .padding(.vertical, -22.0)
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
