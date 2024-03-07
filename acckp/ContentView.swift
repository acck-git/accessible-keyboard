//
//  ContentView.swift
//  acckp
//
//  Created by akp sce on 26/02/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  var body: some View {
    VStack {
      
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
        
        TextField("היי", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
          .textFieldStyle(.roundedBorder)
          .multilineTextAlignment(.trailing)
          .font(.system(size: 40))
        
      }
      .padding(/*@START_MENU_TOKEN@*/.all, 20.0/*@END_MENU_TOKEN@*/)
      
      VStack {
        HStack(spacing: 13.0) {
          
          ForEach(0..<7) { i in
            Button(action: {}, label: { Text("text")
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
        .padding(/*@START_MENU_TOKEN@*/.vertical, 13.0/*@END_MENU_TOKEN@*/)
        .padding(/*@START_MENU_TOKEN@*/.horizontal, 3.0/*@END_MENU_TOKEN@*/)
      }
      .background(Color(uiColor:UIColor.systemGray5))
    }
  }
}

#Preview {
  ContentView()
    .modelContainer(for: Item.self, inMemory: true)
}
