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
    //Update stats
  func update(newDesc: String, newBoard: String, oldBoard: String, index: Int) {
    var editarray = findarray(board: oldBoard)
    //Same board
    if oldBoard == newBoard{
      editarray[index]=imageInfo(key: newBoard+String(index),desc: newDesc)
    }
    //Swapping boards
    else{
      editarray.remove(at:index)
      var newarray = findarray(board: newBoard)
      newarray.append(imageInfo(key: newBoard+String(newarray.count+1),desc: newDesc))
    }
  }
  //Find relevant board
   func findarray(board: String) -> ([imageInfo]){
    switch board{
    case "a":
      return board1
    case "b":
      return board2
    case "c":
      return board3
    case "d":
      return board4
    case "e":
      return board5
    case "f":
      return board6
    default:
      return board1
    }
  }
}
struct imageInfo: Codable, Identifiable {
  var id = UUID()
  var key: String
  var desc: String
  
  init(key: String, desc: String) {
    self.key = key
    self.desc = desc
  }
}
