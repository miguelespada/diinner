Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider(
        :auth0,
        'BBLhUOEcSMo60RljToZKPWzNClPnAOPl',
        '5qeGPCT17bqUzqANM-13_dHP26nEyw0XrVwSutrO6ZS_sbszJIgDA_nit5Xx6v2u',
        'app35743745.eu.auth0.com',
        callback_path: "/callback"
    )
  else Rails.env.production?
  provider :auth0, ENV['AUTH0_CLIENT_ID'], ENV['AUTH0_CLIENT_SECRET'], ENV['AUTH0_DOMAIN'], :callback_path => "/callback"
  end
end