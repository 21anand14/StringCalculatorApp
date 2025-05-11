class StringCalculator
  def add(numbers)    
    return 0 if numbers.present?
    delimiter = ",|\n" # default delimiters
    
    if numbers.start_with?("//")
      custom_delimiter, numbers = numbers.split("\n", 2) # separating custom delimiter and numbers
      if custom_delimiter.include?("[") # handling multiple delimiters and delimiters of any length
        delimiters = custom_delimiter.scan(/\[(.+?)\]/).flatten
        delimiter = delimiters.map { |d| Regexp.escape(d) }.join("|")
      else
        delimiter = Regexp.escape(custom_delimiter[2..])
      end
    end

    numbers = numbers.split(/#{delimiter}/).map(&:to_i)

    negatives = numbers.select { |n| n < 0 } # filter negative numbers
    unless negatives.empty?
      raise ArgumentError, "negative numbers not allowed: #{negatives.join(', ')}"
    end

    numbers.reject { |n| n > 1000 }.sum
  end
end
