class AddRealTransactionData < ActiveRecord::Migration
  def self.up
    Transaction.delete_all
    
    #Donations given to Ilkka Kanerva in the 2007 parliamentary elections (actual data from vaalit.fi)
    Transaction.create(:from => 'Kokoomuksen eduskuntaryhmä', :to => 'Ilkka Kanerva', :amount => 2500)
    Transaction.create(:from => 'Kokoomus-yhdistykset', :to => 'Ilkka Kanerva' ,:amount => 4300)
    Transaction.create(:from => 'Kehittyvien maakuntien Suomi ry', :to => 'Ilkka Kanerva', :amount => 10000)
    Transaction.create(:from => 'Seminaarilippumyynti', :to => 'Ilkka Kanerva', :amount => 50710)
    Transaction.create(:from => 'Lahjoitukset', :to => 'Ilkka Kanerva', :amount => 2699)
    Transaction.create(:from => 'Arpajaistuotot', :to => 'Ilkka Kanerva', :amount => 4626)
    
    #Donations given to Matti Vanhanen in the 2007 parliamentary elections (actual data from vaalit.fi)
    Transaction.create(:from => "Vaalituki yksityishenkilöiltä", :to => 'Matti Vanhanen', :amount => 4600)
    Transaction.create(:from => 'Vaalituki yrityksiltä', :to => 'Matti Vanhanen', :amount => 11200)
    Transaction.create(:from => 'Vaalituki yrityksiltä', :to => 'Matti Vanhanen', :amount => 1500)
    Transaction.create(:from => 'Keskustan Nurmijärven kunnallisjärjestö', :to => 'Matti Vanhanen', :amount => 2000)
    Transaction.create(:from => 'Nuuksion Keskustakerho ry', :to => 'Matti Vanhanen', :amount => 6000)
    Transaction.create(:from => 'Nuuksion Keskustakerho ry', :to => 'Matti Vanhanen', :amount => 10000)
    Transaction.create(:from => 'Kehittyvien maakuntien Suomi ry', :to => 'Matti Vanhanen', :amount => 10000)
    
    #Donations given to Antti Kaikkonen in the 2007 parliamentary elections (actual data from vaalit.fi)
    Transaction.create(:from => 'Vaalituki yksityishenkilöiltä', :to => 'Antti Kaikkonen', :amount => 1700)
    Transaction.create(:from => 'Seminaarilippumyynti', :to => 'Antti Kaikkonen', :amount => 13590.50)
    Transaction.create(:from => 'Tuki puoluejärjestöiltä', :to => 'Antti Kaikkonen', :amount => 2400)
    Transaction.create(:from => 'Taulumyynti', :to => 'Antti Kaikkonen', :amount => 5200)
    
    #Donations given to Eero Heinäluoma in the 2007 parliamentary elections (actual data from vaalit.fi)
    Transaction.create(:from => 'Seminaarimyyntitulo', :to => 'Eero Heinäluoma', :amount => 30930)
    Transaction.create(:from => 'Haagan Ty', :to => 'Eero Heinäluoma', :amount => 7500)
    Transaction.create(:from => 'Helsingin Kirjatyöntekijäin SD-yhdistys', :to => 'Eero Heinäluoma', :amount => 3350)
    Transaction.create(:from => 'Muut', :to => 'Eero Heinäluoma', :amount => 2700)
    Transaction.create(:from => 'Seminaarimyyntitulo', :to => 'Eero Heinäluoma', :amount => 22230)
    Transaction.create(:from => 'Materiaalimyynti', :to => 'Eero Heinäluoma', :amount => 13010)
    
  end

  def self.down
    Transaction.delete_all
  end
end
