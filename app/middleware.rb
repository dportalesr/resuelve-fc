module App
  module Middleware
    def self.included(base)
      base.use Rack::Attack
      base.use Rack::Cors do
        allow do
          origins "*"
          resource "/v1/*",
            headers: :any,
            methods: %i[get post put patch delete options head]
        end
      end
      base.use Hanami::Middleware::BodyParser, :json
    end
  end
end
