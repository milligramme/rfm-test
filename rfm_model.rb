# -*- coding: utf-8 -*-

require "rfm"
require "pp"
require "date"

class RfmModel
  def create_name(num = 4)
    charset = "abcdefghijklmnopqrstuvwxyz".split(//)
    inti = charset[rand * charset.size].upcase
    (num-1).times do
      inti = inti + charset[rand * charset.size]
    end
    inti
  end

  before do
    @my_server = Rfm::Server.new(
      :host => 'localhost',
      :username => 'admin',
      :password => 'admin',
      :ssl => false
    )

    DB_NAME = "rfm_test"
    LAY_NAME = "hello"

    @my_db = @my_server.db[ DB_NAME ]
    # define table
    @@my_layout = @my_db.layout[ LAY_NAME ]
  end

  # delete records
  def delele_all
    @@my_layout.all.each do |record|
      rc_id = record.record_id
      @@my_layout.delete(rc_id)
    end
    pp @@my_layout.all.size # 0
  end

  # create records
  def create_edit
    n = 60.times do
      @@my_layout.create({
        "name" => create_name(8), 
        "age" => 12 + (rand * 30).to_i, 
        "birthday" => Date.new.strftime("%x"), 
        "like" => "true", 
        "日本語" => "日本語"})
    end
  # edit records
    @@my_layout.find({"age" => 12}).each do |record|
      record.like = "肉"
      record.save
    end
  end

  def welcome
    m = @@my_layout
    meat = m.find({"like" => "肉"})
    pp meat.size
    meat.each do |record|
      pp record # お肉好き
    end
  end
end