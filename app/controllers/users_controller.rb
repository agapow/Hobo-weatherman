class UsersController < ApplicationController

  hobo_user_controller

  auto_actions :all

  # TODO: make new only open to admin
end
