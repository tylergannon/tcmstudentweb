class StringReader
  KEY_SYMPTOM = "*"
  POSS_SYMPTOM = "-"
  START_COMMENT = "{"
  ONE_LINE_COMMENT = "/"
  END_COMMENT = "}"
  NEWLINE = "\n"
  
  DELIM = [START_COMMENT, NEWLINE, ONE_LINE_COMMENT, END_COMMENT]
  
  MULTI_LINE = :multi_line
  ONE_LINE = :one_line
  NAME = :name
  COMMENT = [MULTI_LINE, ONE_LINE]
  
  @item = ""
  @comment = nil
  @items = []
  
  def save(block)
    unless @item.strip.empty?
      @items << block.call(@item.strip, @comment.nil? ? nil : @comment.strip)
    end
    @item = ""
    @comment = nil
  end
  
  def write_items(coll, &block)
    lines = []
    coll.each do |obj|
      item, comment = block.call(obj)
      if comment.nil? || comment.empty?
        lines << item
      elsif comment.index("/") || comment.index("\n")
        lines << "#{item} {#{comment}}"
      else
        lines << "#{item} / #{comment}"
      end
    end
    lines.join("\n")
  end
  
  def read_items(str, &block)    
    @items = []
    buffer = ""
    @item = ""
    @comment = nil
    state = NAME

    str.chars.each do |char|
      if char == "/"
        @item = buffer.strip
        buffer = ""
        state = ONE_LINE
        
      elsif char == "{"
        @item = buffer.strip
        buffer = ""
        state = MULTI_LINE
      elsif char == "}"
        @comment = buffer.strip unless buffer.strip.empty?
        buffer = ""
        save(block)
        state = NAME
      elsif char == "\n"
        if state == NAME
          @item = buffer
          buffer = ""
          save(block)
        elsif state == ONE_LINE
          @comment = buffer
          buffer = ""
          save(block)
        else
          buffer << char
        end
      else
        buffer << char
      end
    end
    
    if state == ONE_LINE
      @comment = buffer
    elsif state == MULTI_LINE
      @comment = buffer
    else
      @item = buffer
    end
    save(block)
    @items
  end
  
  def self.parse_symptom(obj, symptom)
    if symptom.index(KEY_SYMPTOM) == 0
      obj.key_symptom = true
      obj.symptom_name = symptom[KEY_SYMPTOM.length..symptom.length]
    elsif symptom.index(POSS_SYMPTOM) == 0
      obj.maybe = true
      obj.symptom_name = symptom[POSS_SYMPTOM.length..symptom.length]
    else
      obj.symptom_name = symptom
    end
  end
  
  def self.decorate_symptom(obj)
    decorator = ""
    decorator = KEY_SYMPTOM if obj.key_symptom
    decorator = POSS_SYMPTOM if obj.maybe
    "#{decorator}#{obj.symptom_name}"
  end
  
end

