# -*- coding: utf-8 -*-
require "./rfm_model.rb"

get '/create_edit' do 
  RfmModel.new.create_edit
end

get '/welcome' do
  @meat = RfmModel.new.welcome
  p @meat
  haml :welcome, :locals => {:meats => @meat}
end
