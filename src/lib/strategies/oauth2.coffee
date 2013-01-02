
# @requires passport [Package] Dependency on the passport.js authentication library
passport = require("passport")

# @requires OAuth2Strategy [Package] Dependency on the passport strategy for OAuth2 protocol
OAuth2Strategy = require("passport-oauth").OAuth2Strategy

# @constructor Creates a new OAuth2 strategy in passport
passport.use "provider", new OAuth2Strategy(

  # @field authorizationURL [String] A web address or URL pointing to the (REST) service we like to authenticate for
  authorizationURL: "https://github.com/login/oauth/authorize"


  tokenURL: "https://github.com/login/oauth/access_token"

  clientID: "bf532f3a53390a0e8ffd"

  clientSecret: "02e70d2121129c49070af8fbc7a49fb01755561d"

  callbackURL: "https://api.github.com/login/oauth/callback"

)

, (accessToken, refreshToken, profile, done) ->

  User.findOrCreate

    id: profile.id

    name: profile.username

  , (err, user) ->

    done err, user

