package org.datavaultplatform.broker.scheduled;

import org.datavaultplatform.broker.services.EmailService;
import org.datavaultplatform.broker.services.VaultsPureService;
import org.datavaultplatform.broker.services.VaultsReviewService;
import org.datavaultplatform.broker.services.VaultsService;
import org.datavaultplatform.common.model.*;
import org.datavaultplatform.common.util.RoleUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;

public class CheckForPure {
    private static final Logger log = LoggerFactory.getLogger(CheckForPure.class);

    private VaultsService vaultsService;
    private VaultsPureService vaultsPureService;
    private EmailService emailService;

    public void setVaultsService(VaultsService vaultsService) {
        this.vaultsService = vaultsService;
    }

    public void setVaultsPureService(VaultsPureService vaultsPureService) {
        this.vaultsPureService = vaultsPureService;
    }

    public void setEmailService(EmailService emailService) {
        this.emailService = emailService;
    }



    @Scheduled(cron = "${pure.schedule}")
    /*
    To start with loop through the vaults and produce / send xml to Pure group
    for Vaults that haven't already done that.
    Once that is done think about extending so that ones that have produced xml check if it has been loaded into Pure
     */
    public void checkAll() throws Exception {

        Date start = new Date();
        log.info("Initiating check of Vaults that need to produce a Pure record at " + start);

        List<Vault> vaults = vaultsService.getVaults();

        for (Vault vault : vaults) {

            // have we already produced the Record or not
            if (! vaultsPureService.hasProducedPureRecord(vault)) {

                log.info("Vault " + vault.getName() + " has not produced a Pure Record");

                // Build the Pure XML record for the Vault
                // 1.Create a DocumentBuilder instance
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dbuilder = dbFactory.newDocumentBuilder();

                // 2. Create a Document from the above DocumentBuilder.
                Document document = dbuilder.newDocument();

                // 3. Create the elements you want using the Element class and its appendChild method.

                // root element
                String ns = "v1:";
                //<v1:datasets xmlns:v1="v1.dataset.pure.atira.dk" xmlns:v3="v3.commons.pure.atira.dk">
                //<v1:datasets xmlns:ns0="v1" ns0:v11="v1.dataset.pure.atira.dk" xmlns:ns1="v3" ns1:v33="v3.commons.pure.atira.dk" xmlns:v1="v1:">
                Element datasets = document.createElementNS(ns, "v1:datasets");
                //datasets.setPrefix("xmlns:v1");

                //Element datasets = document.createElement("datasets");
                document.appendChild(datasets);
                datasets.setPrefix("v1");
                datasets.setAttributeNS("v1", "v11", "v1.dataset.pure.atira.dk");
                datasets.setPrefix("v3");
                datasets.setAttributeNS("v3", "v33", "v3.commons.pure.atira.dk");
                // child element
                Element dataset = document.createElementNS(ns, "dataset");
                datasets.appendChild(dataset);

                // Attribute of child element
                dataset.setAttribute("id", "1");
                dataset.setAttribute("type", "dataset");

                // firstname Element
                Element title = document.createElementNS(ns, "title");
                title.appendChild(document.createTextNode("Test Title 2022"));
                dataset.appendChild(title);

                // lastName element
                //Element lastName = document.createElement("lastName");
                //lastName.appendChild(document.createTextNode("Bubble"));
                //user.appendChild(lastName);

                // email element
                //Element email = document.createElement("email");
                //email.appendChild(document.createTextNode("admin@interviewBubble.com"));
                //user.appendChild(email);

                // write content into xml file

                // 4. Create a new Transformer instance and a new DOMSource instance.
                TransformerFactory transformerFactory = TransformerFactory.newInstance();
                Transformer transformer = transformerFactory.newTransformer();
                DOMSource source = new DOMSource(document);

                // 5. Create a new StreamResult to the output stream you want to use.
                //StreamResult result = new StreamResult(new File("/Users/admin/Desktop/users.xml"));
                StreamResult result = new StreamResult(System.out); // to print on console

                // 6. Use transform method to write the DOM object to the output stream.
                transformer.transform(source, result);

                System.out.println("File created successfully");

                // deliver to the Pure mob

                // add to the vaults table

                // Now bash on with the emailing (if required actually I suppose we could email straight to Damon / Nik)

                /*HashMap<String, Object> model = new HashMap<String, Object>();
                model.put("vault-name", vault.getName());
                model.put("vault-id", vault.getID());
                model.put("vault-review-date", dateToString(vault.getReviewDate()));
                model.put("retention-policy-expiry-date", dateToString(vault.getRetentionPolicyExpiry()));
                model.put("group-name", vault.getGroup().getName());
                model.put("home-page", homeUrl);
                model.put("help-page", helpUrl);
                model.put("help-mail", helpMail);
                model.put("vault-review-link", homeUrl+ "/admin/vaults/" + vault.getID() + "/reviews");

                // Email the support team
                emailService.sendTemplateMail(helpMail, "DataVault Vault needing reviewed", "review-due-support.vm", model);*/
            }


        }

        Date end = new Date();
        log.info("Finished check of Vaults for Pure record at " + start);
        log.info("Check took " + TimeUnit.MILLISECONDS.toSeconds(end.getTime() - start.getTime()) + " seconds");
    }
}