class LineAnalyzer
  #* highest_wf_count - a number with maximum number of occurrences for a single word (calculated)
  #* highest_wf_words - an array of words with the maximum number of occurrences (calculated)
  #* content          - the string analyzed (provided)
  #* line_number      - the line number analyzed (provided)
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  def initialize (content, line_number)
    @content = content
    @line_number = line_number
    calculate_word_frequency
  end

  def calculate_word_frequency ()
    word_frequency = Hash.new (0)
    @highest_wf_count = 0
    @highest_wf_words = []

    @content.split.each do |word|
      if (word_frequency[word.downcase] += 1) > @highest_wf_count
        @highest_wf_count += 1
      end
    end

    word_frequency.each_pair do |word, frequency|
      if frequency == @highest_wf_count
        @highest_wf_words.push (word)
      end
    end

  end
end

class Solution

  #* analyzers - an array of LineAnalyzer objects for each line in the file
  #* highest_count_across_lines - a number with the maximum value for highest_wf_words attribute in the analyzers array.
  #* highest_count_words_across_lines - a filtered array of LineAnalyzer objects with the highest_wf_words attribute
  #  equal to the highest_count_across_lines determined previously.
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize ()
    @analyzers = []
  end

  def analyze_file ()
    line_number = 1
    File.foreach ("test.txt") do |line|
      @analyzers.push(LineAnalyzer.new(line, line_number))
      line_number += 1
    end
  end

  def calculate_line_with_highest_frequency ()
    @highest_count_across_lines = analyzers.max_by { |analyzer| analyzer.highest_wf_count }.highest_wf_count
    @highest_count_words_across_lines = []
    analyzers.select do |analyzer|
      analyzer.highest_wf_count == @highest_count_across_lines
    end.each do |analyzer|
      @highest_count_words_across_lines.push (analyzer)
    end
  end

  def print_highest_word_frequency_across_lines ()
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |object|
      puts "#{object.highest_wf_words} (appears in line #{object.line_number})"
    end
  end
end
