package org.datavaultplatform.common.model;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

@JsonIgnoreProperties(ignoreUnknown = true)
@Entity
@Table(name="Permissions")
@NamedEntityGraph(name=PermissionModel.EG_PERMISSION_MODEL)
public class PermissionModel {

    public static final String EG_PERMISSION_MODEL = "eg.PermissionModel.1";

    public enum PermissionType {
        SCHOOL,
        VAULT,
        ADMIN
    }

    @Id
    @Column(name = "id", unique = true, length = 36)
    private String id;

    @Enumerated(EnumType.STRING)
    @Column(name = "permission", unique = true, nullable = false, columnDefinition = "VARCHAR(255)" )
    private Permission permission;

    @Column(name = "label", nullable = false, columnDefinition = "TEXT")
    private String label;

    @Enumerated(EnumType.STRING)
    @Column(name = "type", nullable = false, columnDefinition = "TEXT")
    private PermissionType type;

    public static PermissionModel createDefault(Permission permission) {
        PermissionModel p = new PermissionModel();
        p.setId(permission.getId());
        p.setPermission(permission);
        p.setType(permission.getDefaultType());
        p.setLabel(permission.getDefaultLabel());
        return p;
    }

    public PermissionModel() {}

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Permission getPermission() {
        return permission;
    }

    public void setPermission(Permission permission) {
        this.permission = permission;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public PermissionType getType() {
        return type;
    }

    public void setType(PermissionType type) {
        this.type = type;
    }

    public boolean isSchoolPermission() {
        return type == PermissionType.SCHOOL;
    }

    public boolean isVaultPermission() {
        return type == PermissionType.VAULT;
    }

    public boolean isAdminPermission() {
        return type == PermissionType.ADMIN;
    }

    public boolean isAllowedForRoleType(RoleType roleType) {
        switch (roleType) {
            case ADMIN:
                return true;
            case SCHOOL:
                return isSchoolPermission();
            case VAULT:
                return isVaultPermission();
            default:
                return false;
        }
    }
    @Override
    public boolean equals(Object obj){
        if (obj == null) { return false; }
        if (obj == this) { return true; }
        if (obj.getClass() != getClass()) {
            return false;
        }
        PermissionModel rhs = (PermissionModel) obj;
        return new EqualsBuilder()
            .append(this.id, rhs.id).isEquals();
    }

    @Override
    public int hashCode() {
        // you pick a hard-coded, randomly chosen, non-zero, odd number
        // ideally different for each class
        return new HashCodeBuilder(17, 37).
            append(id).toHashCode();
    }
}
