module PageParser

  # Provide tool functions for parsing a page
  require"open-uri"
  
  Parent_Uri = "http://www.vaalit.fi"
  Start_Uri = Parent_Uri + "/38746.htm"
  
  protected
  
  
  # 111. Get First level page, list for parties' names
  def get_party_list(my_uri)
    r = Array.new
    uri = URI.parse(my_uri)
    str = uri.read
    # Please test this regular expression in Rubular, if you don't trust me, :-)
    # Replace it if you can come out a better regular expression
    str.scan(/<a[^"|']+["|']([^"|']+)["|']\s*>([^<]+r\.p\.)/) {|w| r += [w] }
    return r
  end

  
  # 222. Get Second level page, alphabet list for names
  def get_alphabet_list(my_uri)
    r = Array.new
    uri = URI.parse(my_uri)
    str = uri.read
    # Please test this regular expression in Rubular, if you don't trust me, :-)
    # Replace it if you can come out a better regular expression
    str.scan(/<a[^"|']+["|']([^"|']+)["|']\s*>([A-Z]+\s*-\s*[A-Z]+)/) {|w| r += [w] }
    return r
  end
  
  
  # 333. Get Third level page, list for members and their PDFs
  def get_member_list(my_uri)
    r = Array.new
    uri = URI.parse(my_uri)
    str = uri.read
    # Please test this regular expression in Rubular, if you don't trust me, :-)
    # Replace it if you can come out a better regular expression
    str.scan(/<a[^"|']+["|']([^"|']+pdf)["|']\s*>([^<]+)<\/a>.+vp\./i) {|w| r += [w] }
    return r
  end
  

  # This is a test function, with which you can retrieve a list for all the members 
  # and their corresponding pdf files. Parsing start from the constant link "Start_Uri"
  # You can modify this function for formal use
  # Return Value: two dimensional array
  # r[x][0] : Link to the PDF
  # r[x][1] : Politician's Name
  # r[x][2] : Political Party
  def get_all_pdfs
    r = Array.new
    
    p_list = get_party_list(Start_Uri)
    p_list.each do |l1|
      a_list = get_alphabet_list(Parent_Uri + "/" + l1[0])
      a_list.each do |l2|
        m_list = get_member_list(Parent_Uri + "/" + l2[0])
        m_list.each do |l3|
          l3[0] = Parent_Uri + "/" + l3[0]
          l3[2] = l1[1]
          r += [l3]
        end
      end
    end

    return r
  end
  
  
end