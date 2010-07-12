module TcmStudentWeb
  module Decorations
    def self.undecorate(str)
      if str.index("*")==0
        str.delete!("*")
        "*"
      elsif str.index("-")==0
        str.delete!("-")
        "-"
      else
        "."
      end
    end
    
    def decoration=(str)
      if str=="*"
        key_symptom=true
        maybe=false
      elsif str=="-"
        key_symptom=false
        maybe=true
      else
        key_symptom=false
        maybe=false
      end
    end
    
    def decoration
      if key_symtom
        "*"
      elsif maybe
        "-"
      else
        ""
      end
    end
    
  end
end
