  $(function () {
    $(document).keys({
      'q+c' : function(){$('#new_category_link').trigger('click');},
      'q+s' : function(){$('#new_source_link').trigger('click');},
      'q+f' : function(){$('#new_function_link').trigger('click');},
      'q+p' : function(){$('#new_combo_link').trigger('click');}
    })
  });

