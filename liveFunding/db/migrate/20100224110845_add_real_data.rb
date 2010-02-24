class AddRealData < ActiveRecord::Migration
  def self.up
    Entity.delete_all
    
    Entity.create(:name => 'Matti Vanhanen', :email => 'matti.vanhanen@eduskunta.fi', :description => 'Pääministeri', 
      :is_organization => 'false', :phone_number => '+358501234567', :leader => 'None')
      
    Entity.create(:name => 'Keskusta', :email => 'keskusta@keskusta.fi', :description => 'Keskusta-puolue',
     :is_organization => 'true', :phone_number => '000', :leader => 'Matti Vanhanen')
     
    Entity.create(:name => 'Ilkka Kanerva', :email => 'ilkka.kanerva@eduskunta.fi', :description => 'Kokoomuksen kansanedustaja',
     :is_organization => 'false', :phone_number => '+358501234567', :leader => 'None')
     
    Entity.create(:name => 'Kokoomus', :email => 'kokoomus@kokoomus.fi', :description => 'Kokoomus-puolue',
     :is_organization => 'true', :phone_number => '000', :leader => 'Jyrki Katainen')
     
    Entity.create(:name => 'Antti Kaikkonen', :email => 'antti.kaikkonen@eduskunta.fi', :description => 'Keskustan kansanedustaja', 
     :is_organization => 'false', :phone_number => '000', :leader => 'None')
     
    Entity.create(:name => 'Eero Heinäluoma', :email => 'eero.heinaluoma@eduskunta.fi', :description => 'SDP:n kansanedustaja',
     :is_organization => 'false', :phone_number => '000', :leader => 'None')
     
    Entity.create(:name => 'SDP', :email => 'sdp@sdp.fi', :description => 'Sosiaal-demokraattinen puolue',
     :is_organization => 'true', :phone_number => '000', :leader => 'Jutta Urpilainen')
  end

  def self.down
    Entity.delete_all
  end
end
