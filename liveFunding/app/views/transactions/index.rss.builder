xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Transactions"
    xml.description "Transactions"
    xml.link transactions_url

    for t in @transactions
      xml.item do
        xml.title t.donor.name + " to " + t.recipient.name
        xml.description t.amount
        xml.pubDate t.created_at.to_s(:rfc822)
        xml.link transaction_url(t)
      end
    end
  end
end
