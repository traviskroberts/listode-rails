// Common JavaScript code across your application goes here.

// function to send a jQuery object via AJAX
jQuery.fn.submitFormWithAjax = function() {
  this.submit(function() {
    $.post(this.action + '.js', $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery.fn.submitLinkWithAjax = function() {
  this.click(function() {
    $.get(this.href + '.js', null, null, "script");
  	return false;
  })
};


$(document).ready(function() {
  // make forms with the class "remote" submit via AJAX
  $("form.remote").submitFormWithAjax();
  
	// make links with the class "remote" submit via AJAX (but only in Firefox)
	if($.browser.mozilla){ $('a.remote').submitLinkWithAjax(); }
	
	// Confirm dialog for delete records
	$('.task_delete').click(function() {
		var answer = confirm('Are you sure you want to delete this task?');
		return answer;
	});
	
	// Confirm dialog for deleting task groups
	$('.task_group_delete').click(function() {
		var answer = confirm('Are you sure you want to delete this task group? All associated tasks will also be deleted.');
		return answer;
	});
	
	// Confirm dialog for marking a task as uncomplete
	$('.uncomplete_confirm').click(function() {
		var answer = confirm('Are you sure you want to mark this item as incomplete? Your amount/notes will be erased as well.');
		return answer;
	});
	
  // hover effect for navigation
  $('#nav ul li').ahover({toggleEffect: 'width', toggleSpeed: 150});
  
  // hover effect for logolink
  $('#header .logolink').ahover({toggleEffect: 'width', toggleSpeed: 150});
  
  // show add task form
  $('a.add_task_link').click(function() {
    $('#task_group_select').hide();
    $('#task_group_form').show();
    return false;
  })
  
  // hide add task form
  $('a.cancel_add_task').click(function() {
    $('#task_group_select').show();
    $('#task_group_form').hide();
    return false;
  })
  
  // submit add task form
  $('a.task_group_submit').click(function() {
    this.href = this.href + "?title=" + $('#task_group_title').attr("value");
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