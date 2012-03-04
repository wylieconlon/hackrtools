hckrtools = {
	isolateElements: function($) {
		var specials = $('.gist pre');
		$.each(specials, function(i, val) {
			console.log(this);
		});
		
		var snippets = $('pre, code:not(pre :first-child), .syntaxHighlight')
						.not(specials);
		$.each(snippets, function(i, val) {
			if($(this).css('display') == 'block') {
				var content = hckrtools.flatten($, $(this))
				$(this).wrap('<div class="hckrsnippet" style="position:relative"><pre class="highlight" /></div>')
				var $parent = $('div.hckrsnippet').last()
				$(this).parent().html(content)
			}
		});
		
		$('pre.highlight').syntaxHighlight()
	},
	createControls: function($) {
		var snippets = $('div.hckrsnippet'),
		    controls = "<span class='copy'>Copy</span><span class='save'>Save</span>";

		$.each(snippets, function(i, val) {
			$(this).prepend(controls);
			hckrtools.bindControls($, $(this));
		});
		$('div.hckrsnippet > span').css('float', 'right');
	},
	bindControls: function($, snippet) {
		var text = hckrtools.flatten($, snippet.find('pre'));
		snippet.find('.copy').click(function() {
			alert(text);
		});
		snippet.find('.save').click(function() {
			hckrtools.openSaveDialog(text);
		});
	},
	flatten: function($, $el) {
		var arr = $el.html().split(/<\s*br\s*\/?\s*>/i)
		for(var i = 0; i < arr.length; i++) {
			arr[i] = arr[i].replace(/(<([^>]+)>)/ig,"")
		}
		return arr.join('\n') 
	},
	load: function() {
		var sh=document.createElement('script')
		sh.setAttribute("type","text/javascript")
		sh.setAttribute("src", "http://hackrtools.com/js/jquery.syntaxhighlighter.min.js")
		document.getElementsByTagName("head")[0].appendChild(sh)
	},
	init: function($) {
		var that = hckrtools;
		$.SyntaxHighlighter.init({lineNumbers:true,stripEmptyStartFinishLines:true});
		that.isolateElements($);
		that.createControls($);

		if(jQueryOld != undefined) {
			$ = jQueryOld.noConflict(true);
		}
	}
}
hckrtools.load()
