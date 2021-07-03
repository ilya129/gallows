require 'colorize'

class ConsoleInterface
  FIRGURES =
    Dir[__dir__ + '/../data/figures/*.txt'].
    sort.
    map { |file_name| File.read(file_name) }

  def initialize(game)
    @game = game
  end

  def print_out
    game_errors = "(#{@game.errors_made}):"

    puts <<~END
      #{'Слово:'.colorize(:blue)} #{word_to_show.colorize(:blue)}
      #{firgure.colorize(:yellow)}
      #{'Ошибки'.colorize(:red)} #{game_errors.colorize(:red)} #{errors_to_show.colorize(:red)}
      У вас осталось ошибок: #{@game.errors_allowed}

    END

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}"
    end
  end

  def firgure
    FIRGURES[@game.errors_made]
  end

  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter.nil?
          "__"
        else
          letter
        end
      end
      result.join(' ')
  end

  def errors_to_show
    @game.errors.join(', ')
  end

  def get_input
    print "Введите следующую букву: "
    letter = gets[0].downcase
    letter
  end
end
