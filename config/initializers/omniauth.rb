Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_SECRET'],
      scope: 'email', info_fields: 'email,name', display: 'popup',
      client_options: {
        site: 'https://graph.facebook.com/v2.8',
        authorize_url: "https://www.facebook.com/v2.8/dialog/oauth"
      }
end


# use OmniAuth::Builder do
#   provider :facebook, ENV['1813688992243617'], ENV['76df49fb61f71a92dbb05d51ae8a4bce'],
#     client_options: {
#       site: 'https://graph.facebook.com/v2.8',
#       authorize_url: "https://www.facebook.com/v2.8/dialog/oauth"
#     }
# end
