class HomeController < ApplicationController
  def index
      @transactions = Transaction.latest(5)
      @transaction = Transaction.new
  end

end
