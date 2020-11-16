require 'open-uri'

class GamesController < ApplicationController

  LETTERS = (('a'..'z').to_a * 5).sample(10)

  def new
    @letters = LETTERS
    @word = params[:word]
  end

  def score
    @word = params[:word]
    api_word = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)
    if (LETTERS & @word.chars).sort != @word.chars.sort
      @result = "Sorry, #{@word} can't be build out of #{LETTERS}."
    elsif api_word['found'] == false
      @result = "Sorry, #{@word} is not a valid English word."
    else
      @result = "Congratulations! #{@word} is a valid English word."
    end
  end
end
