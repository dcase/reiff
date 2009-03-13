// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Declare any global variables
var modal_trigger;

// rails auth token enabled in jquery
$(document).ajaxSend(function(event, request, settings) {
  if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});



jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")},
	cache : false
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

jQuery.fn.extend({
	multiColumnList: function(items_in_column, column_width) {
		list_items = $('li', this);
		list_items_total = list_items.length;
		columns_count = Math.ceil(list_items_total / items_in_column);
		column_items = new Array;
		start_item = 0;
		end_item = items_in_column;
		
		$(this).wrap('<div id="list-container"></div');
		
		for (i=0;i<columns_count;++i) {
			list_items
				.filter('li:gt(' + (start_item-1) + ')')
				.filter('li:lt(' + end_item + ')')
				.appendTo("#list-container")
				.wrapAll('<div id="column_' + (i+1) + '" class="column' + (i==0?' first-column':'') + '" style="left: ' + (i*column_width) + 'px;width: ' + column_width + 'px;"><ul></ul></div>');
			
			start_item += items_in_column;
			end_item += items_in_column;
		}
		
		$('#list-container').append('<div style="clear:both;height:0;" />');
	
		this.remove();
	}
});
(function($) {
	var timeout = 0;
	
	$.fn.textScroll = function(up_btn,down_btn,target,duration) {
		$(up_btn).bind('mousedown', function() { 
			startScrollUp(this,target,duration); 
		}).bind('mouseup', stopScroll);
		$(down_btn).bind('mousedown', function() { 
			startScrollDown(this,target,duration); 
		}).bind('mouseup', stopScroll);
	};
		
	function startScrollUp(obj,target,duration) {
		$(obj).scrollTo('-=' + target,duration);
		timeout = setTimeout("startScrollUp(obj,target,duration)", 60);
	};
	function startScrollDown(obj,target,duration) {
		$(obj).scrollTo('+=' + target,duration);
		timeout = setTimeout("startScrollDown(obj,target,duration)", 60);
	};
	function stopScroll() {
		clearTimeout(timeout);
	};

})(jQuery);

// Page specific stuff

$(document).ready( function() {
	$('.announcements').corner({
		antiAlias: true,
		autoPad: true,
		validTags: ["div"]
	});
	
	// Setup modals
	
	$('body').append('<div id="modal"><img id="modal-close" src="/images/modal_button_close.png" width="30" height="30" alt="Close Window" /><div id="modal-content"></div></div>');
	
	
	// Main modal window
	$('#modal').jqm({
		modal: true,
		ajax: '@href',
		ajaxText: "<h1>Loading...</h1>",
		target: '#modal-content',
		onLoad: function(hash) {
			modal_trigger = $(hash.t);
		}
	});
	$('#modal').jqmAddClose('#modal-close');
	$('.modal').livequery( function(){
		$('#modal').jqmAddTrigger('.modal');
	});
	
	// Add second window, if needed
	$('.modal-new-window').livequery( function() {
		if ( $('#modal2').length == 0) {
			$('body').append('<div id="modal2"><img id="modal-close2" src="/images/modal_button_close.png" width="30" height="30" alt="Close Window" /><div id="modal-content2"></div></div>');
			$('#modal2').jqm({
				modal: true,
				ajax: '@href',
				ajaxText: "<h1>Loading...</h1>",
				target: '#modal-content2',
				onLoad: function(hash) {
					modal_trigger = $(hash.t);
				}
			});
			$('#modal2').jqmAddClose('#modal-close2');
		}
		$('#modal2').jqmAddTrigger('.modal-new-window');
	});

	
	// Add toggle for page section fields
	$('.toggle_fieldset').livequery('click', function(event) {
		$(this).parent().next('fieldset').toggle();
		});
	
	// Ajaxify forms

	$('form.ajax').livequery( function(){
		if ( $(this).attr('enctype')) {
			$('body').append('<iframe id="ajax-target" name="ajax-target"></iframe>');
			$(this).attr({'target':'ajax-target','action':$(this).attr('action') + '.js'});
		} else {
			$(this).bind('submit', function(event) {
				$.post(
					$(this).attr('action'),
					$(this).serialize(),
					function(data) {
						if ($('#errorExplanation',data).length > 0 ) {
							$('#modal-content').html(data);
						} else {
							class_names = modal_trigger.attr('class').split(" ");
							update_class = $.grep(class_names, function(c) {  return c.substr(0,6) == "update"});
							append_class = $.grep(class_names, function(c) {  return c.substr(0,6) == "append"});
							if ( update_class.length > 0) {
								update_id = update_class[0].substr(7);
								$('#' + update_id).replaceWith(data);
								$('#modal-content').html("");
								$('#modal').jqmHide();
							}
							else if ( append_class.length > 0 ) {
								append_id = append_class[0].substr(7);
								$('#' + append_id).append(data);
								$('#modal-content').html("");
								$('#modal').jqmHide();
							}
							else {
								$('#modal-content').html(data);
								$('#modal-content2').html("");
								$('#modal2').jqmHide();
							}
						}
					},
					"html"
				);
			event.preventDefault();
			});
		}
	});
	
	// Ajaxify links by method
	$('a.ajax-delete').livequery('click', function(event) {
	        if ( confirm("Are you sure you want to delete this?") ) {
	            $.post(
	                $(this).attr('href'),
	                { '_method': 'delete' },
	                null,
	                "script" 
	            );
			}
	       event.preventDefault();
	});
	
	// Make Admin Toolbar draggable
	$('#admin-toolbar-container').draggable({ handle: '.admin_drag_handle'});
	
	// For Clients, Specialties
	$('.column-list').livequery( function() {
		$('ul',this).multiColumnList(12,249);
	});
	
	// For Applications
	$('.file_list').livequery( function() {
		$('ul',this).multiColumnList(3,249);
	});
	
	// For Credits
	$('.credits-list').livequery( function() {
		$("a[rel^='lightbox']").slimbox({/* Put custom options here */}, null, function(el) {
			return (this == el) || ((this.rel.length > 8) && (this.rel == el.rel));
		});
		$('ul',this).multiColumnList(7,372);
		$('#list-container').sortable({
			handle: '.article_list_item_drag_handle',
			scroll: true,
			items: 'li',
			update: function() {
				$.post('/article_list_items/order', $(this).sortable('serialize'));
				$.get(
					'/page_sections/23',
					{"page_id": 17},
					function(data) {
						$('#page_section_23').replaceWith(data);
					},
					"html"
					);
			} 
		});
	});
	
	// For Contact
	$('.contact-list').livequery( function() {
		$('ul',this).multiColumnList(3,240);
	});
});