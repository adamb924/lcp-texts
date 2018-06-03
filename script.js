$(function() {
      $( "#tabs-left" ).tabs({
	  beforeLoad: function(event, ui) { $('#json-overlay').show(); },
      load:   function(event, ui) { $('#json-overlay').hide(); }
    }).css({
   'min-height': '400px',
   'overflow': 'auto'
	});
	
	
	function resizeUi() {
		var h = $(window).height();
		$("#tabs-left").css('height', h - 50 );
		$(".ui-tabs-panel").css('height', h );
	}

	var resizeTimer = null;
	$(window).bind('resize', function() {
		if (resizeTimer) clearTimeout(resizeTimer);
		resizeTimer = setTimeout(resizeUi, 100);
	});
	resizeUi();

});