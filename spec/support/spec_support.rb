module SpecSupport
  # Used when giving a unique name
  def timestamp!(timestamp = Time.now.to_i)
    @timestamp = timestamp
  end

  def timestamp
    @timestamp
  end

  def current_user
    @current_user
  end

  def log_in(user = create(:user), type: :request)
    @current_user = user

    case type
    when :request
      sign_in(user)
    when :system
      visit new_user_session_path
      find("#user_email").set(user.email)
      find("#user_password").set(user.password)
      first("input[type='submit']").click
    end
  end

  def log_out
    sign_out(current_user)
  end

  def json_response
    @json_response ||= JSON.parse(response.body)
  end

  # give me block return boolean
  def wait_until(wait_time = Capybara.default_max_wait_time)
    Timeout.timeout(wait_time) do
      loop until yield
    end
  end

  # for debug
  def take_screenshot
    page.save_screenshot(Rails.root.join('tmp', 'screenshots', "debug-#{Time.now.to_i}.png"))
  end
end
