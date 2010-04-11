module CountriesHelper
  def number_humanize(number,measurement)
    sign =""
    if number < 0
      sign = "-"
      number = -number
    end
    
    if number > 1000000000000
      result = "<td class=\"digits\">#{sign}#{number_with_precision(number/1000000000000, :precision => 2)}</td><td>trillions of #{measurement}</td>"
    elsif number > 1000000000
        result = "<td class=\"digits\">#{sign}#{number_with_precision(number/1000000000,:precision => 2)}</td><td>milliards of #{measurement}</td>"
    elsif number > 1000000
      result = "<td class=\"digits\">#{sign}#{number_with_precision(number/1000000,:precision => 2)}</td><td>millions of #{measurement}</td>"
    else
      result = "<td class=\"digits\">#{sign}#{number_with_precision(number,:precision => 2)}</td><td>#{measurement}</td>"
    end
    
    return result
  end
end
