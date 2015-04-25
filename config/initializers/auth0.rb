
Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider(
        :auth0,
        'ehMqgad1vB3TkYsH7qYXkVEqiBQgdrl5',
        '4zrefWQz1QFtogYRMtGLONOEc2_VtQRAyEkYS0cb6iok0cdnK4IcudFTbwo-3PEB',
        'rodcrespo.eu.auth0.com',
        callback_path: "/auth/auth0/callback"
    )
  elsif Rails.env.production?
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider(
        :auth0,
        'WQpHmQ3d6SpZXTiTz4iTPr5N8MA0QPvl',
        '1MAFjnDVaimdhM7nDUgP5vpcffUPOS8xwbIAuGCs-fPyRNh_68c44jpxfT5YAx5M',
        'espadaysantacruz.auth0.com',
        callback_path: "/auth/auth0/callback"
      )
    end
  end

end