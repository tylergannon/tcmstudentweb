
function setUpDocument($jq) {
  $jq.find("input[data-auto-complete|=tf]").each( function(idx, el){
    $(el).autocomplete({
      source: $(el).attr('data-auto-complete-url'),
      minLength: 2
    });
  });

  $jq.find("textarea[data-auto-complete|=ta]").each( function(idx, el){
    setTextAreaAutoComplete($(el));
  });

  $jq.find("a.add-child-link").click( function() {
    klass = $(this).attr('data-class-name');
    $el = $(this).prev().children().first().clone();
    new_id=new Date().getTime()
    $el.html($el.html().replace(new RegExp('__'+klass+'_id__', 'g'), new_id));
    $el.find('input[data-remove|='+klass+']').attr('value', 'false');
    $(this).closest('.child').find('.'+klass+'_children').first()
        .append($el).show();
    setUpDocument($el);
    return false;
  });

  $jq.find('a.remove-child-link').click( function() {
    $(this).prev('input[type|=hidden]').val('1');
    $(this).closest('.child').hide();
    return false;
  });
}

$(function () {
  setUpDocument($("body"));

});
  var text_area_delimiter = '\n';
    function split(val) {
        return val.split(new RegExp(text_area_delimiter+'\s*'));
    }
    function extractLast(term) {
        return split(term).pop();
    }
function setTextAreaAutoComplete($el) {
    $el.autocomplete({
		source: function(request, response) {
			$.getJSON($el.attr('data-auto-complete-url'), {
				term: extractLast(request.term)
			}, response);
		},
		search: function() {
			// custom minLength
			var term = extractLast(this.value);
			if (term.length < 2) {
				return false;
			}
		},
		focus: function() {
			// prevent value inserted on focus
			return false;
		},
		select: function(event, ui) {
			var terms = split( this.value );
			terms.pop();  // remove the current input
			terms.push( ui.item.value );	// add the selected item
			// add placeholder to get the comma-and-space at the end
			// terms.push("");
			this.value = terms.join(text_area_delimiter);
			return false;
		}
	});

}

