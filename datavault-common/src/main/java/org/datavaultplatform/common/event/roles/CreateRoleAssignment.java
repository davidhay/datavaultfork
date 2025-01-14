package org.datavaultplatform.common.event.roles;

import org.datavaultplatform.common.event.Event;
import org.datavaultplatform.common.model.RoleAssignment;
import org.datavaultplatform.common.model.RoleType;

import javax.persistence.Entity;

@Entity
public class CreateRoleAssignment extends Event {

    CreateRoleAssignment() {};
    public CreateRoleAssignment(RoleAssignment roleAssignment, String creatorId) {
        super(roleAssignment.getRole().getName()+" role given to "+roleAssignment.getUserId()+" by "+creatorId);
        this.eventClass = CreateRoleAssignment.class.getCanonicalName();
    }
}
