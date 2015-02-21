# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Prelaunchr::Application.config.secret_token = ENV["RAILS_SECRET"] || '839318b4270149f387399202ee51c49ddf0b21fb06f1e3b1ada14a8dec0fdcc54293dc9555b9604b192b01ec50de3d11ccf68966fb824477186c91cf6e290b4e'