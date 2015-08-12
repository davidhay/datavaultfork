package org.datavault.worker.jobs;

import java.util.Map;
import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.datavault.common.job.Context;
import org.datavault.common.job.Job;
import org.datavault.worker.queue.EventSender;
import org.datavault.common.event.Event;
import org.datavault.common.event.Error;

import org.apache.commons.io.FileUtils;

public class Restore extends Job {
    
    @Override
    public void performAction(Context context) {
        
        EventSender eventStream = (EventSender)context.getEventStream();
        
        System.out.println("\tRestore job - performAction()");
        
        Map<String, String> properties = getProperties();
        String depositId = properties.get("depositId");
        String bagID = properties.get("bagId");
        String restorePath = properties.get("restorePath");
        
        eventStream.send(new Event(depositId, "Data restore started"));
        
        System.out.println("\tbagID: " + bagID);
        System.out.println("\trestorePath: " + restorePath);
        
        try {
            Path path = Paths.get(restorePath);
            File dir = path.toFile();

            if (!dir.exists() || !dir.isDirectory()) {
                // Target path must exist and be a directory
                System.out.println("\tTarget directory not found!");
            }

            // Find the archived data
            // TODO: a filesystem driver should transform a bagID to an actual path
            String tarFileName = bagID + ".tar";
            Path archivePath = Paths.get(context.getArchiveDir()).resolve(tarFileName);
            File archiveFile = archivePath.toFile();

            // Copy the tar file to the target restore area
            System.out.println("\tCopying tar file from archive ...");
            File restoreFile = path.resolve(tarFileName).toFile();
            FileUtils.copyFile(archiveFile, restoreFile);
            
            System.out.println("\tData restore complete: " + restoreFile);
            eventStream.send(new Event(depositId, "Data restore completed"));
            
        } catch (Exception e) {
            e.printStackTrace();
            eventStream.send(new Error(depositId, "Data restore failed: " + e.getMessage()));
        }
    }
}