//
//  Schemas for local storage
//

import Foundation
import SwiftData

@Model
//[All images data]-----------------------------
class ImageData {
  var board1: [imageInfo] = []
  var board2: [imageInfo] = []
  var board3: [imageInfo] = []
  var board4: [imageInfo] = []
  var board5: [imageInfo] = []
  var board6: [imageInfo] = []
  init(board1: [imageInfo] = [],board2: [imageInfo] = [],board3: [imageInfo] = [],board4: [imageInfo] = [],board5: [imageInfo] = [],board6: [imageInfo] = []) {
    self.board1 = board1
    self.board2 = board2
    self.board3 = board3
    self.board4 = board4
    self.board5 = board5
    self.board6 = board6
  }
  // New Image
  func newImage(desc: String, board: String, image: Data) {
    switch board {
    case "a":
      addImage(desc: desc, image: image, newarray: &board1)
    case "b":
      addImage(desc: desc, image: image, newarray: &board2)
    case "c":
      addImage(desc: desc, image: image, newarray: &board3)
    case "d":
      addImage(desc: desc, image: image, newarray: &board4)
    case "e":
      addImage(desc: desc, image: image, newarray: &board5)
    case "f":
      addImage(desc: desc, image: image, newarray: &board6)
    default:
      addImage(desc: desc, image: image, newarray: &board1)
    }
  }
  private func addImage(desc: String, image: Data, newarray: inout [imageInfo]) {
    newarray.append(imageInfo(desc: desc, image: image))
  }
  //Update Image
  func updateDesc(desc: String, board: String, id: UUID) {
    switch board {
    case "a":
      changeDesc(desc: desc, id: id, editarray: &board1)
    case "b":
      changeDesc(desc: desc, id: id, editarray: &board2)
    case "c":
      changeDesc(desc: desc, id: id, editarray: &board3)
    case "d":
      changeDesc(desc: desc, id: id, editarray: &board4)
    case "e":
      changeDesc(desc: desc, id: id, editarray: &board5)
    case "f":
      changeDesc(desc: desc, id: id, editarray: &board6)
    default:
      changeDesc(desc: desc, id: id, editarray: &board1)
    }
  }
  private func changeDesc(desc: String, id: UUID, editarray: inout [imageInfo]) {
    for i in editarray.indices {
      if editarray[i].id == id {
        editarray[i].desc = desc
        return
      }
    }
  }
  func updateBoard(oldBoard: String, newBoard: String, id: UUID){
    let oldimage = deleteImage(board: oldBoard, id: id)
    if oldimage != nil {
      newImage(desc: oldimage!.desc, board: newBoard, image: oldimage!.image!)
    }
  }
  func deleteImage(board: String, id: UUID) -> imageInfo?{
    switch board {
    case "a":
      return removeImage(id: id, editarray: &board1)
    case "b":
      return removeImage(id: id, editarray: &board2)
    case "c":
      return removeImage(id: id, editarray: &board3)
    case "d":
      return removeImage(id: id, editarray: &board4)
    case "e":
      return removeImage(id: id, editarray: &board5)
    case "f":
      return removeImage(id: id, editarray: &board6)
    default:
      return removeImage(id: id, editarray: &board1)
    }
  }
  private func removeImage(id: UUID, editarray: inout [imageInfo]) -> imageInfo? {
    for i in editarray.indices {
      if editarray[i].id == id {
        return editarray.remove(at: i)
      }
    }
    return nil
  }
}
struct imageInfo: Codable, Identifiable {
  var id = UUID()
  var key: String
  var desc: String
  var image: Data?
  
  init(key: String = "",desc: String, image: Data? = Data()) {
    self.desc = desc
    self.image = image
    self.key = key
  }
}
