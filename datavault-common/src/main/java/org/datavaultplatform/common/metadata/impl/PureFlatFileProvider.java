package org.datavaultplatform.common.metadata.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.datavaultplatform.common.model.Dataset;

import com.amazonaws.util.CollectionUtils;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.LineIterator;
import org.datavaultplatform.common.metadata.Provider;

// This mock metadata provider is for testing purposes only

public class PureFlatFileProvider implements Provider {

    List<Dataset> datasets = new ArrayList<>();
    public static final String TITLE = "title";
    public static final String XML = "xml";
	public static final String CRISID = "crisid";
    private String flatFileDir = "/tmp/";
    public static final String DATASET_DISPLAY_FILE_NAME = "datasetDisplay.flat";
    public static final String DATASET_FULL_FILE_NAME = "datasetFull.flat";
    public static final String PERSON_FILE_NAME = "person.flat";
    private static final String PURE_VALIDATED = "Validated";
    public static final String PURE_PROJECT_IDS_FILE_NAME = "projectId.flat";
    
    public PureFlatFileProvider() {
    }
    
    public void setFlatFileDir(String flatFileDir) {
    	System.out.println("Setting flat file dir to : " + flatFileDir);
    	this.flatFileDir = flatFileDir;
    }
    
    public String getFlatFileDir() {
    	return this.flatFileDir;
    }
    
    //update view to grey out non validated datasets
    
    private Map<String, String> processPersonFlatFile() throws IOException {
    	Map<String, String> retVal = new HashMap<String, String>();
    	System.out.println("flat file dir is : " + this.getFlatFileDir());
    	File personFile = new File(this.getFlatFileDir() + PureFlatFileProvider.PERSON_FILE_NAME);
    	if (personFile.exists()) {
	    	LineIterator personIt = null;
			try {
				 personIt = FileUtils.lineIterator(personFile, "UTF-8");
				while ( personIt.hasNext()) {
		    	    String line =  personIt.nextLine();
		    	    String[] splitLine = line.split("\t");
		    	    if (splitLine.length == 2) {
		    	    	retVal.put(splitLine[1], splitLine[0]);
		    	    }
				}
			} catch (IOException e) {
				throw e;
			} finally {
				 personIt.close();
	    	}
    	}
		return retVal;
    }
    
    private Map<String, Map<String, List<String>>> processDatasetDisplayFlatFile() throws IOException {
    	Map<String, Map<String, List<String>>> retVal = new HashMap<String, Map<String, List<String>>>();
    	System.out.println("flat file dir is : " + this.getFlatFileDir());
    	File dsDisplayFile = new File(this.getFlatFileDir() + PureFlatFileProvider.DATASET_DISPLAY_FILE_NAME);
    	if (dsDisplayFile.exists()) {
	    	LineIterator displayIt = null;
			try {
				displayIt = FileUtils.lineIterator(dsDisplayFile, "UTF-8");
				while (displayIt.hasNext()) {
		    	    String line = displayIt.nextLine();
		    	    String[] splitLine = line.split("\t");
		    	    if (splitLine.length == 4) {
		    	    	List<String> info = new ArrayList<String>();
		    	    	info.add(splitLine[2]);
		    	    	info.add(splitLine[3]);
		    	    	//see if we have seen a ds for this user already if so use that
		    	    	Map<String, List<String>> dsMap = retVal.get(splitLine[0]);
		    	    	if (dsMap == null) {
		    	    		// if not make a new hash
		    	    		dsMap = new HashMap<String, List<String>>();
		    	    	}
		    	    	dsMap.put(splitLine[1], info);
		    	    	retVal.put(splitLine[0], dsMap);
		    	    }
				}
			} catch (IOException e) {
				throw e;
			} finally {
				displayIt.close();
	    	}
    	}
		return retVal;
    }
    
