class Game
  NUM_GUESSES = 10
  RANGE = 1..100
  DEFAULT_PROMPT = "Your guess? > "

  def initialize
    @guess_count = 0
    @last_guess = -1
    @hint = ""
    @next_prompt = DEFAULT_PROMPT
  end

  def start
    @correct_num = rand(RANGE)
    loop do
      display_header
      you_win if is_guess_right?(prompt_user)
      is_game_over? ? game_over : @guess_count += 1
    end
  end

  def prompt_user
    puts center_message("I'm thinking of a number between 1 and 100", " ")
    puts center_message("Number of guesses left: #{NUM_GUESSES - @guess_count}"," ")
    @guess_count > 0 ? (puts center_message("Last guess: #{@last_guess}"," ")) : (puts " ")
    @guess_count > 0 ? (puts center_message("Hint: #{@hint}"," ")) : (puts " ")
    puts " "
    print @next_prompt
    guess = gets.chomp.to_i
    if RANGE.member?(guess)
      if guess == @last_guess
        @next_prompt = "What a waste.  Next guess? > "
      else
        @next_prompt = DEFAULT_PROMPT
      end
    else
      @next_prompt = "Your positive non-zero integer guess that is less than 101? > "
    end
    guess
  end

  def is_guess_right?(guess)
    is_guess_right = false
    if RANGE.member?(guess) && guess != @last_guess
      case
      when guess > @correct_num
        if guess > @last_guess
          case @hint
          when "too high"
            @hint = "I said TOO HIGH"
          when "I said TOO HIGH"
            @hint = "I give up, enjoy"
          when "I give up, enjoy"
            @hint
          else
            @hint = "too high"
          end
        else
          @hint = "too high"
        end
      when guess < @correct_num
        if guess < @last_guess
          case @hint
          when "too low"
            @hint = "I said TOO LOW"
          when "I said TOO LOW"
            @hint = "I give up, enjoy"
          when "I give up, enjoy"
            @hint
          else
            @hint = "too low"
          end
        else
          @hint = "too low"
        end
      else
        is_guess_right = true
      end
    else
      @hint = "hope you remembered"
    end
    @last_guess = guess
    is_guess_right
  end

  def is_game_over?
    @guess_count >= NUM_GUESSES - 1 ? true : false
  end


  def center_message(message,pad_char)
    width = `tput cols`.chomp.to_i
    padding = width / 2 -  (message.length / 2)
    if message.length.even?
      pad_char * padding + message + pad_char * padding
    else
      pad_char * padding + message + pad_char * (padding - 1)
    end
  end

  def display_header
    system("clear")
    3.times { puts center_message("", "#") }
              puts center_message("  " + "~" * 13 + "  ", "#")
              puts center_message(" ( Welcome to... ) ", "#")
              puts center_message(" )     THE     ( ", "#")
              puts center_message(" ( GUESSING GAME ) ", "#")
              puts center_message("  " + "~" * 13 + "  ", "#")
    3.times { puts center_message("", "#") }
  end

  def you_win
    system("clear")
    message = "Y O U * W I N".split("")
    puts center_message("","*")
    message.each { |letter| puts center_message(message * "", letter) }
    puts center_message("","*")
    exit
  end

  def game_over
    system("clear")
    message = "Y O U * L O S E".split("")
    puts center_message("","*")
    message.each { |letter| puts center_message(message * "", letter) }
    puts center_message("","*")
    exit
  end

end

Game.new.start
