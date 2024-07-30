//// The module used to calculate the levenshtein distance

import gleam/int
import gleam/list
import gleam/result
import gleam/string

/// This function calculates the levenshtein distance.
/// It isn't case sensitive
/// 
/// ## Examples
/// 
/// ```gleam
/// glevenshtein.calculate("Gleam", "BEAM") // 2!
/// ```
/// 
/// ```gleam
/// glevenshtein.calculate("GLEAM", "Gleam") // 0!
/// ```
/// 
pub fn calculate(word1: String, word2: String) -> Int {
  let word1 = word1 |> string.lowercase()
  let word2 = word2 |> string.lowercase()

  calculate_levenshtein_distance(
    word1 |> string.to_graphemes(),
    word2 |> string.to_graphemes(),
    0,
  )
}

fn calculate_levenshtein_distance(
  word1: List(String),
  word2: List(String),
  distance: Int,
) -> Int {
  use <- filter_requirement(list.is_empty(word1), fn() { list.length(word2) })
  use <- filter_requirement(list.is_empty(word2), fn() { list.length(word1) })
  use <- filter_requirement(
    list.first(word1) |> result.unwrap("")
      == list.first(word2) |> result.unwrap(""),
    fn() {
      calculate_levenshtein_distance(
        list.drop(word1, 1),
        list.drop(word2, 1),
        distance,
      )
    },
  )

  get_operation_results(word1, word2, distance)
  |> list.reduce(int.min)
  |> result.unwrap(distance)
  |> int.add(1)
}

fn get_operation_results(
  word1: List(String),
  word2: List(String),
  distance: Int,
) -> List(Int) {
  [
    calculate_levenshtein_distance(list.drop(word1, 1), word2, distance),
    calculate_levenshtein_distance(word1, list.drop(word2, 1), distance),
    calculate_levenshtein_distance(
      list.drop(word1, 1),
      list.drop(word2, 1),
      distance,
    ),
  ]
}

fn filter_requirement(
  condition: Bool,
  return: fn() -> Int,
  apply: fn() -> Int,
) -> Int {
  case condition {
    True -> return()
    False -> apply()
  }
}
