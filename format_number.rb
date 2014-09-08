def separate_with_comma(num)
  formatted_total = num.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
end