//
//
//

import Foundation
import SwiftData

@Model
class UserData {
  @Attribute(.unique) var student: String
  @Relationship(deleteRule: .cascade) var stats: [dayStats]
  init(student: String) {
    self.student = student
    self.stats = []
  }
  func update(correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0) {
    //today already saved
    if stats.count > 0 && stats.last?.day == getDate(){
      stats.last?.update(correct_words: correct_words, total_letters: total_letters, typos: typos)
    }
    //new entry for today
    else {
      self.stats.append(dayStats(correct_words: correct_words, total_letters: total_letters, typos: typos))
    }
    print(stats.last!)
  }
}

//single entry
@Model
class dayStats {
  var day: String
  var total_words: Int
  var correct_words: Int
  var total_letters: Int
  var typos: Int
  
  init(correct_words: Int, total_letters: Int, typos: Int) {
    self.day = getDate()
    self.total_words = 1
    self.correct_words = correct_words
    self.total_letters = total_letters
    self.typos = typos
  }
  func update(correct_words: Int = 0, total_letters: Int = 0, typos: Int = 0){
    self.total_words += 1
    self.correct_words += correct_words
    self.total_letters += total_letters
    self.typos += typos
  }
}
func getDate() -> String {
  let today = Date()
  let formatter = DateFormatter()
  formatter.dateFormat = "yyyy-MM-dd"
  return formatter.string(from: today)
}
