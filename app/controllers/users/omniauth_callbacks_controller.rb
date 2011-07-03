# Monkey see, monkey patch
class Hash
  def recursive_find_by_key(key)
    stack = [self]
    while (to_search = stack.pop)
      to_search.each do |k, v|
        return v if k == key
        stack << v if v.respond_to?(:recursive_find_by_key)
      end
    end
  end
end

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def method_missing(provider)
    return if User.omniauth_providers.index(provider).nil?
    omniauth = env["omniauth.auth"]

    if current_user or User.find_by_email(omniauth.recursive_find_by_key("email"))
      current_user.tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      flash[:notice] = "Authentication successful"
      redirect_to edit_user_registration_path
    else
      authentication = Token.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
      if authentication
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
        sign_in_and_redirect(:user, authentication.user)
      else
        unless omniauth.recursive_find_by_key("email").blank?
          user = User.find_or_initialize_by_email(:email => omniauth.recursive_find_by_key("email"))
        else
          user = User.new
        end

        user.apply_omniauth(omniauth)

        if user.save
          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          sign_in_and_redirect(:user, user)
        else
          session[:omniauth] = omniauth.except('extra')
          redirect_to new_user_registration_url
        end
      end
    end
  end
end
