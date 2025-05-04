Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # Or restrict to ['http://localhost:3001'] if you prefer
  
      resource '*',
        headers: :any,
        methods: [:get, :post, :patch, :put, :delete, :options, :head],
        expose: ['Authorization']
    end
end
  