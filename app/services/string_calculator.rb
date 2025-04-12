class StringCalculator
  def add(numbers)
    return 0 if numbers.empty?
    delimiter = ",|\n" # default delimiters

    if numbers.start_with?("//")
      custom_delimiter, numbers = numbers.split("\n", 2) # separating custom delimiter and numbers
      custom_delimiter = custom_delimiter[2..] # removing "//"
      delimiter = Regexp.escape(custom_delimiter)
    end

    numbers.split(/#{delimiter}/).map(&:to_i).sum
  end
end
