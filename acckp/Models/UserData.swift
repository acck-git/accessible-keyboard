//
//  Schemas for local storage
//

import Foundation
import SwiftData

@Model
class UserData {
  var student: String
  var stats: String
  init(student: String, stats: String = "") {
    print("creating")
    self.student = student
    self.stats = stats
    print(self.student)
    print(self.stats)
  }
  func update(correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0) {
    //today already saved
    //if stats.count > 0 && stats.last?.day == getDate(){
      //stats[stats.count-1] = updateDay(stats: stats.last!, correct_words: correct_words, total_letters: total_letters, typos: typos)
      print("updating")
    //}
    //new entry for today
    //else {
      //self.stats.append(dayStats(correct_words: correct_words, total_letters: total_letters, typos: typos))
    //}
    //print(stats.last!)
  }
}
//single entry
struct dayStats: Codable {
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

//update single entry
func updateDay(stats: dayStats, correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0) -> dayStats {
  var day = stats.day
  var total_words = stats.total_words + 1
  var correct_words = stats.correct_words + correct_words
  var total_letters = stats.total_letters + total_letters
  var typos = stats.typos + typos
  
  var newStats = dayStats(day: day, total_words: total_words, correct_words: correct_words, total_letters: total_letters, typos: typos)
  return newStats
}
//get today's date as a string
func getDate() -> String {
  let today = Date()
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd"
  return formatter.string(from: today)
}



