class String
  def normalize
    downcase \
    .gsub(/[àáâãäåāă]/, "a") \
    .gsub(/[èéêëēĕėęě]/, "e") \
    .gsub(/[ìíîïĩīĭį]/, "i") \
    .gsub(/[òóôõöōŏő]/, "o") \
    .gsub(/[ùúûüũūŭůűų]/, "u")
        #    .gsub(/ÀÁÂÃÄÅĀĂ/, "A") \
        #.gsub(/ÈÉÊËĒĔĖĘĚ/, "E") \
        #.gsub(/ÌÍÎÏĬĪ/, "I") \
        #.gsub(/ÒÓÔÕÖŌŎŐ/, "O") \
  end

  def is_numeric?
    /^\d+$/.match(self) ? true : false
  end

  def to_search_string
    a = gsub(/[-_+]/, " ").gsub(/%20/, " ").downcase
    a.index("%") ? a : "%#{a}%"
  end

  def to_url_string
    titleize.gsub(" ", "_")
  end
end

