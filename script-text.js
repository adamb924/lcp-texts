$(function() {
  $('div.word:has(span.inline-annotation) > span.prs-Arab').addClass('hasAnnotation');
  $('.definable').tooltip({
	  items: "span, [title]",
      content: function() {
		  return $(this).next('span.definition').html();
      }
  });
  $('div.word:has(span.prs-Arab)').each(function(){ 
		var tipContent = $("<div></div>");
		tipContent.append( $(this).children('span.prs-IPA.ma') );
		tipContent.append( $(this).children('span.en-latin.ma') );
		if( $(this).children('span.arb-Arab[title]').length > 0 ) {
			tipContent.append( $("<p>" + $(this).children('span.arb-Arab').attr('title') + "</p>" ) );
		}
		$(this).children('span.inline-annotation').each(function(){
			tipContent.append( $("<hr/>") );
			tipContent.append( $(this) );
		});
		$(this).data('powertipjq', tipContent);
		$(this).powerTip({
			placement: 's',
			mouseOnToPopup: true
		});
	});
  $('ul.annotations').closest('div').prepend('<button class="notes">Show Notes</button>');
  $('button.notes').click(function() {
	  $(this).next('ul.annotations').toggle();  
  });
});