module App
  module Helpers
    def development?
      env? "development"
    end

    def production?
      env? "production"
    end

    def env?(env_name)
      ENV.fetch("RACK_ENV", "development") == env_name.downcase
    end
  end
end
