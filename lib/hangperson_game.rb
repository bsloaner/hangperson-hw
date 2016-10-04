class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word , :guesses, :wrong_guesses , :check_guess

  def initialize(word)
    @word = word
    @guesses = '' 
    @wrong_guesses= ''
  end 
  
  def guess(new_guess)
    if new_guess == nil
      raise ArgumentError.new("empty String")
    end
    if new_guess !~ /[a-zA-Z]/
      raise ArgumentError.new("not a letter bro")
    end
    if new_guess.length == 0 
      raise ArgumentError.new("Enter a letter atleast")
    end
    
    new_guess.downcase!
    
    if @word.include?(new_guess)   #if guess is included in correct word
      if @guesses.include?(new_guess) #return false if already guessed
        return false
      else
        @guesses << new_guess    #if it has not been guessed, add to guessed
      end
      elsif @wrong_guesses.include?(new_guess) #return false if its wrongly guess and not guessed
        return false
      else
        @wrong_guesses << new_guess
    end
  end
  
  def word_with_guesses
    output = ''    #create empty string for output display
    
    @word.split("").each do |char|
      if @guesses.include? char
        output += char
      else
        output += '-'
      end
    end
    return output
  end
 
 
  def check_win_or_lose
    
    if @wrong_guesses.length >= 7  #if guesses exceeds 7, you loose
        :lose
    elsif word_with_guesses == @word #if your word is equal to the answer, you win
         :win
    else
         :play  #else continue playing
    end
  end

  
       
      
    

  

  # def initialize()
  # end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