    private Map<String, Map<String, String>> processDatasetFullFlatFile() throws IOException {
    	Map<String, Map<String, String>> retVal = new HashMap<String, Map<String,String>>();
    	System.out.println("flat file dir is : " + this.getFlatFileDir());
        File dsFullFile  = new File(this.getFlatFileDir() + PureFlatFileProvider.DATASET_FULL_FILE_NAME);
        if (dsFullFile.exists()) {
	        LineIterator fullIt = null;
			try {
				fullIt = FileUtils.lineIterator(dsFullFile, "UTF-8");
				while (fullIt.hasNext()) {
		    	    String line = fullIt.nextLine();
		    	    String[] splitLine = line.split("\t");
		    	    if (splitLine.length == 4) {
		    	    	Map<String, String> data = new HashMap<String, String>();
		    	    	data.put(PureFlatFileProvider.TITLE, splitLine[1]);
		    	    	data.put(PureFlatFileProvider.XML, splitLine[2]);
						data.put(PureFlatFileProvider.CRISID, splitLine[3]);
		    	    	retVal.put(splitLine[0], data);
		    	    }
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				fullIt.close();
	    	}
        }
		return retVal;
    }
    
    @Override
    /*
     * Use the flat files generated daily from the Test Pure (and will be updated to the Real Pure) to pull out the datasets
     * for a logged in user's UUN.  The UUN is used by the LDAP service to get the employee ID which is then mapped to person uuid from
     * Pure then we can access the actual datasets.
     * 
     * The flat files are generated by a bash script in DATAVAULT_HOME/scripts/generatePureData.sh this will be run nightly to generate the flat files on 
     * a deployed machine.  This is a workaround as we aren't allowed (atm) to query Pure via the api in real time.
     */
    public List<Dataset> getDatasetsForUser(String userID) {
    	List<Dataset> retVal = new ArrayList<Dataset>();
    	System.out.println("Getting Datasets from the test pure flat file for " +userID);
    	//System.out.println("Employee ID is hardcoded to 123363 for now we need to add the LDAP service to get the real employee ID");
    	// userID is the employee id
    	if (userID != null) {
	        Map<String, String> personHash;
			try {
				// key employee id - value person uuid
				personHash = this.processPersonFlatFile();
				 // key person uuid - dataset uuid - value list of ds uuid, title, workflow
		        Map<String, Map<String, List<String>>> displayHash = this.processDatasetDisplayFlatFile();
		    	// get the person uuid for the employee id
		    	String personUUID = personHash.get(userID);
		    	if (personUUID != null) {
			    	// get the datasets for this users
			    	Map<String, List<String>> dataSetsMap = displayHash.get(personUUID);
			    	// foreach dataset
			    	if (dataSetsMap != null) {
				    	for (String dsUUID: dataSetsMap.keySet()) {
				    	// get the full meta data to make the ds content
				    		List<String> info = dataSetsMap.get(dsUUID);
				    		if (info.size() == 2) {
					    		Dataset ds = new Dataset();
					    		ds.setID(dsUUID);
					    		String status = info.get(1);
					    		ds.setName(info.get(0) + " (" + status + ")");
					    		Boolean visible = true;
					    		if (! status.equals(PureFlatFileProvider.PURE_VALIDATED)) {
					    			visible = false;
					    		}
					    		ds.setVisible(visible);
					    		retVal.add(ds);
				    		}
				    	}
			    	}
		    	}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
        return retVal;
    }
    
    @Override
    public Dataset getDataset(String id) {
    	Dataset retVal = null;
	    if (id != null) {
	    	// key ds uuid - value the pure record metadata as xml 
	        try {
				Map<String, Map<String, String>> fullHash = this.processDatasetFullFlatFile();
				Map<String, String> data = fullHash.get(id);
				if (data != null) {
					retVal = new Dataset();
					retVal.setID(id);
					//fix name I'll need to bring that back in the full flat file
					retVal.setName(data.get(PureFlatFileProvider.TITLE));
					retVal.setContent(data.get(PureFlatFileProvider.XML));
					retVal.setCrisId(data.get(PureFlatFileProvider.CRISID));
				}
				
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
    	}
        return retVal;
    }
    
    @Override
    public Map<String, String> getPureProjectIds(){
    	Map<String, String> projectIds = new HashMap<>();
    	System.out.println("flat file dir is : " + this.getFlatFileDir());
        File projectIdsFullFile  = new File(this.getFlatFileDir() + PureFlatFileProvider.PURE_PROJECT_IDS_FILE_NAME);
        if (projectIdsFullFile.exists()) {
			try (LineIterator fullIt = FileUtils.lineIterator(projectIdsFullFile, "UTF-8")) {
				while (fullIt.hasNext()) {
		    	    String line = fullIt.nextLine();
		    	    String[] splitLine = line.split("\t");
		    	    if (splitLine.length == 2) {
		    	    	projectIds.put(splitLine[0], splitLine[1]);
		    	    }
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
        }
    	
    	return projectIds;
    }
    
    @Override
    public String getPureProjectId(String datasetId){
    	String projectId = null;
    	if(datasetId != null) {
			Map<String, String> pureProjectIds = this.getPureProjectIds();
			if(pureProjectIds != null) {
				projectId = pureProjectIds.get(datasetId);
			}
    	}
    	return projectId;
    }
}
