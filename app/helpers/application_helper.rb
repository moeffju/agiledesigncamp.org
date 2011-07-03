module ApplicationHelper
  def participants_header(arr, k, t)
    if arr.include? k
      "#{t} (#{arr[k].size})"
    else
      t
    end
  end
  
  def token_link(token)
    case token.provider
    when 'facebook'
      token.data['user_info']['urls']['Facebook']
    when 'twitter'
      token.data['user_info']['urls']['Twitter']
    end
  end
end
