$(document).ready(function() {

	// Navigation menu

	$('ul#navigation').superfish({ 
		delay:       1000,
		animation:   {opacity:'show',height:'show'},
		speed:       'fast',
		autoArrows:  true,
		dropShadows: false
	});

	$('ul#navigation li').hover(function(){
		$(this).addClass('sfHover2');
	},
	function(){
		$(this).removeClass('sfHover2');
	});
	
	// Live Search
	
	jQuery('#search-bar input[name="q"]').liveSearch({url: 'live_search.php?q='});
	
	//Hover states on the static widgets

	$('.ui-state-default').hover(
		function() { $(this).addClass('ui-state-hover'); }, 
		function() { $(this).removeClass('ui-state-hover'); }
	);

	//Sortable portlets

	$('.sortable .column').sortable({
		cursor: "move",
		connectWith: '.sortable .column',
		dropOnEmpty: false
	});

	$(".column").disableSelection();

	//Sidebar only sortable boxes
	$(".side_sort").sortable({
		axis: 'y',
		cursor: "move",
		connectWith: '.side_sort'
	});

	
	//Close/Open portlets
	$(".portlet-header").hover(function() {
		$(this).addClass("ui-portlet-hover");
	},
	function(){
		$(this).removeClass("ui-portlet-hover");
	});

	$(".portlet-header .ui-icon").click(function() {
		$(this).toggleClass("ui-icon-circle-arrow-n");
		$(this).parents(".portlet:first").find(".portlet-content").toggle();
	});


	// Sidebar close/open (with cookies)

	function close_sidebar() {
		
		$("#sidebar").addClass('closed-sidebar');
		$("#page_wrapper #page-content #page-content-wrapper").addClass("no-bg-image wrapper-full");
		$("#open_sidebar").show();
		$("#close_sidebar, .hide_sidebar").hide();
	}

	function open_sidebar() {
		$("#sidebar").removeClass('closed-sidebar');
		$("#page_wrapper #page-content #page-content-wrapper").removeClass("no-bg-image wrapper-full");
		$("#open_sidebar").hide();
		$("#close_sidebar, .hide_sidebar").show();
	}

	$('#close_sidebar').click(function(){
		close_sidebar();
		if($.browser.safari) {
		    location.reload();
		}
		$.cookie('sidebar', 'closed' );
			$(this).addClass("active");
	});
	
	$('#open_sidebar').click(function(){
		open_sidebar();
		if($.browser.safari) {
		    location.reload();
		}
		$.cookie('sidebar', 'open' );
	});
	
	var sidebar = $.cookie('sidebar');

		if (sidebar == 'closed') {
			close_sidebar();
	    };

		if (sidebar == 'open') {
			open_sidebar();
	    };

	/* Tooltip */

	$(function() {
		$('.tooltip').tooltip({
			track: true,
			delay: 0,
			showURL: false,
			showBody: " - ",
			fade: 250
			});
		});
		
	/* Theme changer - set cookie */

    $(function() {

        $('a.set_theme').click(function() {
           	var theme_name = $(this).attr("id");
			$('body').append('<div id="theme_switcher" />');
			$('#theme_switcher').fadeIn('fast');

			setTimeout(function () { 
				$('#theme_switcher').fadeOut('fast');
			}, 2000);

			setTimeout(function () { 
			$("link[title='style']").attr("href","css/themes/" + theme_name + "/ui.css");
			}, 500);

			$.cookie('theme', theme_name );

			$('a.set_theme').removeClass("active");
			$(this).addClass("active");
			
        });
		
		var theme = $.cookie('theme');

		$("a.set_theme[id="+ theme +"]").addClass("active");
	    
		if (theme == 'black_rose') {
	        $("link[title='style']").attr("href","css/themes/black_rose/ui.css");
	        
	    };

		if (theme == 'gray_standard') {
	        $("link[title='style']").attr("href","css/themes/gray_standard/ui.css");
	    };

		if (theme == 'gray_lightness') {
	        $("link[title='style']").attr("href","css/themes/gray_lightness/ui.css");
	    };
	    
		if (theme == 'blueberry') {
	        $("link[title='style']").attr("href","css/themes/blueberry/ui.css");
	    };
	    
		if (theme == 'apple_pie') {
	        $("link[title='style']").attr("href","css/themes/apple_pie/ui.css");
	    };

    });
    
	/* Layout option - Change layout from fluid to fixed with set cookie */

    $(function() {

		$('.layout-options a').click(function(){
			var lay_id = $(this).attr("id");
			$('body').attr("class",lay_id);
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
			$.cookie('layout', lay_id );
			$('.layout-options a').removeClass("active");
			$(this).addClass("active");
		})
			
	    var lay_cookie = $.cookie('layout');

		$(".layout-options a[id="+ lay_cookie +"]").addClass("active");

		if (lay_cookie == 'layout100') {
			$('body').attr("class","");
			$("#page-layout, #page-header-wrapper, #sub-nav").removeClass("fixed");
	    };

		if (lay_cookie == 'layout90') {
			$('body').attr("class","layout90");
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
	    };
	    
		if (lay_cookie == 'layout75') {
			$('body').attr("class","layout75");
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
	    };
	    
		if (lay_cookie == 'layout980') {
			$('body').attr("class","layout980");
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
	    };
	    
		if (lay_cookie == 'layout1280') {
			$('body').attr("class","layout1280");
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
	    };
	    
		if (lay_cookie == 'layout1400') {
			$('body').attr("class","layout1400");
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
	    };
	    
		if (lay_cookie == 'layout1600') {
			$('body').attr("class","layout1600");
			$("#page-layout, #page-header-wrapper, #sub-nav").addClass("fixed");
	    };

    });

	// Dialog			

	$('#dialog').dialog({
		autoOpen: false,
		width: 600,
		bgiframe: false,
		modal: false,
		buttons: {
			"Ok": function() { 
				$(this).dialog("close"); 
			}, 
			"Cancel": function() { 
				$(this).dialog("close"); 
			} 
		}
	});

	// Modal Confirmation		

		$("#modal_confirmation").dialog({
			autoOpen: false,
			bgiframe: true,
			resizable: false,
			width:500,
			modal: true,
			overlay: {
				backgroundColor: '#000',
				opacity: 0.5
			},
			buttons: {
				'Delete all items in recycle bin': function() {
					$(this).dialog('close');
				},
				Cancel: function() {
					$(this).dialog('close');
				}
			}
		});
	
	// Dialog Link

	$('#dialog_link').click(function(){
		$('#dialog').dialog('open');
		return false;
	});
	
	// Modal Confirmation Link

	$('#modal_confirmation_link').click(function(){
		$('#modal_confirmation').dialog('open');
		return false;
	});
	
	// Same height

	var sidebarHeight = $("#sidebar").height();
	$("#page-content-wrapper").css({"minHeight" : sidebarHeight });

	// Simple drop down menu

	var myIndex, myMenu, position, space=20;
	
	$("div.sub").each(function(){
		$(this).css('left', $(this).parent().offset().left);
		$(this).slideUp('fast');
	});
	
	$(".drop-down li").hover(function(){
		$("ul",this).slideDown('fast');
		
		//get the index, set the selector, add class
		myIndex = $(".main1").index(this);
		myMenu = $(".drop-down a.btn:eq("+myIndex+")");
	}, function(){
		$("ul",this).slideUp('fast');
	});




});
