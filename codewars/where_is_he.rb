def where_is_he(people_in_line, people_before, people_after)
  puts [people_in_line - people_before, people_after + 1].min
end

where_is_he(5, 2, 3)
