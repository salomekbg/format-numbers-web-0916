def separate_with_comma(num)
  new_num = num.to_s
  num_length = new_num.length
  while num_length > 3
    new_num.insert(num_length -= 3, ",")
  end
  new_num
end
