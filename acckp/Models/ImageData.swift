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
      addImage(desc: desc, board: board, image: image, newarray: &board1)
    case "b":
      addImage(desc: desc, board: board, image: image, newarray: &board2)
    case "c":
      addImage(desc: desc, board: board, image: image, newarray: &board3)
    case "d":
      addImage(desc: desc, board: board, image: image, newarray: &board4)
    case "e":
      addImage(desc: desc, board: board, image: image, newarray: &board5)
    case "f":
      addImage(desc: desc, board: board, image: image, newarray: &board6)
    default:
      addImage(desc: desc, board: board, image: image, newarray: &board1)
    }
  }
  func addImage(desc: String, board: String, image: Data, newarray: inout [imageInfo]) {
    newarray.append(imageInfo(key: board+String(newarray.count+1),desc: desc, image: image))
    print(board)
    print(newarray)
    print("board1")
    print(board1)
  }
  //Update Image
  func update(newDesc: String, newBoard: String, oldBoard: String, key: String) {
    var editarray = findarray(board: oldBoard).pointee
    var index = editarray.count
    for i in editarray.indices {
      if editarray[i].key == key {
        index = i
        break
      }
    }
    let image = editarray[index].image
    //Same board
    if oldBoard == newBoard{
      editarray[index]=imageInfo(key: newBoard+String(index),desc: newDesc, image: image)
    }
    //Swapping boards
    else{
      editarray.remove(at:index)
      var newarray = findarray(board: newBoard).pointee
      newarray.append(imageInfo(key: newBoard+String(newarray.count+1),desc: newDesc, image: image))
    }
  }
  //Find relevant board
  func findarray(board: String) -> UnsafeMutablePointer<[imageInfo]> {
      switch board {
      case "a":
          return UnsafeMutablePointer(&board1)
      case "b":
          return UnsafeMutablePointer(&board2)
      case "c":
          return UnsafeMutablePointer(&board3)
      case "d":
          return UnsafeMutablePointer(&board4)
      case "e":
          return UnsafeMutablePointer(&board5)
      case "f":
          return UnsafeMutablePointer(&board6)
      default:
          return UnsafeMutablePointer(&board1)
      }
  }
}
struct imageInfo: Codable, Identifiable {
  var id = UUID()
  var key: String
  var desc: String
  var image: Data?
  
  init(key: String, desc: String, image: Data? = Data()) {
    self.key = key
    self.desc = desc
    self.image = image
  }
}
