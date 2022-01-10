package org.datavaultplatform.webapp.services;

import org.datavaultplatform.common.request.CreateVault;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.access.method.P;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class ValidateService {
    private static final Logger logger = LoggerFactory.getLogger(ValidateService.class);

    public List<String> validate(CreateVault vault) {
        List<String> retVal = new ArrayList<>();
        retVal.addAll(this.validateFieldset1(vault));
        retVal.addAll(this.validateFieldset2(vault));
        retVal.addAll(this.validateFieldset3(vault));
        retVal.addAll(this.validateFieldset4(vault));
        retVal.addAll(this.validateFieldset5(vault));
        return retVal;
    }

    private List<String> validateFieldset1(CreateVault vault) {
        List<String> retVal = new ArrayList<>();

        // Field set 1 should have completed
        // Affirmation
        Boolean affirmed = vault.getAffirmed();
        if (affirmed == null || affirmed == false) {
            retVal.add("Affirmation");
        }

        return retVal;
    }

    private List<String> validateFieldset2(CreateVault vault) {
        List<String> retVal = new ArrayList<>();

        // Field set 2 should have completed
        //Billing type and it should have been one of our controlled options
        String type = vault.getBillingType();
        if (type == null || type.isEmpty()) {
            retVal.add("BillingType missing");
            return retVal;
        }

        if (!type.equals("NA") && !type.equals("GRANT_FUNDING") && !type.equals("BUDGET_CODE")  && !type.equals("SLICE")) {
            retVal.add("BillingType invalid (" + type + ")");
            return retVal;
        }

        //If type GRANT_FUNDING or BUDGET_CODE
        if (type.equals("GRANT_FUNDING")) {

            return this.validateGrantBillingType(vault);
        }

        if (type.equals("BUDGET_CODE")) {

            return this.validateBudgetBillingType(vault);
        }

        //If type SLICE
        if (type.equals("SLICE")) {
            //slice
            String slice = vault.getSliceID();
            if (slice == null || slice.isEmpty()) {
                retVal.add("Slice ID missing");
            }
        }


        return retVal;
    }

    private List<String> validateBudgetBillingType(CreateVault vault) {
        List<String> retVal = new ArrayList<>();

        //Authoriser
        String authoriser = vault.getBudgetAuthoriser();
        if (authoriser == null || authoriser.isEmpty()) {
            retVal.add("Authoriser missing");
        }
        //School / Unit
        String schoolOrUnit = vault.getBudgetSchoolOrUnit();
        if (schoolOrUnit == null || schoolOrUnit.isEmpty()) {
            retVal.add("School / Unit missing");
        }
        //Subunit
        String subunit = vault.getBudgetSubunit();
        if (subunit == null || subunit.isEmpty()) {
            retVal.add("Subunit missing");
        }
        return retVal;

    }
    private List<String> validateGrantBillingType(CreateVault vault) {
        List<String> retVal = new ArrayList<>();

        String authoriser = vault.getGrantAuthoriser();
        if (authoriser == null || authoriser.isEmpty()) {
            retVal.add("Authoriser missing");
        }
        //School / Unit
        String schoolOrUnit = vault.getGrantSchoolOrUnit();
        if (schoolOrUnit == null || schoolOrUnit.isEmpty()) {
            retVal.add("School / Unit missing");
        }
        //Subunit
        String subunit = vault.getGrantSubunit();
        if (subunit == null || subunit.isEmpty()) {
            retVal.add("Subunit missing");
        }
        // Project Title
        String projectTitle = vault.getProjectTitle();
        if (projectTitle == null || projectTitle.isEmpty()) {
            retVal.add("Project Title missing");
        }
        // Grant end date
        String grantEndDate = vault.getReviewDate();
        if (grantEndDate == null || grantEndDate.isEmpty()) {
            retVal.add("Review Date missing");
        }
        return retVal;
    }

    private List<String> validateFieldset3(CreateVault vault) {
        List<String> retVal = new ArrayList<>();
//        Field set 3 should have completed
//        Name
        String name = vault.getName();
        if (name == null || name.isEmpty()) {
            retVal.add("Name missing");
        }
//        Description
        String description = vault.getDescription();
        if (description == null || description.isEmpty()) {
            retVal.add("Description missing");
        }
//        Retention policy
        String policy = vault.getPolicyInfo();
        if (policy == null || policy.isEmpty()) {
            retVal.add("Retention policy missing");
        }
//        School
        String school = vault.getGroupID();
        if (school == null || school.isEmpty()) {
            retVal.add("School missing");
        }
//        Review Date
        String reviewDate = vault.getReviewDate();
        if (reviewDate == null || reviewDate.isEmpty()) {
            retVal.add("Review Date missing");
        } else {
        // if review date is less than 3 years from today
            int length = 3;
            if (policy != null && !policy.isEmpty())  {
                try {
                    length = Integer.parseInt(policy.split("-")[1]);
                } catch (NumberFormatException ne) {
                    length = 3;
                }
            }
            if (LocalDate.parse(reviewDate, DateTimeFormatter.ofPattern("yyyy-MM-dd"))
                    .isBefore(LocalDate.parse(this.getDefaultReviewDate(length), DateTimeFormatter.ofPattern("yyyy-MM-dd")))) {
                retVal.add("Review Date for selected policy is required to be at least " + length + " years");
            }
        }

        return retVal;
    }

    private List<String> validateFieldset4(CreateVault vault) {
        List<String> retVal = new ArrayList<>();

//        Field set 4 should have completed

        return retVal;
    }

    private List<String> validateFieldset5(CreateVault vault) {
        List<String> retVal = new ArrayList<>();

//        Field set 5 should have completed
//        Pure link
        Boolean pureLink = vault.getPureLink();
        if (pureLink == null || pureLink == false) {
            retVal.add("Pure link not accepted");
        }
        return retVal;
    }

    public String getDefaultReviewDate(int length) {
        String retVal = "";
        Calendar cal = Calendar.getInstance();
        cal.setTimeZone(TimeZone.getTimeZone("Europe/London"));
        cal.add(Calendar.YEAR, length);
        Date todayPlus3Years = cal.getTime();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        retVal = formatter.format(todayPlus3Years);

        return retVal;
    }

    public String getDefaultReviewDate() {
        return this.getDefaultReviewDate(3);
    }
}