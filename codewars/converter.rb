KM_IN_MILE = 1.609_344
LITER_IN_GALLON = 4.546_091_88

def converter(mpg)
  (mpg * KM_IN_MILE / LITER_IN_GALLON).round(2)
end

puts converter(36)
