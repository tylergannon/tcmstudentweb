def write_page(p, pdf, &block)
  pdf.define_grid(:columns => 3, :rows => 4, :gutter => 10)
  4.times do |i|
    3.times do |j|
      b = pdf.grid(i,j)
      pdf.bounding_box b.top_left, :width => b.width, :height => b.height do
        yield(p[i][j], pdf) unless p[i][j].nil?
        pdf.stroke do
          pdf.rectangle(pdf.bounds.top_left, b.width, b.height)
        end
      end
    end
  end
end

while !(qpage = @q.shift).nil?
  apage = @a.shift

  write_page(qpage, pdf) do |item, pdf|
    pdf.text item
  end

  pdf.start_new_page

  write_page(apage, pdf) do |item, pdf|
    pdf.text "Ingredients", :size => 10
    pdf.text(item[:ingredients].join(", "), :size => 8) unless item[:ingredients].nil?
    pdf.text "Symptoms", :size => 10
    pdf.text(item[:symptoms][0][0..9].join(", "), :size => 8) unless item[:symptoms][0].nil?
  end
  pdf.start_new_page
end

