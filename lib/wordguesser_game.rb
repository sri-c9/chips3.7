class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(new_word)
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    if letter.nil? || letter.empty? || !letter.match?(/[[:alpha:]]/)
      raise ArgumentError 
    end

    letter.downcase!

    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end

    if @word.include?(letter)
      @guesses += letter
      return true
    else
      @wrong_guesses += letter
      return true
    end
  end

  def word_with_guesses
    @word.chars.map{|letter|@guesses.include?(letter) ? letter : '-'}.join
  end

  def check_win_or_lose
    if all_chars_present?(@word, @guesses)
      return :win
    elsif @wrong_guesses.length >= 7
      return :lose
    else
      return :play
    end
  end

  def all_chars_present?(str1, str2)
    str1.chars.all? { |char| str2.include?(char) }
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
