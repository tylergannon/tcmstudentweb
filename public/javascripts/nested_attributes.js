
function setUpDocument($jq) {
  $jq.find("input[data-auto-complete|=tf]").each( function(idx, el){
    $(el).autocomplete({
      source: $(el).attr('data-auto-complete-url'),
      minLength: 2
    });
  });

  $jq.find("a.show-element-link").click(function(){
    $('#'+$(this).attr('data-id')).show();
    return false;
  });

  $jq.find("a.hide-element-link").click(function(){
    $('#'+$(this).attr('data-id')).hide();
    return false;
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
    function split(val, delim) {
        if (delim=='nl') {delim = '\n';}
        return val.split(new RegExp(delim+'\s*'));
    }
    function extractLast(term, delim) {
        return split(term, delim).pop();
    }
function setTextAreaAutoComplete($el) {
    // $el.tabOverride();
    $el.autocomplete({
		source: function(request, response) {
			$.getJSON($el.attr('data-auto-complete-url'), {
				term: extractLast(request.term, $el.attr('data-auto-complete-delim'))
			}, response);
		},
		search: function() {
			// custom minLength
			var term = extractLast(this.value, $el.attr('data-auto-complete-delim'));
			if (term.length < 2) {
				return false;
			}
		},
		focus: function() {
			// prevent value inserted on focus
			return false;
		},
		select: function(event, ui) {
			var terms = split( this.value, $el.attr('data-auto-complete-delim') );
			terms.pop();  // remove the current input
			terms.push( ui.item.value );	// add the selected item
			// add placeholder to get the comma-and-space at the end
			terms.push("");
			delim = $el.attr('data-auto-complete-delim');
			if (delim=='nl') {delim='\n';}
			this.value = terms.join(delim);
			return false;
		}
	});

}

