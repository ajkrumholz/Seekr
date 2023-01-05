
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000', 'https://seekr-mk2.fly.dev/', 'https://seekr-wine.vercel.app/'
    resource '*', headers: :any, methods: [:get, :post, :patch, :put]
  end
end