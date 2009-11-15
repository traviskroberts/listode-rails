$(document).ready(function() {
  // make forms with the class "remote" submit via AJAX
  $("form.remote").live('submit', function() {
    $.post(this.action + '.js', $(this).serialize(), null, "script");
    return false;
  });
  
	// make links with the class "remote" submit via AJAX (but only in Firefox)
	$('a.remote').live('click', function() {
	  $.get(this.href + '.js', null, null, "script");
  	return false;
	});
	
  // 
	$('a.remote-delete').live('click', function() {
	  if(this.rel) {
	    if(confirm(this.rel)) {
	      $.post(this.href, { _method: 'delete' }, null, "script");
	    }
	  } else {
	    $.post(this.href, { _method: 'delete' }, null, "script");
	  }
    return false;
  });
	
	// Confirm dialog for marking a task as uncomplete
	$('.uncomplete_confirm').live('click', function() {
		if(confirm('Are you sure you want to mark this item as incomplete? Your amount/notes will be erased as well.')) {
		  return true;
		}
		return false;
	});
	
  // hover effect for navigation
  $('#nav ul li').ahover({toggleEffect: 'width', toggleSpeed: 150});
  
  // hover effect for logolink
  $('#header .logolink').ahover({toggleEffect: 'width', toggleSpeed: 150});
  
  // show add task form
  $('a.add_task_link').live("click", function() {
    $('#task_group_select').hide();
    $('#task_group_form').show();
    return false;
  })
  
  // hide add task form
  $('a.cancel_add_task').live('click', function() {
    $('#task_group_select').show();
    $('#task_group_form').hide();
    return false;
  })
  
  // submit add task form
  $('a.task_group_submit').live('click', function() {
    this.href = this.href + '?title=' + $('#task_group_title').attr("value");
  })
});

// show and hide notes for a list item
function toggle_list_notes(id, source) {
  if (source == 'link') {
    $('#complete_'+id).attr("checked", false);
  }
	$('#amount_field_'+id).attr("value", '');
	$('#note_field_'+id).attr("value", '');
	$('#notes_'+id).toggle();
	return false;
}

// reset all checkboxes to not-checked
function reset_checkboxes() {
	var inputs = $(":checkbox");
	for (var i = 0; i < inputs.length; i++) {
		inputs[i].checked = false;
	}
}

function show_note_actions(id) {
  // first, hide all instances of 'note_actions'
  $('.action_img').hide();
  // now, show the one we need to
  $('#list_notes_' + id + ' .action_img').show();
}

function hide_note_actions(id) {
  window.setTimeout("$('#list_notes_" + id + " .action_img').hide()", 500);
}