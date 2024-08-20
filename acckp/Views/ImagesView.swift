//
//  Images View
//

import SwiftUI
import SwiftData

struct ImagesView: View {
  @Environment(\.modelContext) private var ModelContext
  @ObservedObject var gVars = GlobalVars.get()
  //[Images]-----------------------------------
  @State var set: String = "a"
  @State var subSet: Int = 0
  @State var newImageName: String = ""
  @State var confirmImage: Bool = false
  @State var boardNames = StaticData.boardNames
  @State var board1: [(String,String)] = []
  @State var board2: [(String,String)] = []
  @State var board3: [(String,String)] = []
  @State var board4: [(String,String)] = []
  @State var board5: [(String,String)] = []
  @State var board6: [(String,String)] = []
  var sets: [String] = StaticData.sets
  //-------------------
  init () {
    if gVars.images != nil {
      _board1 = State(wrappedValue: gVars.imageBoard1)
      _board2 = State(wrappedValue: gVars.imageBoard2)
      _board3 = State(wrappedValue: gVars.imageBoard3)
      _board4 = State(wrappedValue: gVars.imageBoard4)
      _board5 = State(wrappedValue: gVars.imageBoard5)
      _board6 = State(wrappedValue: gVars.imageBoard6)
    }
  }
  var body: some View {
    //[Teacher container]----------------------
    VStack(spacing:20) {
      //Adding Images
      VStack(spacing:20){
        Text("מאגר תמונות")
          .lineLimit(1)
          .foregroundColor(Color(hex:StaticData.text_col[0]))
          .font(.system(size: 25, weight: .heavy))
        //-------------------
        HStack(spacing: 15) {
          //-------------------
          DeleteTeacherButton(text: "מחק", action: {
          })
          .confirmationDialog("לא ניתן לבטל פעולה זו. המשך?", isPresented: $confirmImage) {
            Button("מחק", role: .destructive) {
              
            }} message: {
              Text("לא ניתן לבטל פעולה זו. המשך?")
            }
          //-------------------
          SaveButton(text: "שמור", action: {
            
          })
          //temp
          //-------------------
          ImageEditInput(placeholder: "", text: $newImageName)
          //----
          Text("תיאור:")
            .lineLimit(1)
            .foregroundColor(Color(hex:StaticData.text_col[0]))
            .font(.system(size: 20, weight: .heavy))
          //-------------------
          //temp
          BoardPickerImages(array: boardNames, onChange: {
          },selectedBoard: $set)
          //----
          Text("לוח:")
            .lineLimit(1)
            .foregroundColor(Color(hex:StaticData.text_col[0]))
            .font(.system(size: 20, weight: .heavy))
        }.frame(height: 50)
        HStack{
          ArrowButtonSmall(image: "arrowtriangle.left.fill",action: {
            subSet = subSet+6 > 6 ? 0 : subSet+6
          })
          VStack(spacing:20) {
            HStack(spacing: 20) {
              ForEach((1...3).reversed(), id: \.self) { i in
                if i == 1{
                  ImageButtonNew(image: "plus.circle", action: {})
                }
                else{
                  ImageButton(image: set+String(subSet+i), action: {
                    newImageName = StaticData.imgDesc[set+String(subSet+i)] != nil ? StaticData.imgDesc[set+String(subSet+i)]! : ""
                  })
                }
              }
            }
            HStack(spacing: 20) {
              ForEach((4...6).reversed(), id: \.self) { i in
                ImageButton(image: set+String(subSet+i), action: {
                  newImageName = StaticData.imgDesc[set+String(subSet+i)] != nil ? StaticData.imgDesc[set+String(subSet+i)]! : ""
                })
              }
            }
          }
          //.frame(maxHeight: .infinity)
          .padding(.horizontal, 20)
          ArrowButtonSmall(image: "arrowtriangle.right.fill",action: {
            subSet = subSet-6 < 0 ? 6 : subSet-6
          })
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .overlay(RoundedRectangle(cornerRadius: 15)
        .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
    }
    //[Bottom row]--------------------------
    HStack(){
      HiddenButton().frame(maxWidth:.infinity)
      SettingsButton(image: "arrowshape.right", action: {
        gVars.screen = GlobalVars.screens.settings})
    }
    .frame(height: StaticData.screenheight/9)
  }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
    .background(Color(hex:StaticData.bg2_col[0]))
    //.alert(alertMessage, isPresented: $alert, actions: {})
  }
}

#Preview {
  ImagesView()
}
