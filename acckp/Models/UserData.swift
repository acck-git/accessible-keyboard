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
  init(student: String, stats: [dayStats] = [], boards: [Bool] = StaticData.boards_def, loggedIn: Bool = false) {
    self.student = student
    self.stats = stats
    self.boards = boards
    self.loggedIn = loggedIn
  }
  //Update stats
  func update(correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0) {
    //Today already saved
    if stats.count > 0 && stats.last?.day == getDate(){
      stats[stats.count-1] = updateDay(stats: stats.last!, correct_words: correct_words, total_letters: total_letters, typos: typos)
      print("Updating today's stats.")
    }//Today wasn't saved yet (new entry for today)
    else {
      self.stats.append(dayStats(correct_words: correct_words, total_letters: total_letters, typos: typos))
      print("Creating stats for today.")
    }
  }
  //Update boards
  func toggleBoard(index: Int = 0, state: Bool = true) {
    self.boards[index] = state
    print("Updated board \(index).")
  }
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
    printUser()
    return json!
  }
  //Print data as JSON
  func printUser() {
    print("=================================================================")
    print("Student: \(student)")
    print("Boards: \(boards)")
    
    if stats.count < 0 {
      //if stats.count > 0 {
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
    //else { print("No stats saved.") }
    else { print("\(stats.count) stats saved.") }
    print("=================================================================")
  }
  //[Debugging]--------------------------------
  //Copy stats
  func fixStats(){
    let statsArr = self.stats
    self.stats = []
    for stat in statsArr {
      self.stats.append(dayStats(correct_words: stat.correct_words, total_letters: stat.total_letters, typos: stat.typos))
    }
  }
  //Insert stats
  func addStats(){
    let stat = self.stats[stats.count-1]
    self.stats=[]
    self.stats.append(dayStats(day: "2024-07-06", total_words: 4, correct_words: 1, total_letters: 10, typos: 6))
    self.stats.append(dayStats(day: "2024-07-08", total_words: 7, correct_words: 3, total_letters: 17, typos: 9))
    self.stats.append(dayStats(day: "2024-07-09", total_words: 12, correct_words: 6, total_letters: 37, typos: 14))
    self.stats.append(dayStats(day: "2024-07-11", total_words: 1, correct_words: 1, total_letters: 4, typos: 0))
    self.stats.append(dayStats(day: "2024-07-15", total_words: 2, correct_words: 1, total_letters: 7, typos: 2))
    self.stats.append(dayStats(day: "2024-07-17", total_words: 4, correct_words: 2, total_letters: 13, typos: 3))
    self.stats.append(stat)
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
