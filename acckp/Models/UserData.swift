//
//  Schemas for local storage
//

import Foundation
import SwiftData

@Model
//[Single user data]-----------------------------
class UserData {
  var student: String
  var stats: [dayStats]
  var boards: [Bool]
  var loggedIn: Bool = true
  var colorSet = 0
  init(student: String, stats: [dayStats] = [], boards: [Bool] = StaticData.boards_def, loggedIn: Bool = false, colorSet: Int = 0) {
    self.student = student
    self.stats = stats
    self.boards = boards
    self.loggedIn = loggedIn
    self.colorSet = colorSet
  }
  //Update stats
  func update(correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0) {
    //Today already saved
    if stats.count > 0 && stats.last?.day == getDate() {
      stats[stats.count-1] = updateDay(stats: stats.last!, correct_words: correct_words, total_letters: total_letters, typos: typos)
      print("Updating today's stats.")
    }//Today wasn't saved yet (new entry for today)
    else {
      self.stats.append(dayStats(correct_words: correct_words, total_letters: total_letters, typos: typos))
      print("Creating stats for today.")
    }
  }
  //Update boards
  func toggleBoard(index: Int = 0, state: Bool = true) { self.boards[index] = state }
  //Update colors
  func toggleColors(colorSet: Int = 0) { self.colorSet = colorSet }
  //Update name
  func renameStudent(student: String) { self.student = student }
  //Update logged in state
  func toggleLogin(state: Bool = false) { self.loggedIn = state }
  //Delete user
  func deleteStudent(student: String) { self.student = student }
  
  //Create json from data
  func fetchJSON() -> Data {
    var statsJSON: [[String: Any]] = []
    for stat in stats {
      statsJSON.append([
        "day":stat.day,
        "total_words":stat.total_words,
        "correct_words":stat.correct_words,
        "total_letters":stat.total_letters,
        "typos":stat.typos,
      ])
    }
    let json = try? JSONSerialization.data(withJSONObject: ["student":student,"stats":statsJSON], options: .prettyPrinted)
    printUser(fullPrint: true)
    return json!
  }
  
  //[Debugging]--------------------------------
  //Print data
  func printUser(fullPrint: Bool = false) {
    print("=================================================================")
    print("Student: \(student)")
    if loggedIn { print("*Logged in*") }
    print("Boards: \(boards)")
    if fullPrint {
      for stat in stats {
        print("==================")
        print("ID: \(stat.id)")
        print("Day: \(stat.day)")
        print("Total words: \(stat.total_words)")
        print("Correct words: \(stat.correct_words)")
        print("Total letters: \(stat.total_letters)")
        print("Typos: \(stat.typos)")
      }
    }
    else { print("\(stats.count) stats saved.") }
    print("=================================================================")
  }
}

//[Single day stats]-----------------------------
struct dayStats: Codable, Identifiable {
  var id = UUID()
  var day: String
  var total_words: Int
  var correct_words: Int
  var total_letters: Int
  var typos: Int
  
  init(day: String = getDate(), total_words: Int = 1, correct_words: Int, total_letters: Int, typos: Int) {
    self.day = day
    self.total_words = total_words
    self.correct_words = correct_words
    self.total_letters = total_letters
    self.typos = typos
  }
}

//[Update day stats]------------------------------
func updateDay(stats: dayStats, correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0) -> dayStats {
  let day = stats.day
  let total_words = stats.total_words + 1
  let correct_words = stats.correct_words + correct_words
  let total_letters = stats.total_letters + total_letters
  let typos = stats.typos + typos
  
  return dayStats(day: day, total_words: total_words, correct_words: correct_words, total_letters: total_letters, typos: typos)
}
