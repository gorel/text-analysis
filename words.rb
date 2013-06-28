# Author: Logan Gore
# Date last updated: 6/19/2013
# Purpose: Get word, character, and symbol counts from a given input file


# Set up the hashes which will store the counts for all words, characters, and symbols
words = Hash.new(0)
characters = Hash.new(0)
symbols = Hash.new(0)

# Get the input file from the user
print "Input file: "
file = gets.chomp

# Read the file if it exists
if File.exist?(file)
   # Input will store the file contents, with all characters lower-cased
  input = File.read(file).downcase
else
   # otherwise exit with a "File not found" message
  abort "File not found."
end

# Start the timer which will show how long the program runs
start = Time.now

# Tell the user that the program is now analyzing the file
puts "Now analyzing file.  Timer started."

# Turn the input into an array of words by splitting on all whitespace
input = input.split(/[\s]/)

# Delete all empty strings from the input.  These result from splitting over subsequent space characters
input.delete_if(&:empty?)

# For each word in the input...
input.each do |word|
  # Generate a 'sanitized word' by removing anything that isn't a number or letter
  sanitized_word = word.gsub(/[^0-9a-z]+/i, '')
  
  # For that sanitized word, update the characters hash based on the characters found in that word
  sanitized_word.each_char {|char| characters[char] += 1 }
  
  # Update the words hash by incrementing that word's count by one
  words[sanitized_word] += 1
  
  # Generate a string of 'sanitized symbols' by removing all numbers and letters (opposite of generating the sanitized word) 
  sanitized_symbols = word.gsub(/[0-9a-z]+/i, '')
  
  # For that string of sanitized symbols, update the symbols hash based on the symbols found in the string
  sanitized_symbols.each_char {|sym| symbols[sym] += 1 }
end

# Output the contents of the words hash
puts "==========WORDS=========="
words.sort.each {|key, value| puts "#{key} : #{value}"}
puts "\n\n"

# Output the contents of the characters hash
puts "=======CHARACTERS======="
characters.sort.each {|key, value| puts "#{key} : #{value}"}
puts "\n\n"

# Output the contents of the symbols hash
puts "=========SYMBOLS========="
symbols.each {|key, value| puts "#{key} : #{value}"}
puts "\n\n"

# Output how long the program took to run, rounded to three decimal places (milliseconds)
puts "Elapsed time: #{(Time.now - start).round(3)} seconds"