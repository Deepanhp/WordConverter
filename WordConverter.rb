require 'date'

class WordConverter

  def letter_comb(digits)

    #time_start = Time.now()

    #Validate entered number
    return [] if digits.nil? || digits.length != 10 || digits.split('').select{|a|(a.to_i == 0 || a.to_i == 1)}.length > 0

    letters = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q", "r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}

    #Store words in array as per word length
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

    #Split two arrays for two words with minimum of two letters per word
    for i in (1..total_number)
      first_array = keys[0..i]

      next if first_array.length < 2
      second_array = keys[i + 1..total_number]

      #Get combination of each letters 
      next if second_array.length < 2
      f_comb = first_array.shift.product(*first_array).map(&:join) 

      next if f_comb.nil?
      s_comb = second_array.shift.product(*second_array).map(&:join)

      # get common values by matching dictionary array
      next if s_comb.nil?
      results[i] = [(f_comb & dictionary[i+2]), (s_comb & dictionary[total_number - i +1])] 
    end

    #Add final words in array
    final_words = []
    results.each do |key, combinations|
      next if combinations.first.nil? || combinations.last.nil?
      combinations.first.product(combinations.last).each do |combo_words|
        final_words << combo_words
      end
    end

    #Check if we have a single 10 letter word by matching dictionary
    final_words << (keys.shift.product(*keys).map(&:join) & dictionary[11]).join(", ") 
    # time_end = Time.now()
    # puts "Time #{time_end.to_f - time_start.to_f}"
    final_words
  end
end

final_words = WordConverter.new().letter_comb("2282668687")
print final_words