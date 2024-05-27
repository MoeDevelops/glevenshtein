import gleeunit
import gleeunit/should
import glevenshtein

pub fn main() {
  gleeunit.main()
}

pub fn calculate_car_car_test() {
  glevenshtein.calculate("car", "car")
  |> should.equal(0)
}

pub fn calculate_car_bar_test() {
  glevenshtein.calculate("car", "bar")
  |> should.equal(1)
}

pub fn calculate_hat_can_test() {
  glevenshtein.calculate("car", "bar")
  |> should.equal(1)
}

pub fn calculate_gleam_erlang_test() {
  glevenshtein.calculate("gleam", "erlang")
  |> should.equal(5)
}

pub fn calculate_gleam_elixir_test() {
  glevenshtein.calculate("gleam", "elixir")
  |> should.equal(5)
}

pub fn calculate_empty_car_test() {
  glevenshtein.calculate("", "car")
  |> should.equal(3)
}

pub fn calculate_car_empty_test() {
  glevenshtein.calculate("car", "")
}

pub fn calculate_car_car_upper_test() {
  glevenshtein.calculate("car", "CAR")
  |> should.equal(0)
}
