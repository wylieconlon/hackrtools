hckrtools = {
	isolateElements: function($) {
		var gists = $('.gist');
		$.each(gists, function(i, val) {
			var id = this.id.match(/[0-9]+/);
			var raw = "https://raw.github.com/gist/"+id;
		});
		
		var snippets = $('pre, code:not(pre :first-child), .syntaxHighlight')
						.not(gists);
		$.each(snippets, function(i, val) {
			if($(this).css('display') == 'block') {
				var content = hckrtools.flatten($, $(this))
				$(this).wrap('<div class="hckrsnippet" style="position:relative"><pre class="highlight" /></div>')
				var $parent = $('div.hckrsnippet').last()
				$(this).parent().html(content)
			}
		});
	
		if($('pre.highlight').length == 0) {
			var opts = { url: document.location.href, user: null };
			hckrtools.saveDialog.save(opts);
		} else {
			$('pre.highlight').syntaxHighlight()
		}
	},
	createControls: function($) {
		var snippets = $('div.hckrsnippet'),
		    controls = "<span class='share'>Share</span><span class='save'>Save</span>";

		$.each(snippets, function(i, val) {
			$(this).prepend(controls);
			hckrtools.bindControls($, $(this));
		});
		$('div.hckrsnippet > span').css('float', 'right');
	},
	bindControls: function($, snippet) {
		var text = hckrtools.flatten($, snippet.find('pre'));
		snippet.find('.share').click(function() {
			var options = {
				text: text,
				url: document.location.href,
				type: "snippet",
				snip: snippet,
				callback: hckrtools.share
			}
			hckrtools.saveDialog.save(options);
		});
		snippet.find('.save').click(function() {
			hckrtools.save(text, snippet);
		});
	},
	share: function(opts) {
		var share = document.createElement('div')
		share.setAttribute('class', 'hckrShare')
		$('body').append(share);
		$('.hckrShare').html(hckrtools.shareTemplate(opts.link));
	},
	save: function(text, snip) {
		var options = {
			text: text,
			url : document.location.href,
			type: 'snippet',
			user: null,
			snip: snip
		}
		hckrtools.saveDialog.save(options);	
	},
	saveSuccess: function(snip) {
		if(snip !== null) {
			snip.find('.save').text("Edit");
			snip.find('.save').click(hckrtools.edit);
		} 
	},
	edit: function(snip) {
		hckrtools.saveDialog.create({type:"snippet"});
	},
	flatten: function($, $el) {
		var arr = $el.html().split(/<\s*br\s*\/?\s*>/i)
		for(var i = 0; i < arr.length; i++) {
			arr[i] = arr[i].replace(/(<([^>]+)>)/ig,"")
		}
		return arr.join('\n') 
	},
	load: function() {
		hckrtools.includeJs("http://hackrtools.com/js/saveDialog.js")
		hckrtools.includeJs("http://hackrtools.com/js/jquery.syntaxhighlighter.min.js")
	},
	init: function($) {
		var that = hckrtools;
		
		if($ === undefined) {
			$ = jQuery;
		} else {
			
		}
		
		$.SyntaxHighlighter.init({
			lineNumbers:true,
			stripEmptyStartFinishLines:true,
			
		});
		that.isolateElements($);
		that.createControls($);

// 		if(typeof jQueryOld !== "undefined") {
// 			$ = jQueryOld.noConflict(true);
// 		}
	},

	includeJs: function(b) {
		var a=document.createElement("script");
		a.setAttribute("type","text/javascript");
		a.setAttribute("src",b);
		document.getElementsByTagName("head")[0].appendChild(a)
	}
}

hckrtools.shareTemplate = function(url) {
	return '<!-- Required by FB -->' +
		'<div id="fb-root"></div>' +
		'<script>(function(d, s, id) {' +
		'  var js, fjs = d.getElementsByTagName(s)[0];' +
		'  if (d.getElementById(id)) return;' +
		'  js = d.createElement(s); js.id = id;' +
		'  js.src = "https://connect.facebook.net/en_US/all.js#xfbml=1";' +
		'  fjs.parentNode.insertBefore(js, fjs);' +
		"}(document, 'script', 'facebook-jssdk'));</script>" +
		'<ul>' +
		'<li>' +
		'<!-- Twitter -->' +
		'  <a href="https://twitter.com/share" class="twitter-share-button" data-url="' + url + '" data-text="Take a look at this code I just saved" data-count="none" data-hashtags="hackrtoolkit" target="_blank">' +
		'  <div class="b2-widget-btn">' +
		'<i></i><span class="b2-widget-label">Tweet</span>' +
		'     </div></a>' +
		'<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src="http://platform.twitter.com/widgets.js";fjs.parentNode.insertBefore(js,fjs);}}(document,"script","twitter-wjs");</script>' +
		'</li>' +
		'<li>' +
		'<!-- Facebook -->' +
		'<div class="fb-send" data-href="' + url + '" data-font="arial"></div>' +
		'</li>' +
		'</ul>';
};
hckrtools.load()
