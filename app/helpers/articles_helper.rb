module ArticlesHelper
  def herbs_list(formula)
    hf_ary = formula.state_board ? formula.formula_herbs : formula.chief_herbs
    hf_ary.map {|hf|
      if hf.formula_role.pinyin == Formula::ROLES[0]
        "<b>#{link(hf.herb)}</b>"
      else
        link(hf.herb)
      end
    }.join(", ")
  end
end
