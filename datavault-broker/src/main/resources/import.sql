-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('Default University Policy', 'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy', 'Default University policy that flags vaults for review after 5 years.', 1, '', '', '', '', '');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('AHRC Technical Plan', 'org.datavaultplatform.common.retentionpolicy.impl.uk.AHRCRetentionPolicy', 'Although researchers will cease to submit a Technical Plan on 29th March 2018 all current projects will continue to operate under the terms of their technical plans, so AHRC funded projects with Technical Plans may continue to submit data to the DataVault for several years.', 2, 3, '', '28/03/2018', 'http://www.ahrc.ac.uk/funding/research/researchfundingguide/', '01/02/2018');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('AHRC Data Management Plan', 'org.datavaultplatform.common.retentionpolicy.impl.uk.AHRCRetentionPolicy', 'It appears the retention period will remain 3 years. More to follow when published by AHRC', 3, 3, '29/03/2018', '', 'http://www.ahrc.ac.uk/peerreview/peer-review-updates-and-guidance/', '08/03/2018');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('BBSRC', 'org.datavaultplatform.common.retentionpolicy.impl.uk.BBSRCRetentionPolicy', '"Researchers are expected to ensure that data are maintained for a period of 10 years after the completion of the research project in suitable accessible formats using established standards where possible such that the data can be made available on request', 4, 10, '', '', 'https://www.bbsrc.ac.uk/funding/apply/application-guidance/data-management/', '13/02/2018');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('Cancer Research UK', 'org.datavaultplatform.common.retentionpolicy.impl.uk.CancerResearchRetentionPolicy', 'Once the funding for a project has ceased researchers should preserve all data resulting from that grant to ensure that data can be used for followup or new studies. We expect that data be preserved and available for sharing with the science community for a minimum period of five years following the end of a research grant.', 5, 5, '', '', 'http://www.cancerresearchuk.org/funding-for-researchers/applying-for-funding/policies-that-affect-your-grant/submission-of-a-data-sharing-and-preservation-strategy/data-sharing-guidelines', '13/02/2018');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('EPSRC', 'org.datavaultplatform.common.retentionpolicy.impl.uk.EPSRCRetentionPolicy', 'Vaults are due for review 10 years after the date of the last retrieve event or the data the last deposit was made, whichever is the latter.', 6, 'https://www.epsrc.ac.uk/about/standards/researchdata/expectations/');
-- insert into RetentionPolicied, name, engine, description, so minDataRetentionPeriod, inEffectDate, endDate,rt, , dataGuidanceReviewedurl) values ('H2020', 'Horizon 2020', 'org.datavaultplatform.common.retentionpolicy.impl.eu.H2020RetentionPolicy', 'Vaults are due for review 10 years after the date the last deposit was made.', 6, '');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('MRC Basic', 'org.datavaultplatform.common.retentionpolicy.impl.uk.MRCBasicRetentionPolicy', 'Vaults are due for review 10 years after the date the last deposit was made.', 7, 'http://www.cancerresearchuk.org/funding-for-researchers/applying-for-funding/policies-that-affect-your-grant/submission-of-a-data-sharing-and-preservation-strategy/data-sharing-guidelines');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('MRC Population Health / Clinical', 'org.datavaultplatform.common.retentionpolicy.impl.uk.MRCPHCRetentionPolicy', 'Vaults are due for review 20 years after the date the last deposit was made.', 8, 'http://www.cancerresearchuk.org/funding-for-researchers/applying-for-funding/policies-that-affect-your-grant/submission-of-a-data-sharing-and-preservation-strategy/data-sharing-guidelines');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('Wellcome Trust Basic', 'org.datavaultplatform.common.retentionpolicy.impl.uk.WTBasicRetentionPolicy', 'Vaults are due for review 10 years after the date the last deposit was made.', 9, 'https://wellcome.ac.uk/funding/managing-grant/policy-data-software-materials-management-and-sharing');
-- insert into RetentionPolicies (name, engine, description, sort, minDataRetentionPeriod, inEffectDate, endDate, url, dataGuidanceReviewed) values ('Wellcome Trust Population Health / Clinical', 'org.datavaultplatform.common.retentionpolicy.impl.uk.WTPHCRetentionPolicy', 'Vaults are due for review 20 years after the date the last deposit was made.', 10, 'https://wellcome.ac.uk/funding/managing-grant/policy-data-software-materials-management-and-sharing');
-- insert into RetentionPolicies (id, name, engine, description, sort, url) values ('5MIN', '5 minute test policy', 'org.datavaultplatform.common.retentionpolicy.impl.FiveMinuteRetentionPolicy', 'Test policy that flags for review any vault over 5 minutes old.', 11);

INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Alzheimers Society',3,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.alzheimers.org.uk/downloads/download/1454/alzheimers_society_grant_application_guidance_2018',STR_TO_DATE('01/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('AHRC Data Management Plan',2,'org.datavaultplatform.common.retentionpolicy.impl.uk.AHRCRetentionPolicy',TRUE,'3',5,STR_TO_DATE('29/03/2018', '%d/%m/%Y'),NULL,'http://www.ahrc.ac.uk/peerreview/peer-review-updates-and-guidance/',STR_TO_DATE('08/03/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('AHRC Technical Plan',1,'org.datavaultplatform.common.retentionpolicy.impl.uk.AHRCRetentionPolicy',TRUE,'3',5,NULL,STR_TO_DATE('28/03/2018', '%d/%m/%Y'),'http://www.ahrc.ac.uk/funding/research/researchfundingguide/',STR_TO_DATE('01/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Anatomical Society',4,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.anatsoc.org.uk/funding-and-awards/grants-and-prizes/anatomical-society-research-studentships',STR_TO_DATE('01/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Arthritis Research UK',5,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.arthritisresearchuk.org/research.aspx',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('AXA Research Fund',6,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.axa-research.org/en/page/general-terms',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('BBSRC',7,'org.datavaultplatform.common.retentionpolicy.impl.uk.BBSRCRetentionPolicy',TRUE,'10 years',5,NULL,NULL,'https://www.bbsrc.ac.uk/funding/apply/application-guidance/data-management/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('BRE Trust',8,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.bre.co.uk/bretrust/index.jsp',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('British Academy',9,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.britac.ac.uk/about-our-funding',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('British Council',10,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.britishcouncil.org/research',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('British Heart Foundation',11,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.bhf.org.uk/research/information-for-researchers',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('British Society for Neuroendocrinology',12,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.neuroendo.org.uk/Members/Grants.aspx',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Cancer Research UK',13,'org.datavaultplatform.common.retentionpolicy.impl.uk.CancerResearchRetentionPolicy',TRUE,'5 years',5,NULL,NULL,'http://www.cancerresearchuk.org/funding-for-researchers/applying-for-funding/policies-that-affect-your-grant/submission-of-a-data-sharing-and-preservation-strategy/data-sharing-guidelines',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Carnegie Trust',14,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.carnegieuktrust.org.uk/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Carnegie trust for the Universities of Scotland',15,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.carnegie-trust.org/images/Documents/Research_Incentive_Grants/RIG_Terms%20%20Conditions_2018.pdf',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Chest, Heart and Stroke Scotland',16,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.chss.org.uk/research-awards/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Chief Scientist Office',17,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'5 years',5,NULL,NULL,'http://www.cso.scot.nhs.uk/wp-content/uploads/Chief_Scientist_Office_Standard_Conditions_of_Grant_Response_Mode_v1_4.pdf',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('CHILDREN with CANCER UK',18,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.childrenwithcancer.org.uk/research/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Daphne Jackson Trust',19,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.daphnejackson.org/fellowships/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Diabetes UK',20,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.diabetes.org.uk/Research/For-researchers',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Digital Health Institute',21,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://dhi-scotland.com/personas/academic/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Dogs Trust',22,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.dogstrustdogschool.org.uk/research/funding-research/',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Edinburgh and Lothian Health Foundation',23,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.elhf.co.uk/grant-seekers/apply-for-a-grant/',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('EPSRC - Engineering and Physical Sciences Research Council',24,'org.datavaultplatform.common.retentionpolicy.impl.uk.EPSRCRetentionPolicy',TRUE,'10 years',5,NULL,NULL,'https://www.epsrc.ac.uk/about/standards/researchdata/expectations/',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('ESRC - Economic and Social Research Council',25,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'http://www.esrc.ac.uk/funding/guidance-for-grant-holders/research-data-policy/',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('European Commission',26,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'http://ec.europa.eu/research/participants/docs/h2020-funding-guide/cross-cutting-issues/open-access-dissemination_en.htm',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Innovate UK',27,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.gov.uk/government/organisations/innovate-uk',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Juvenile Diabetes Research Foundation',28,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://jdrf.org.uk/our-research/information-for-researchers/',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Kay Kendall Leukaemia Fund',29,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://kklf.org.uk/project-grants/',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Kidney Research UK',30,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://research.kidneyresearchuk.org/Login.aspx?ReturnUrl=%2f',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Bloodwise (previously Leukaemia and Lymphoma Research)',31,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'https://bloodwise.org.uk/research/funding-researchers/our-funding-schemes',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Leverhulme Trust',32,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.leverhulme.ac.uk/funding/grant-schemes/research-project-grants/application-procedure',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Marie Curie Cancer Care',33,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'5 Years',5,NULL,NULL,'https://www.mariecurie.org.uk/research/funding-research/marie-curie-research-grants-scheme/terms-and-conditions',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Motor Neurone Disease Association',34,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.mndassociation.org/research/for-researchers/',STR_TO_DATE('15/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Medical Research Council – Basic',35,'org.datavaultplatform.common.retentionpolicy.impl.uk.MRCBasicRetentionPolicy',TRUE,'10 years',5,NULL,NULL,'http://www.cancerresearchuk.org/funding-for-researchers/applying-for-funding/policies-that-affect-your-grant/submission-of-a-data-sharing-and-preservation-strategy/data-sharing-guidelines',STR_TO_DATE('08/03/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Medical Research Council – Population Health / Clinical',36,'org.datavaultplatform.common.retentionpolicy.impl.uk.MRCPHCRetentionPolicy',TRUE,'20 years',5,NULL,NULL,'http://www.cancerresearchuk.org/funding-for-researchers/applying-for-funding/policies-that-affect-your-grant/submission-of-a-data-sharing-and-preservation-strategy/data-sharing-guidelines',STR_TO_DATE('08/03/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Multiple Sclerosis Society',37,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.mssociety.org.uk/ms-resources/grant-round-applicant-guidance',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('National Centre for the Replacement, Refinement and Reduction of Animal Research',38,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'http://www.nc3rs.org.uk/sites/default/files/documents/Funding/Handbook.pdf',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('National Institute for Health Research',39,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.nihr.ac.uk/funding-and-support/funding-for-research-studies/how-to-apply-for-funding/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('NERC',40,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'http://www.nerc.ac.uk/research/sites/data/policy/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Paul Mellon Centre for Studies in British Art',41,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.paul-mellon-centre.ac.uk/fellowships-and-grants/procedure',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Pet Plan Charitable Trust',42,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'?',5,NULL,NULL,NULL,STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Royal Academy of Engineering',43,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.raeng.org.uk/grants-and-prizes/support-for-research',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Royal Society',44,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'not stated',5,NULL,NULL,'https://royalsociety.org/grants-schemes-awards/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Royal Society of Chemistry',45,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.rsc.org/awards-funding/funding',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Royal Society of Edinburgh',46,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.rse.org.uk/funding-awards/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Scottish Funding Council',47,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.sfc.ac.uk/funding/university-funding/university-funding-research/university-research-funding.aspx',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Scottish Government',48,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.gov.scot/topics/research',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Scottish Institute for Policing Research',49,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.sipr.ac.uk/research/index.php',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Society for Endocrinology',50,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://www.endocrinology.org/grants-and-awards/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Society for Reproduction and Fertility',51,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://srf-reproduction.org/grants-awards/grants/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('STFC',52,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'10 years from the end of the project',5,NULL,NULL,'https://www.stfc.ac.uk/funding/research-grants/data-management-plan/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Tenovus - Scotland',53,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'https://tenovus-scotland.org.uk/for-researchers/',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('UK-India Eduation and Research Initiative',54,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'http://www.ukieri.org/call-for-research-applications-2017-18.html',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('University of Edinburgh (applicable to unfunded or self-funded research)',55,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,NULL,NULL,'',STR_TO_DATE('13/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Wellcome Trust Basic',56,'org.datavaultplatform.common.retentionpolicy.impl.uk.WTBasicRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'https://wellcome.ac.uk/funding/managing-grant/policy-data-software-materials-management-and-sharing',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Wellcome Trust Population Health / Clinical',57,'org.datavaultplatform.common.retentionpolicy.impl.uk.WTPHCRetentionPolicy',TRUE,'Not stated',5,NULL,NULL,'https://wellcome.ac.uk/funding/managing-grant/policy-data-software-materials-management-and-sharing',STR_TO_DATE('20/02/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('NHS Retention Policy',58,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,STR_TO_DATE('03/12/2018', '%d/%m/%Y'),NULL,'https://www.hra.nhs.uk/planning-and-improving-research/policies-standards-legislation/',STR_TO_DATE('03/12/2018', '%d/%m/%Y'));
INSERT INTO RetentionPolicies(name,description,sort,engine,extendUponRetrieval,minDataRetentionPeriod,minRetentionPeriod,inEffectDate,endDate,url,dataGuidanceReviewed) VALUES ('Edinburgh Imaging Retention Policy','Policy of UoE''s Edinburgh Imaging (part of Edinburgh Medical School)',59,'org.datavaultplatform.common.retentionpolicy.impl.DefaultRetentionPolicy',TRUE,'N/A',5,STR_TO_DATE('03/12/2018', '%d/%m/%Y'),NULL,'',STR_TO_DATE('03/12/2018', '%d/%m/%Y'));

insert into Users (id, firstname, lastname, password) values ('user1', 'user 1', 'Test', 'password1');
insert into Users (id, firstname, lastname, password) values ('user2', 'user 2', 'Test', 'password2');
insert into Users (id, firstname, lastname, password) values ('user3', 'user 3', 'Test', 'password3');
insert into Users (id, firstname, lastname, password) values ('user4', 'user 4', 'Test', 'password4');
insert into Users (id, firstname, lastname, password) values ('user5', 'user 5', 'Test', 'password5');
insert into Users (id, firstname, lastname, password) values ('user6', 'user 6', 'Test', 'password6');
insert into Users (id, firstname, lastname, password) values ('user7', 'user 7', 'Test', 'password7');
insert into Users (id, firstname, lastname, password) values ('user8', 'user 8', 'Test', 'password8');
insert into Users (id, firstname, lastname, password) values ('user9', 'user 9', 'Test', 'password9');
insert into Users (id, firstname, lastname, password) values ('user10', 'user 10', 'Test', 'password10');
insert into Users (id, firstname, lastname, password) values ('user11', 'user 11', 'Test', 'password11');
insert into Users (id, firstname, lastname, password) values ('user12', 'user 12', 'Test', 'password12');
insert into Users (id, firstname, lastname, password) values ('user13', 'user 13', 'Test', 'password13');
insert into Users (id, firstname, lastname, password) values ('user14', 'user 14', 'Test', 'password14');
insert into Users (id, firstname, lastname, password) values ('user15', 'user 15', 'Test', 'password15');
insert into Users (id, firstname, lastname, password) values ('user16', 'user 16', 'Test', 'password16');
insert into Users (id, firstname, lastname, password) values ('user17', 'user 17', 'Test', 'password17');
insert into Users (id, firstname, lastname, password) values ('user18', 'user 18', 'Test', 'password18');
insert into Users (id, firstname, lastname, password) values ('user19', 'user 19', 'Test', 'password19');
insert into Users (id, firstname, lastname, password) values ('user20', 'user 20', 'Test', 'password20');
insert into Users (id, firstname, lastname, password) values ('user21', 'user 21', 'Test', 'password21');
insert into Users (id, firstname, lastname, password) values ('user22', 'user 22', 'Test', 'password22');
insert into Users (id, firstname, lastname, password) values ('user23', 'user 23', 'Test', 'password23');
insert into Users (id, firstname, lastname, password) values ('user24', 'user 24', 'Test', 'password24');
insert into Users (id, firstname, lastname, password) values ('user25', 'user 25', 'Test', 'password25');
insert into Users (id, firstname, lastname, password) values ('user26', 'user 26', 'Test', 'password26');
insert into Users (id, firstname, lastname, password) values ('user27', 'user 27', 'Test', 'password27');
insert into Users (id, firstname, lastname, password) values ('user28', 'user 28', 'Test', 'password28');
insert into Users (id, firstname, lastname, password) values ('user29', 'user 29', 'Test', 'password29');
insert into Users (id, firstname, lastname, password) values ('user30', 'user 30', 'Test', 'password30');

insert into Users (id, firstname, lastname, password) values ('admin1', 'admin user 1', 'Test', 'password1');
insert into Role_assignments (user_id, role_id) values ('admin1', (select id from Roles where name='IS Admin'));

insert into Groups (id, name, enabled) values ('BS',    'Business School', 1);
insert into Groups (id, name, enabled) values ('SD',    'School of Divinity', 1);
insert into Groups (id, name, enabled) values ('SECO',  'School of Economics', 1);
insert into Groups (id, name, enabled) values ('ECA',   'Edinburgh College of Art', 1);
insert into Groups (id, name, enabled) values ('MHSE',  'The Moray House School of Education', 1);
insert into Groups (id, name, enabled) values ('SHSS',  'School of Health in Social Science', 1);
insert into Groups (id, name, enabled) values ('SHCA',  'School of History, Classics and Archaeology', 1);
insert into Groups (id, name, enabled) values ('SL',    'School of Law', 1);
insert into Groups (id, name, enabled) values ('SLLC',  'School of Literatures, Languages and Cultures', 1);
insert into Groups (id, name, enabled) values ('SPPL',  'School of Philosophy, Psychology and Language Sciences', 1);
insert into Groups (id, name, enabled) values ('SSPS',  'School of Social and Political Science', 1);
insert into Groups (id, name, enabled) values ('EMS',   'Edinburgh Medical School', 1);
insert into Groups (id, name, enabled) values ('RDSVS', 'Royal (Dick) School of Veterinary Studies', 1);
insert into Groups (id, name, enabled) values ('SBS',   'School of Biological Sciences', 1);
insert into Groups (id, name, enabled) values ('SC',    'School of Chemistry', 1);
insert into Groups (id, name, enabled) values ('SENG',  'School of Engineering', 1);
insert into Groups (id, name, enabled) values ('SGS',   'School of GeoSciences', 1);
insert into Groups (id, name, enabled) values ('SI',    'School of Informatics', 1);
insert into Groups (id, name, enabled) values ('SM',    'School of Mathematics', 1);
insert into Groups (id, name, enabled) values ('SPA',   'School of Physics and Astronomy', 1);
INSERT INTO Groups (id, name, enabled) VALUES ('BMED', 'Biomedical Sciences', 1);
INSERT INTO Groups (id, name, enabled) VALUES ('CLIN', 'Clinical Sciences', 1);
INSERT INTO Groups (id, name, enabled) VALUES ('MOLG', 'Molecular, Genetic and Population Health Sciences', 1);

insert into GroupOwners (group_id, user_id) values ('BS', 'user1');
insert into GroupOwners (group_id, user_id) values ('SD', 'user1');
insert into GroupOwners (group_id, user_id) values ('SECO', 'user1');
insert into GroupOwners (group_id, user_id) values ('ECA', 'user2');
insert into GroupOwners (group_id, user_id) values ('MHSE', 'user3');
insert into GroupOwners (group_id, user_id) values ('SHSS', 'user4');

insert ignore into Clients (id, name, apiKey, ipAddress) values ('datavault-webapp', 'Datavault Webapp', 'datavault-webapp', '127.0.0.1');
