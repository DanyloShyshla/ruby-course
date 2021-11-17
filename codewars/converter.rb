MILE_TO_KM = 1.609344
GALLON_TO_LITER = 4.54609188

def converter(mpg)
  kpl = ((mpg * MILE_TO_KM)/GALLON_TO_LITER).round(2)
  puts kpl
end

converter(36)
