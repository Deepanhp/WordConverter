require 'date'

class WordConverter

  def letter_comb(digits)

    letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}

    dictionary = {}
    for i in (1..30)
      dictionary[i] = []
    end
    file_path = "/Users/mybataz/Downloads/dictionary.txt"
    File.foreach( file_path ) do |word|
      dictionary[word.length] << word.chop.to_s.downcase
    end

    keys = digits.chars.map{|digit|letters[digit]}

    results = {}
    total_number = keys.length - 1 

    first_array = keys[0..total_number]
    first_combination = first_array.shift.product(*first_array).map(&:join)
    print first_combination
  end

end

final_words = WordConverter.new().letter_comb("2282668687")
print final_words