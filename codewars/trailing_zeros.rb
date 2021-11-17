# Approach:
# All factorial numbers could be simplified to prime numbers, and to calculate number of trailing zeros, it is
# needed to calculate how many times 5 (all numbers that ends wth 0 could be exactly divided by 5),
# used in simplified factorial

def zeros(n)
  if n < 0
    puts "Can't find trailing zeros for a negative number"
  else
    count = 0

    while n >= 5
      n /= 5
      count += n
    end
    puts "#{count} trailing zeros in the input number"
  end

end

zeros(123)
