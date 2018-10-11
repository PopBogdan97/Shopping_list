(function ($) {

	$.fn.zxcvbnProgressBar = function (options) {

		//init settings
		var settings = $.extend({
			passwordInput: '#Password',
			userInputs: [],
			ratings: ["Very weak", "Weak", "Good", "Strong", "Very strong"],
			allProgressBarClasses: "progress-bar-danger progress-bar-warning progress-bar-success progress-bar-striped active",
			progressBarClass0: "progress-bar-danger progress-bar-striped active",
			progressBarClass1: "progress-bar-danger progress-bar-striped active",
			progressBarClass2: "progress-bar-warning progress-bar-striped active",
			progressBarClass3: "progress-bar-success",
			progressBarClass4: "progress-bar-success"
		}, options);

		return this.each(function () {
			settings.progressBar = this;
			UpdateProgressBar();
			$(settings.passwordInput).keyup(function (event) {
				UpdateProgressBar();
			});
		});

		function UpdateProgressBar() {
			var progressBar = settings.progressBar;
			var password = $(settings.passwordInput).val();
			if (password) {
				var result = zxcvbn(password, settings.userInputs);

				var scorePercentage = (result.score + 1) * 20;
				$(progressBar).css('width', scorePercentage + '%');

				if (result.score == 0) {
					$(progressBar).removeClass(settings.allProgressBarClasses).addClass(settings.progressBarClass0);
					$(progressBar).html(settings.ratings[0]);
				}
				else if (result.score == 1) {
					$(progressBar).removeClass(settings.allProgressBarClasses).addClass(settings.progressBarClass1);
					$(progressBar).html(settings.ratings[1]);
				}
				else if (result.score == 2) {
					$(progressBar).removeClass(settings.allProgressBarClasses).addClass(settings.progressBarClass2);
					$(progressBar).html(settings.ratings[2]);
				}
				else if (result.score == 3) {
					$(progressBar).removeClass(settings.allProgressBarClasses).addClass(settings.progressBarClass3);
					$(progressBar).html(settings.ratings[3]);
				}
				else if (result.score == 4) {
					$(progressBar).removeClass(settings.allProgressBarClasses).addClass(settings.progressBarClass4);
					$(progressBar).html(settings.ratings[4]);
				}
			}
			else {
				$(progressBar).css('width', '0%');
				$(progressBar).removeClass(settings.allProgressBarClasses).addClass(settings.progressBarClass0);
				$(progressBar).html('');
			}
		}
	};
})(jQuery);