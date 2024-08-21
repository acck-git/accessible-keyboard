//
//  Images View
//

import SwiftUI
import SwiftData
import PhotosUI

struct ImagesView: View {
  @Environment(\.modelContext) private var ModelContext
  @ObservedObject var gVars = GlobalVars.get()
  //[Images]-----------------------------------
  @State var set: String = "a"
  @State var subSet: Int = 0
  @State var newImageName: String = ""
  @State var newImageSet: String = "a"
  @State var confirmImage: Bool = false
  @State var boardNames = StaticData.boardNames
  @State var currboard: [imageInfo] = StaticData.imgDesc1
  @State var tempboard: [imageInfo] = []
  @State var currImage: String = ""
  @State var pickedNewPhoto: PhotosPickerItem?
  @State var pickedNewPhotoData: Data?
  var NilData = Data()
  var vowelsRow: [[String]] = StaticData.vowelsRow.reversed()
  var sets: [String] = StaticData.sets
  //-------------------
  init () {
    if gVars.images != nil {
      _currboard = State(wrappedValue: gVars.imageBoard1)
    }
    _tempboard = State(wrappedValue: Array(currboard[0..<6]))
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
            if pickedNewPhotoData != nil {
              pickedNewPhotoData = nil
            }
            else {
              confirmImage = true
            }
          })
          .confirmationDialog("לא ניתן לבטל פעולה זו. המשך?", isPresented: $confirmImage) {
            Button("מחק", role: .destructive) {
            }} message: {
              Text("לא ניתן לבטל פעולה זו. המשך?")
            }
          //-------------------
          PlainButton(text: "שמור", action: {
            if pickedNewPhotoData != nil {
              gVars.images.newImage(desc: newImageName, board: newImageSet, image: pickedNewPhotoData!)
            }
            else {
              gVars.images.update(newDesc: newImageName, newBoard: newImageSet, oldBoard: set, key: currImage)
            }
            gVars.loadImages()
            currImage = ""
            newImageName = ""
            subSet = 0
            set = "a"
            currboard = gVars.fetchImages(set: set)
            tempboard = Array(currboard.prefix(6))
            newImageSet = "a"
            pickedNewPhoto = nil
            pickedNewPhotoData = nil
          })
          //-------------------
          ImageEditInput(placeholder: "", text: $newImageName)
          Text("תיאור:")
            .lineLimit(1)
            .foregroundColor(Color(hex:StaticData.text_col[0]))
            .font(.system(size: 20, weight: .heavy))
          //-------------------
          BoardPickerImages(onChange: {
          },selectedBoard: $newImageSet)
          Text("לוח:")
            .lineLimit(1)
            .foregroundColor(Color(hex:StaticData.text_col[0]))
            .font(.system(size: 20, weight: .heavy))
        }.frame(height: 50)
          .disabled( (currImage != "" || pickedNewPhotoData != nil) ? false : true)
          .opacity ( (currImage != "" || pickedNewPhotoData != nil) ? 1 : 0.5)
        HStack{
          if pickedNewPhotoData == nil {
            ArrowButtonSmall(image: "arrowtriangle.left.fill",action: {
              subSet = subSet+6 >= currboard.count ? 0 : subSet+6
              tempboard = Array(currboard.suffix(currboard.count - subSet).prefix(6))
            })
            VStack(spacing:20) {
              HStack(spacing: 20) {
                ForEach((0..<3).reversed(), id: \.self) { i in
                  if i < tempboard.count {
                    if tempboard[i].image != NilData{
                      ImageButtonNew(image: tempboard[i].image!, selected: currImage == tempboard[i].key, action: {
                        newImageName = tempboard[i].desc
                        currImage = tempboard[i].key
                      })
                    }
                    else {
                      ImageButton(image: tempboard[i].key, selected: currImage == tempboard[i].key, action: {
                        newImageName = tempboard[i].desc
                        currImage = tempboard[i].key
                      })
                    }
                  }
                  else{
                    HStack{}
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                      .border(Color.black)
                  }
                }
              }
              HStack(spacing: 20) {
                ForEach((3..<6).reversed(), id: \.self) { i in
                  if i < tempboard.count {
                    if tempboard[i].image != NilData{
                      ImageButtonNew(image: tempboard[i].image!, selected: currImage == tempboard[i].key, action: {
                        newImageName = tempboard[i].desc
                        currImage = tempboard[i].key
                      })
                    }
                    else {
                      ImageButton(image: tempboard[i].key, selected: currImage == tempboard[i].key, action: {
                        newImageName = tempboard[i].desc
                        currImage = tempboard[i].key
                      })
                    }
                  }
                  else{
                    HStack{}
                      .frame(maxWidth: .infinity, maxHeight: .infinity)
                      .border(Color.black)
                  }
                }
              }
              HStack(spacing: 20){
                ForEach(vowelsRow.indices, id:\.self) { index in
                  BoardButton(image: vowelsRow[index][0], action: {
                    subSet = 0
                    set = sets[vowelsRow.count - index - 1]
                    currboard = gVars.fetchImages(set: set)
                    tempboard = Array(currboard.prefix(6))
                  }, selected: sets[vowelsRow.count - index - 1] == set)
                }
              }
              .frame(height: StaticData.screenheight/9)
            }
            .padding(.horizontal, 20)
            ArrowButtonSmall(image: "arrowtriangle.right.fill",action: {
              if subSet-6 < 0 {
                subSet = currboard.count - ((currboard.count)%6)
                if subSet == currboard.count {
                  subSet = currboard.count - 6
                }
              }
              else { subSet -= 6 }
              tempboard = Array(currboard.suffix(currboard.count - subSet).prefix(6))
            })
          }
          else {
            if let pickedNewPhotoData,
               let uiImage = UIImage(data: pickedNewPhotoData) {
              Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
            }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
        .overlay(RoundedRectangle(cornerRadius: 15)
          .stroke(Color(hex:StaticData.text_col[0]), lineWidth: 2))
      }
      //[Bottom row]--------------------------
      HStack(spacing: 15){
        HiddenButton().frame(width: 95)
        HiddenButton()
        PhotosPicker(selection: $pickedNewPhoto, matching: .images, photoLibrary: .shared()) {
          TextButton(text: "הוסף תמונה חדשה")
        }
        HiddenButton()
        BackButton(image: "arrowshape.right", action: {
          gVars.screen = GlobalVars.screens.teacher})
      }
      .frame(height: StaticData.screenheight/9)
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    .padding(.vertical, 10)
    .padding(.horizontal, 20)
    .background(Color(hex:StaticData.bg2_col[0]))
    .task ( id: pickedNewPhoto) {
      if let data = try? await pickedNewPhoto?.loadTransferable(type: Data.self) {
        pickedNewPhotoData = data
        currImage = ""
        newImageName = ""
        subSet = 0
        set = "a"
        currboard = gVars.fetchImages(set: set)
        tempboard = Array(currboard.prefix(6))
        newImageSet = "a"
        pickedNewPhoto = nil
      }
    }
    //.alert(alertMessage, isPresented: $alert, actions: {})
  }
}

#Preview {
  ImagesView()
}
