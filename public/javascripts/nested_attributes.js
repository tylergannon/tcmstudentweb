function add_child(element, child_name, new_child) {
  $('#' + child_name + '_children').append(
    new_child.replace(/NEW_RECORD/g, new Date().getTime())
  );
  alert('#' + child_name + '_children');
  return false;
}

function remove_child(element) {
  $(element).prev('input[type|=hidden]').val('1');
  $(element).parents(".child").hide();
  return false;
}

