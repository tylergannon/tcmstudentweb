 filename = 'doc/Herbs.csv'
 file = File.new(filename, 'r')
 
 file.each_line("\n") do |row|
   columns = row.split(",")
   columns.map!{|v| v.gsub(/\"/, "").strip}
   
   puts columns[0]
 end
