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
end

