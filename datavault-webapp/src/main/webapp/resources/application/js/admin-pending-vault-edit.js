// This is modified version of new-create-prototype.js tailored to taking account of differences
// between the creation of a Pending Vault and the Admin Edit of a Pending Vault.
$(document).ready(function(){
	var current_fs, next_fs, previous_fs;
	var opacity;
	var confirmedTrue = ($("#confirmed").val() === 'true');
	var isAdmin = ($("#is-admin").length > 0);

	// Prevent Enter Key Submitting Form
	$("form input").on("keypress", function(e) {
		return e.keyCode != 13;
	});

	var startYearsInFutureForGEDNegative = -60; // 60 years in past

	var todayForDatepicker = new Date();
	todayForDatepicker.setHours(0,0,0,0);
	var _30YearsFromToday= new Date();
	_30YearsFromToday.setFullYear(_30YearsFromToday.getFullYear() + 30);

	$.datepicker.setDefaults({
		dateFormat: "yy-mm-dd",
		changeMonth: true,
		changeYear: true,
		showOtherMonths: true,
		selectOtherMonths: true,
		maxDate: _30YearsFromToday
	});

	$( "#grantEndDate" ).datepicker();
	$( "#billingGrantEndDate" ).datepicker();
	$( "#reviewDate" ).datepicker({ minDate: '+36m' });

	// Get db Grant End Date when page set
	var dbGrantEndDate = $("#grantEndDate").val().trim();
	console.log("dbGrantEndDate: ", dbGrantEndDate);

	/*
    if billinGrantEndDate is filled in, disable granteddate on the info page and populate it with the billing value
    if billingGrantEndDate is cleared enable grantenddate on the info page and populate it with dbGrantEndDate also reset review date
	 */
	$( "#billingGrantEndDate" ).change(function() {
		// clear any validation
		$('#invalid-billing-grant-end-date-span').text("");
		var dateResult = ($("#billingGrantEndDate").val().trim() === '');

		var grantChecked = ($("#billing-choice-grantfunding").is(":checked"));

		if (dateResult === false && grantChecked === true) {
			// 
			var validationMessage = validateDateString($("#billingGrantEndDate").val().trim(), "Grant End Date", startYearsInFutureForGEDNegative);
			if (validationMessage != "") {
				$('#invalid-billing-grant-end-date-span').text(validationMessage);
			}

			$("#grantEndDate").val($("#billingGrantEndDate").val().trim());
			$("#grantEndDate").prop("disabled", true);
		} else {
			var length = calculateReviewLength();
			var estimatedReviewDate = calculateReviewDateForToday(length);

			$("#grantEndDate").prop("disabled", false);
			// Reset to dbGrantEndDate
			$("#grantEndDate").val(dbGrantEndDate);
			$("#reviewDate").val(estimatedReviewDate);
		}
	}).trigger('change');

	$("#billingGrantEndDate, #grantEndDate, #policyInfo").change(function(){
		// if the ged changes update the suggested review date
		if($("#grantEndDate").val().trim() !== '') {
			var grantEndDateValidationMessage = validateDateString($("#grantEndDate").val().trim(), "Grant End Date", startYearsInFutureForGEDNegative);
			$('#invalid-grant-end-date-span').text(grantEndDateValidationMessage);
		} else {
			// clear any validation
			$('#invalid-grant-end-date-span').text("");	
		}

		// if no retention policy picked yet ged + 3 years

		// if a retention policy has been picked ged + policy length
		var noRP = ($("#policyInfo option:selected").val() === '' || $("#policyInfo option:selected").prop("disabled"));
		var noGED = ($("#grantEndDate").val().trim() === '');
		var noBillingGED = ($("#billingGrantEndDate").val().trim() === '');
		var ged = $("#grantEndDate").val().trim();
		var gedDate = new Date(ged);
		var gedMm = String(gedDate.getMonth() + 1).padStart(2, '0');
		var gedDd = String(gedDate.getDate()).padStart(2, '0');
		var billingGed = $("#billingGrantEndDate").val().trim();
		var billingGedDate = new Date(billingGed);
		var billingGedMm = String(billingGedDate.getMonth() + 1).padStart(2, '0');
		var billingGedDd = String(billingGedDate.getDate()).padStart(2, '0');
		var defaultLength = 3;
		var policyLength = calculateReviewLength();

		var today = new Date();
		var dd = String(today.getDate()).padStart(2, '0');
		var mm = String(today.getMonth() + 1).padStart(2, '0'); // January is 0
		// Default Review Date (3 years from today)
		var estimatedReviewDate = calculateReviewDateForToday(defaultLength);

		// GED in future test
		var grantGEDInFuture = noGED  ? false : (dateDiffInDaysStartingAtMidnight(today, gedDate) > 0);
		var billingGEDInFuture = noBillingGED ? false : (dateDiffInDaysStartingAtMidnight(today, billingGedDate) > 0);

		if (noRP === false && noGED === true && noBillingGED === true) {
			// if we only have policy then length + current date = review date
			estimatedReviewDate = String(today.getFullYear() + policyLength) + '-' + mm + '-' + dd;
		} 

		if (noRP === false && noBillingGED === false && billingGEDInFuture === true) {
			// if we have both then billing ged + policy length = review date
			estimatedReviewDate = String(billingGedDate.getFullYear() + policyLength) + '-' + billingGedMm + '-' + billingGedDd;
		} 

		if (noRP === true && noBillingGED === false && billingGEDInFuture === true) {
			// if we only have a ged in the billing fieldset then ged + 3 = review date
			estimatedReviewDate = String(billingGedDate.getFullYear() + defaultLength) + '-' + billingGedMm + '-' + billingGedDd;
		} 

		if (noRP === false && noGED === false && grantGEDInFuture === true) {
			// if we have both then ged + policy length = review date
			estimatedReviewDate = String(gedDate.getFullYear() + policyLength) + '-' + gedMm + '-' + gedDd;
		} 

		if (noRP === true && noGED === false && grantGEDInFuture === true) {
			// if we only have ged then ged + 3 = review date
			estimatedReviewDate = String(gedDate.getFullYear() + defaultLength) + '-' + gedMm + '-' + gedDd;
		} 

		if (noRP === false && noBillingGED === false && billingGEDInFuture === false) {
			// if we only have policy then length + current date = review date
			estimatedReviewDate = String(today.getFullYear() + policyLength) + '-' + mm + '-' + dd;
		} 

		if (noRP === false && noGED === false && grantGEDInFuture === false) {
			// if we only have policy then length + current date = review date
			estimatedReviewDate = String(today.getFullYear() + policyLength) + '-' + mm + '-' + dd;
		}



		$("#reviewDate").val(estimatedReviewDate);

		// Clear Error text and update message 
		$("#invalid-review-date-span").text(""); 
		var reviewDateUpdatedMsg = "Note the Review Date has been updated based on your selections.";
		$("#updated-review-date-span").text(reviewDateUpdatedMsg);


	}).trigger('change');

	$("#reviewDate").change(function() {
		var startYearsInFuture  = 3; // Min allowed years in future for  Review Date

		// Clear old messages beside the review date
		$("#updated-review-date-span").text("");
		$("#invalid-review-date-span").text(""); 

		var reviewDateString = $("#reviewDate").val().trim();
		console.log("reviewDateString", reviewDateString);

		var validationMessage = validateDateString(reviewDateString, "Review Date",  startYearsInFuture );

		if(validationMessage.trim() !== '') {
			console.log(validationMessage);
			// Add error message     
			$("#invalid-review-date-span").text(validationMessage);	

		} else {
			// Clear Error text     
			$("#invalid-review-date-span").text(""); 
		}

	}).trigger('change');



	$("#vaultName, #description, #policyInfo, #groupID, #reviewDate, #grantEndDate").change(function(){
		// if all the mandatory values in the info field set are non null or empty set the next button
		// display value to true
		// name
		var nameResult = ($( "input[type=text][id=vaultName]").val().trim() === '');
		// description
		var descResult = ($( "textarea[type=text][id=description]").val() === '');
		// retention policy
		var rpResult = ($("#policyInfo option:selected").val() === '' || $("#policyInfo option:selected").prop("disabled"));
		// school
		var schoolResult = ($("#groupID option:selected").val() === '' || $("#groupID option:selected").prop("disabled"));
		// review date
		var reviewResult = ($( "input[id=reviewDate]").val().trim() === '' ||  $("#invalid-review-date-span").text().trim() !== '');
		// Check that there are no validation error of grantEndDate input
		// as it is not a required field
		var grantEndResult = ($("#invalid-grant-end-date-span").text().trim() !== '');

		if (nameResult === false && descResult === false && rpResult === false &&
				schoolResult === false  && reviewResult === false && grantEndResult === false) {
			$(this).parents("fieldset").children(".next").prop("disabled", false);
		} else {
			$(this).parents("fieldset").children(".next").prop("disabled", true);
		}
	}).trigger('change');  ;

	$("#pureLink-check").change(function(){
		var result = $(this).is(":checked");
		if (result) {
			$("#confirm").prop("disabled", false);
		} else {
			$("#confirm").prop("disabled", true);
		}
	}).trigger('change');


	// Initially, disable next on doc initialisation
	$("input[name=\"billingType\"]").parents("fieldset").children(".next").prop( "disabled", true );

	$("#billing-choice-na").change(function(){
		clearBillingOptions();
		$('.collapse').collapse('hide');
		validateBillingNA();
	}).trigger('change');  ;

	$("#billing-choice-grantfunding").change(function(){
		clearBillingOptions();

		if($(this).is(":checked")){
			$('.collapse').not('#grant-billing-form').collapse('hide');
			$('#grant-billing-form').collapse('show');
		}
		validateBillingGrantFundingFields();
	}).trigger('change');

	$("#authoriser").change(function() {
		validateBillingGrantFundingFields();
	});

	$("#schoolOrUnit").change(function() {
		validateBillingGrantFundingFields();
	});

	$("#subunit").change(function() {
		validateBillingGrantFundingFields();
	});

	$("#projectTitle").change(function() {
		validateBillingGrantFundingFields();
	});

	$("#billingGrantEndDate").change(function() {
		validateBillingGrantFundingFields();
	});


	$("#billing-choice-budgetcode").change(function(){
		clearBillingOptions();

		if($(this).is(":checked")) {
			$('.collapse').not('#budget-billing-form').collapse('hide');
			$('#budget-billing-form').collapse('show');
		}

		validateBillingBudgetCodeFields();
	}).trigger('change');

	$("#budget-authoriser").change(function() {
		validateBillingBudgetCodeFields();
	});

	$("#budget-schoolOrUnit").change(function() {
		validateBillingBudgetCodeFields();
	});

	$("#budget-subunit").change(function() {
		validateBillingBudgetCodeFields();
	});



	$("#billing-choice-slice").change(function(){
		clearBillingOptions();
		if($(this).is(":checked")) {
			$('.collapse').not('#slice-form').collapse('hide');
			$('#slice-form').collapse('show');
		}
		validateBillingSliceFields();
	}).trigger('change');

	// Validates Slice fields
	$("#sliceID").change(function() {
		validateBillingSliceFields();
	});


	$("#add-ndm-btn").click(function(){
		const firstEmptyNdm = $("#hidden-empty-ndms > div.empty-ndm").first();
		firstEmptyNdm.removeClass("empty-ndm")
		.addClass("extra-ndm");
		firstEmptyNdm.appendTo("#extra-ndm-list");
		firstEmptyNdm.show();
	});

	$(".remove-ndm-btn").click(function(){
		const currentNdm = $(this).closest('.extra-ndm');
		// Reset value of input to empty string
		currentNdm.find("input:first-child").val("");
		currentNdm.removeClass("extra-ndm")
		.addClass("empty-ndm");
		// Prepend element to hidden-empty-ndms
		currentNdm.prependTo($("#hidden-empty-ndms"));
		// Clear Error text     
		$(this).siblings(".uun-required-error-span").text("");
	});

	$("#add-depositor-btn").click(function(){
		const firstEmptyDepositor = $("#hidden-empty-depositors > div.empty-depositor").first();
		firstEmptyDepositor.removeClass("empty-depositor")
		.addClass("extra-depositor");
		firstEmptyDepositor.appendTo("#extra-depositor-list");
		firstEmptyDepositor.show();
	});

	$(".remove-depositor-btn").click(function(){
		const currentDepositor = $(this).closest('.extra-depositor');
		// Reset value of input to empty string
		currentDepositor.find("input:first-child").val("");
		currentDepositor.removeClass("extra-depositor")
		.addClass("empty-depositor");
		// Prepend element to hidden-empty-depositors
		currentDepositor.prependTo($("#hidden-empty-depositors"));
		// Clear Error text     
		$(this).siblings(".uun-required-error-span").text("");

	});

	$("#add-data-creator-btn").click(function(){
		const firstEmptyDataCreator = $("#hidden-empty-data-creators > div.empty-data-creator").first();
		firstEmptyDataCreator.removeClass("empty-data-creator")
		.addClass("extra-data-creator");
		firstEmptyDataCreator.appendTo("#extra-data-creator-list");
		firstEmptyDataCreator.show();
	});

	$(".remove-data-creator-btn").click(function(){
		const currentDataCreator = $(this).closest('.extra-data-creator');
		// Reset value of input to empty string
		currentDataCreator.find("input:first-child").val("");
		currentDataCreator.removeClass("extra-data-creator")
		.addClass("empty-data-creator");
		// Prepend element to hidden-empty-data-creators
		currentDataCreator.prependTo($("#hidden-empty-data-creators"));
		// Clear Error text     
		$(this).siblings(".uun-required-error-span").text("");

	});


	$(".next").click(function(){

		current_fs = $(this).parent();
		next_fs = $(this).parent().next();

		//Add Class Active
		$("#progressbar li").eq($("fieldset").index(next_fs)).addClass("active");
		// Add aria-* attributes to progress bar

		var currentProgressText = $("#progressbar > li.active").last().attr("data-progress-text");
		var currentProgressValue = $("#progressbar > li.active").last().attr("data-progress-value");
		console.log("currentProgressText: ", currentProgressText);
		console.log("currentProgressValue: ", currentProgressValue);
		$("#progressbar").attr("aria-valuetext", currentProgressText);
		$("#progressbar").attr("aria-valuenow", currentProgressValue);

		//show the next fieldset
		next_fs.show();
		//hide the current fieldset with style
		current_fs.animate({opacity: 0}, {
			step: function(now) {
				// for making fieldset appear animation
				opacity = 1 - now;

				current_fs.css({
					'display': 'none',
					'position': 'relative'
				});
				next_fs.css({'opacity': opacity});
			},
			duration: 600
		});

		populateSummaryPage();
		validateBillingPageForNextClick();
	});

	$(".previous").click(function(){

		current_fs = $(this).parent();
		previous_fs = $(this).parent().prev();

		//Remove class active
		$("#progressbar li").eq($("fieldset").index(current_fs)).removeClass("active");

		//show the previous fieldset
		previous_fs.show();

		//hide the current fieldset with style
		current_fs.animate({opacity: 0}, {
			step: function(now) {
				// for making fieldset appear animation
				opacity = 1 - now;

				current_fs.css({
					'display': 'none',
					'position': 'relative'
				});
				previous_fs.css({'opacity': opacity});
			},
			duration: 600
		});
	});

	$('.radio-group .radio').click(function(){
		$(this).parent().find('.radio').removeClass('selected');
		$(this).addClass('selected');
	});

	$('button[type="submit"]').on("click", function() {
		$('#submitAction').val($(this).attr('value'));
	});


	// We need to populate the summary page with data from 
	// other fieldset pages at start
	populateSummaryPage();
	// Set the Progress to go to Billing when we first enter
    var start = (new URL(window.location.href)).searchParams.get('start');
	if(start == 2) {
		$("#progressbar li").eq(1).addClass("active");
		// Show Summary page
		$('#summary-fieldset').hide();
		$('#billing-fieldset').show();
	}



	function validateBillingNA() {
		console.log("called validateBillingNAFields");
		if($("#billing-choice-na").is(":checked")) {
			$("#billing-choice-na").parents("fieldset").children(".next").prop( "disabled", false );
			console.log("called validateBillingNAFields: ENABLED");	
		}
	}

	function validateBillingSliceFields() {
		console.log("called validateBillingSliceFields");
		if($("#billing-choice-slice").is(":checked")) {
			if($("#sliceID").val().trim() !== '') {
				$("#billing-choice-slice").parents("fieldset").children(".next").prop( "disabled", false );
				console.log("called validateBillingSliceFields: ENABLED");
			} else {
				$("#billing-choice-slice").parents("fieldset").children(".next").prop( "disabled", true );
				console.log("called validateBillingSliceFields: DISABLED");
			}

		}	
	}

	function validateBillingGrantFundingFields() {
		console.log("called validateBillingGrantFundingFields");
		if($("#billing-choice-grantfunding").is(":checked")) {
			if($("#authoriser").val().trim() !== '' &&
					$("#schoolOrUnit").val().trim() !== '' &&
					$("#subunit").val().trim() !== '' &&
					$("#projectTitle").val().trim() !== '' &&
					$("#billingGrantEndDate").val().trim() !== '' &&
					$("#invalid-billing-grant-end-date-span").text().trim() === '') {
				$("#billing-choice-grantfunding").parents("fieldset").children(".next").prop( "disabled", false );
				console.log("called validateBillingGrantFundedFields: ENABLED");
			} else {
				$("#billing-choice-grantfunding").parents("fieldset").children(".next").prop( "disabled", true );
				console.log("called validateBillingGrantFundingFields: DISABLED");
			}

		}	
	}

	function validateBillingBudgetCodeFields() {
		console.log("called validateBillingBudgetCodeFields");
		if($("#billing-choice-budgetcode").is(":checked")) {
			if($("#budget-authoriser").val().trim() !== '' &&
					$("#budget-schoolOrUnit").val().trim() !== '' &&
					$("#budget-subunit").val().trim() !== '' ) {
				$("#billing-choice-budgetcode").parents("fieldset").children(".next").prop( "disabled", false );
				console.log("called validateBillingBudgetCodeFields: ENABLED");
			} else {
				$("#billing-choice-budgetcode").parents("fieldset").children(".next").prop( "disabled", true );
				console.log("called validateBillingBudgetCodeFields: DISABLED");
			}

		}	
	}

	// We will call this in $(".next").click()
	function validateBillingPageForNextClick() {
		validateBillingNA();
		validateBillingSliceFields();
		validateBillingGrantFundingFields();
		validateBillingBudgetCodeFields();
	}

	function clearBillingOptions() {

		// enable or disable the grant end date field on the info fieldset
		var dateResult = ($("#billingGrantEndDate").val().trim() === '');
		var grantChecked = ($("#billing-choice-grantfunding").is(":checked"));

		if (dateResult === false && grantChecked === true) {
			$("#grantEndDate").val($("#billingGrantEndDate").val());
			$("#grantEndDate").prop("disabled", true);
		} else {
			var length = calculateReviewLength();
			var estimatedReviewDate = calculateReviewDateForToday(length);
			$("#grantEndDate").prop("disabled", false);
			// Reset to dbGrantEndDate
			$("#grantEndDate").val(dbGrantEndDate);
			$("#reviewDate").val(estimatedReviewDate);
		}

		// clear the unused fieldsets
		var naChecked = ($("#billing-choice-na").is(":checked"));
		var grantChecked = ($("#billing-choice-grantfunding").is(":checked"));
		var budgetChecked = ($("#billing-choice-budgetcode").is(":checked"));
		var sliceChecked = ($("#billing-choice-slice").is(":checked"));
		// if billing type is not grant clear fieldset
		if (naChecked === true) {
			$("#grant-billing-form input").val("");
			$("#budget-billing-form input").val("");
			$("#slice-form input").val("");
		}
		if (grantChecked === true) {
			$("#budget-billing-form input").val("");
			$("#slice-form input").val("");
		}

		if (budgetChecked === true) {
			$("#grant-billing-form input").val("");
			$("#slice-form input").val("");
		}

		if (sliceChecked === true) {
			$("#grant-billing-form input").val("");
			$("#budget-billing-form input").val("");
		}
	}

	function populateSummaryPage() {
		console.log("populateSummaryPage()");
		// Check if an element with id="summary-fieldset" currently exists,
		// then populate the Summary page either values from form elements on previous pages
		if ($('#summary-fieldset').length) {
			//  To get input tag text we need to use val() not text().

			// VaultInfo
			$("#summary-vaultName").text($("#vaultName").val());
			$("#summary-description").text($("#description").val());
			$("#summary-policyID").text($("#policyInfo option:selected").text());
			var grantChecked = ($("#billing-choice-grantfunding").is(":checked"));
			if (grantChecked === true) {
				$("#summary-grantEndDate").text($("#billingGrantEndDate").val());
			} else {
				$("#summary-grantEndDate").text($("#grantEndDate").val());
			}
			$("#summary-groupID").text($("#groupID option:selected").text());
			$("#summary-reviewDate").text($("#reviewDate").val());
			// remove line breaks from string with replace(/(\r\n|\n|\r)/gm, "") and need to trim
			var estimateEl = $("input[name='estimate']:checked");
			if(typeof estimateEl !== 'undefined' && estimateEl !== null) {
				$("#summary-estimate").text(estimateEl.parent().text().replace(/(\r\n|\n|\r)/gm, "").trim());
			}
			$("#summary-notes").text($("#notes").val());

			// Billing
			var billingTypeEl = $("input[id^='billing-choice']:checked");
			if(typeof billingTypeEl !== 'undefined' && billingTypeEl !== null) {
				var billingType = billingTypeEl.parent().text().replace(/(\r\n|\n|\r)/gm, "").trim();
				// Hack to ensure text after "[" is not added
				if(billingType.indexOf("[") > -1) {
					billingType = billingType.split("[")[0];
				}
				$("#summary-billing-type").text(billingType);
				//Hide or show billing fields
				if(billingType.startsWith("N/A")) {
					$(".summary-grant-or_budget-billing-row").hide();
					$(".summary-slice-billing-row").hide();
				} else if(billingType.startsWith("A Slice")) {
					$(".summary-grant-or_budget-billing-row").hide();
					$(".summary-slice-billing-row").show();
				} else {
					$(".summary-slice-billing-row").hide();
					$(".summary-grant-or_budget-billing-row").show();
				}
			}
			$("#summary-sliceID").text($("#sliceID").val());
			$("#summary-authoriser").text($("#authoriser").val());
			$("#summary-schoolOrUnit").text($("#schoolOrUnit").val());
			$("#summary-subunit").text($("#subunit").val());
			$("#summary-projectTitle").text($("#projectTitle").val());

			// Vault Users

			// Vault Access
			$("#summary-vaultOwner").text($("#vaultOwner").val());

			var ndmsArray = [];
			$("input[name^='nominatedDataManagers']").each(function() {
				ndmsArray.push($(this).val());
			});
			// comma-separated text
			var ndmsHtml = createArrayHtml(ndmsArray);
			$("#summary-nominatedDataManagers").html(ndmsHtml);

			var depositorsArray = [];
			$("input[name^='depositors']").each(function() {
				depositorsArray.push($(this).val());
			});

			var depositorsHtml = createArrayHtml(depositorsArray);
			$("#summary-depositors").html(depositorsHtml);

			// Pure Information
			$("#summary-contactPerson").text($("#contactPerson").val());

			var dataCreatorsArray = [];
			$("input[name^='dataCreators']").each(function() {
				dataCreatorsArray.push($(this).val());
			});

			var dataCreatorsHtml = createArrayHtml(dataCreatorsArray);
			$("#summary-dataCreators").html(dataCreatorsHtml);
		}


		function createArrayHtml(array) {
			var html = "";
			for (var i = 0; i < array.length; i++) {
				// To only add  non-empty strings
				if(array[i].trim().length > 0) {
					html += array[i] + "<br>";
				}
			} 
			return html;
		}

	}

	function calculateReviewDateForToday(length) {
		var today = new Date();
		var dd = String(today.getDate()).padStart(2,'0');
		var mm = String(today.getMonth() + 1).padStart(2,'0'); // January is 0
		var yyyy = String(today.getFullYear() + parseInt(length, 10));

		return yyyy + '-' + mm + '-' + dd;
	}

	function calculateReviewLength() {
		var noRP = ($("#policyInfo option:selected").val() === '' || $("#policyInfo option:selected").prop("disabled"));

		var length = 3;
		var policyInfoString = $("#policyInfo option:selected").val();
		var policyInfoArray = policyInfoString.split("-");

		if (noRP === false && policyInfoString !== '' && policyInfoArray[1] !== '') {
			var policyLength = parseInt(policyInfoArray[1], 10);
			if (policyLength > length) {
				length = policyLength;
			}
		}

		return length;
	}
});
