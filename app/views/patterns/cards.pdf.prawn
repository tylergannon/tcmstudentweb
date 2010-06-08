def write_page(p, pdf, &block)
  pdf.define_grid(:columns => 2, :rows => 3, :gutter => 6)
  3.times do |i|
    2.times do |j|
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

# pdf.font "#{Prawn::BASEDIR}/data/fonts/gkai00mp.ttf"
while !(qpage = @q.shift).nil?
  apage = @a.shift

  write_page(qpage, pdf) do |pattern|
    pdf.move_down(pdf.bounds.height/2.2)
    pdf.text pattern.name, :align => :center, :size => 17
    pdf.text( pattern.citation.textbook.title, :align=>:center, :size=>11 ) unless pattern.citation.nil?
  end

  pdf.start_new_page

  title_ht = 15.mm
  title_full_ht = 15.mm
  box1_width = 60.mm
  margin = 4
  box2_x = box1_width + margin*2

  def keymark(ps)
    ps.key_symptom ? "**" : ""
  end

  write_page(apage, pdf) do |pattern|
#    symptoms_text = pattern.pattern_symptoms.map {|ps| "• #{keymark(ps)}ps.symptom_name"}.join("\n")


#    pdf.text_box symptoms_text, :size => 10, :overflow => :shrink_to_fit, \
#      :at => [margin,pdf.bounds.height-margin], :width => box1_width, \
#      :height => pdf.bounds.height-margin, :align => :left

    pdf.bounding_box [margin,pdf.bounds.height-margin*2], :width => box1_width, :height => pdf.bounds.height do
      pattern.pattern_symptoms.each do |ps|
        pdf.text "• #{ps.symptom.name}", :size => 9, :style => (ps.key_symptom ? :bold : :normal)
      end
    end

    pdf.bounding_box [box2_x,pdf.bounds.height-margin], :width => pdf.bounds.width-box2_x, :height => pdf.bounds.height do
      pdf.text "Formulas", :size => 10, :style => :bold
      pattern.formula_patterns.each do |fp|
        pdf.text "• #{fp.formula.pinyin}", :size => 9
      end
      pdf.move_down 4
      pdf.text "Point Prescription", :size => 10, :style => :bold
      pattern.point_prescriptions.each do |pp|
        pp.pp_acu_points.each do |ppap|
          pdf.text "• #{ppap.acu_point.display_name}", :size => 9
        end
      end
    end
  end
  pdf.start_new_page
end

