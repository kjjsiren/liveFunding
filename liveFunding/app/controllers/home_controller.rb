class HomeController < ApplicationController

  require 'rss'
  require 'open-uri'

  def index
      @transactions = Transaction.latest(5)
      @transaction = Transaction.new
  end

  def about
 
  end
end
