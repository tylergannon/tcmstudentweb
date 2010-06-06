def write_page(p, pdf, &block)
  pdf.define_grid(:columns => 3, :rows => 4, :gutter => 4)
  4.times do |i|
    3.times do |j|
      b = pdf.grid(i,j)
      pdf.bounding_box b.top_left, :width => b.width, :height => b.height do
        yield(p[i][j]) unless p[i][j].nil?
        pdf.stroke do
          pdf.rectangle(pdf.bounds.top_left, b.width, b.height)
        end
      end
    end
  end
end

while !(qpage = @q.shift).nil?
  apage = @a.shift

  write_page(qpage, pdf) do |item|
    pdf.move_down (pdf.bounds.height/2.2)
    pdf.text item, :align => :center, :size => 15
  end

  pdf.start_new_page

  title_ht = 15.mm
  title_full_ht = 15.mm
  herbs_width = 25.mm
  margin = 3
  symptoms_x = herbs_width + margin*2

  write_page(apage, pdf) do |f|

    if !(fp = f.formula_patterns[0]).nil?
      pdf.text_box fp.pattern.name, :size => 11, :style=>:bold, \
        :overflow => :shrink_to_fit, :at => [margin,pdf.bounds.height-margin], :width => pdf.bounds.width-6, \
        :height => title_ht, :align => :center
    end

    pdf.bounding_box [margin,pdf.bounds.height-title_full_ht], :width => herbs_width, :height => pdf.bounds.height-title_full_ht do
      Formula::ROLES.each do |role|
        f_herbs = f.formula_herbs.select{|fh| fh.formula_role.pinyin == role}
        f_herbs.each do |f_herb|
          pdf.text f_herb.herb.canonical, :size => 10, :style => ((f_herb.formula_role.id==1)&&f.chief_herbs) ? :bold : :normal
        end
      end
    end

    pdf.bounding_box [symptoms_x,pdf.bounds.height-title_full_ht], :width => pdf.bounds.width-symptoms_x, :height => pdf.bounds.height-title_full_ht do
      f.formula_patterns.first(1).map{|t| t.pattern}.each do |pattern|
        pattern.pattern_symptoms[0..9].each do |ps|
          pdf.text ps.symptom.name, :size => 9, :style => (ps.key_symptom ? :bold : :normal)
        end
      end
    end
  end
  pdf.start_new_page
end

