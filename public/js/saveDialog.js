hckrtools = hckrtools || {};

hckrtools.saveDialog = {

	/**
	 * Create the edit dialog
	 */
	create: function(options) {
		var that = hckrtools.saveDialog;
		that.fetchForm(options, function(saveForm) {
			$('body').append($("<div class='hckrSave' />").html(saveForm));
			// Attach event handlers
			$('.hckrSave').find('button.save').click(function() {
				// Send update to server
				var fields = $('input, textarea');
				var updates = {};
				for(var field in fields) {
					updates[field.title()] = field.val();
				}
				$.ajax({
					data: updates,
					success: function() {
						that.destroy();
					},
					error: function() {
						alert('Failed');
					},
					type: "PUT",
					url: request
				});
			});
			$('.hckrSave').find('button.cancel').click(function() {
				that.destroy();
			});
		});
	},
	/**
	 * Destroy the edit dialog
	 */	
	destroy: function() {
		$('.hckrSave').remove();
	},
	/**
	 * Fetch the edit dialog
	 */
	fetchForm: function(options, callback) {
		var text = options.text || "",
		    url  = options.url || "",
		    uid  = options.user,
		    id   = options.id,
		    type = options.type || "articles",
		    snip = options.snip || null,
		    that = hckrtools.saveDialog;
	
		var request = "http://hckrtools.com/" + type + "/" + id + "/edit";

		$.get(request, callback);
	},
	/**
	 * Save the snippet/article
	 */
	save: function(options) {
		var text = options.text || "",
		    url  = options.url || "",
		    uid  = options.user,
		    type = options.type || "articles",
		    snip = options.snip || null,
		    that = hckrtools.saveDialog;
		
		var request = "http://hckrtools.com/" + type + "/new"

		var option = {
			title: document.title,
			link: url,
			'public': true,
			type: type
		};

		if(type == "snippet") { option.code = text; }

		$.post(request, option, function(response) {
			hckrtools.saveSuccess(snip);
			that.savingHide();	
		});

		that.savingShow();

	},
	/**
	 * Show a 'saving...' indicator
	 */
	savingShow: function() {
		var saving = document.createElement('div');
		saving.setAttribute('class', 'hckrSaving');
		$('body').append(saving);
		$('.hckrSaving').text("Loading...");
	},
	/**
	 * Remove the 'saving...' indicator
	 */
	savingHide: function() {
		$('.hckrSaving').remove();
	}
		
}
