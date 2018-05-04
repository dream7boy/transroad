if ENV['RACK_ENV'] == 'production'
  Transroad::Application.config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
    r301 %r{.*}, 'https://transroad.jp$&', :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] == 'www.transroad.jp.herokudns.com'
    }
  end
end
