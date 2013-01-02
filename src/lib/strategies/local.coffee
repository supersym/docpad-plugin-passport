
# Local Strategy for Passport
# ===========================
# @abstract Passport uses what are termed strategies to authenticate requests. Strategies range from verifying a username and password, delegated authentication using OAuth or federated authentication using OpenID.
# @fileOverview Before asking Passport to authenticate a request, the strategy (or strategies) used by an application must be configured. Strategies, and their configuration, are supplied via the use() function.
# @author Supersymmetry (rob.jentzema@gmail.com)
# @see http://passportjs.org/guide/
# @version 1.0.0


# Dependency tree
# ---------------

# @requires passport [Package] The passport.js library for authentication strategies
passport = require("passport")

# @requires LocalStrategy [Package] The local authentication strategy package from passport.js
LocalStrategy = require("passport-local").Strategy

# @constructor Creates a new LocalStrategy class instance object
# @class The blueprint for the passport 'local' strategy objects
passport.use new LocalStrategy((username, password, done) ->

  # Find the user
  User.findOne

    # @param username [String] The username of the account
    # @param callback [Function] The callback with err and user
    username: username, (err, user) ->

    # @throw done [Function] A callback object with error instance parameter value
    return done(err)  if err

    # @function user [Boolean] Verifies the callback for correct username
    # @default False
    # @return done [Function] Callback function to signal incorrect username
    unless user
      return done(null, false,
        message: "Incorrect username."
      )

    # @function validPassword [Boolean] Validates the user account password callback
    # @default False
    # @return done [Function] Callback function to signal incorrect passport
    unless user.validPassword(password)
      return done(null, false,
        message: "Incorrect password."
      )

    # @return done [Object] The outer callback
    done null, user

)
