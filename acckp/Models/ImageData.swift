//
//  Schemas for local storage
//

import Foundation
import SwiftData

@Model
//[Single user data]-----------------------------
class ImageData {
  var board1: [String: String]
  var board2: [String: String]
  var board3: [String: String]
  var board4: [String: String]
  var board5: [String: String]
  var board6: [String: String]
  var maxIndex: [Int]
  init(board1: [String: String] = [:],board2: [String: String] = [:],board3: [String: String] = [:],board4: [String: String] = [:],board5: [String: String] = [:],board6: [String: String] = [:], maxIndex: [Int] = [0,0,0,0,0,0]) {
    self.board1 = board1
    self.board2 = board2
    self.board3 = board3
    self.board4 = board4
    self.board5 = board5
    self.board6 = board6
    self.maxIndex = maxIndex
  }
  //Update stats
  func update(newDesc: String, newBoard: String, oldBoard: String, index: Int) {
    var (editarray, _) = findarray(board: oldBoard)
    if oldBoard == newBoard{
      editarray[newBoard+String(index)] = newDesc
    }
    else{
      editarray[oldBoard+String(index)] = nil
      var (newarray, newindex) = findarray(board: newBoard)
      maxIndex[newindex]+=1
      newarray[newBoard+String(maxIndex[newindex])] = newDesc
    }
  }
  func findarray(board: String) -> ([String:String], Int){
    switch board{
    case "a":
      return (board1, 0)
    case "b":
      return (board2, 1)
    case "c":
      return (board3, 2)
    case "d":
      return (board4, 3)
    case "e":
      return (board5, 4)
    case "f":
      return (board6, 5)
    default:
      return (board1, 0)
    }
  }
  
}
