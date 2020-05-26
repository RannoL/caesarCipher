def get_word
  puts "Please enter the word you wish the encrypt: "
  word = gets.chomp
end

def get_shift
  puts "Please enter the desired shift: "
  shift = gets.chomp.to_i
end

def wrap_around(word_code, type)
  case type
  when "capital"
    #90 is Z, 90%90 = 0, 91%90 = 1 so get the steps over 90. Starts from zero
    #To start from A(65) add 64 so A is included aswell and counting over starts from 64.
    return (word_code+64) % 90
  when "lowercase"
    return (word_code+96) % 122
  end
end

def cipher_word(word, shift)
  cypher_letters = []
  letters = word.split("")
  #Convert to positive count, range is 25, so counting 20 forwards is the same as 5 backwards.
  if shift < 0 
    shift += 26 #Included
  end

  letters.each do |letter|
    char_code = letter.ord
    new_char_code = char_code + shift
    
    case char_code
    #[A-Z]
    when 65..90
      if new_char_code > 90
        new_letter = wrap_around(new_char_code, "capital").chr("UTF-8")
        cypher_letters.push(new_letter)
      else
        new_letter = new_char_code.chr("UTF-8")
        cypher_letters.push(new_letter)
      end

    #[a-z]  
    when 97..122
      if new_char_code > 122
        new_letter = wrap_around(new_char_code, "lowercase").chr("UTF-8")
        cypher_letters.push(new_letter)
      else
        new_letter = new_char_code.chr("UTF-8")
        cypher_letters.push(new_letter)
      end

    else
      #Dont shift if not a letter
      cypher_letters.push(letter)
    end
  end
  puts "----------------------"
  puts "The cyphered word is: " + cypher_letters.join("")
end




cipher_word(get_word, get_shift)