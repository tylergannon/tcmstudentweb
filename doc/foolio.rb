


def self.write(s)
	file = File.new("/home/tyler/Projects/tcm_student_web/log/formulas_log.txt", "a")
	file.write("#{s}\n")
end

write "Lame"
write "Sucks!"

