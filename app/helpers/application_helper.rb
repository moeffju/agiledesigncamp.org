module ApplicationHelper
  def participants_header(arr, k, t)
    if arr.include? k
      "#{t} (#{arr[k].size})"
    else
      t
    end
  end
end
