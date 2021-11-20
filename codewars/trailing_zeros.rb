ERROR_TEXT = "Can't find trailing zeros for a negative number".freeze

def zeros(n)
  if n < 0
    puts ERROR_TEXT
  else
    count = 0

    while n >= 5
      n /= 5
      count += n
    end
    count
  end

end

puts "#{zeros(123)} trailing zeros in the input number"
