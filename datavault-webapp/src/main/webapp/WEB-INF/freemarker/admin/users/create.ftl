<#import "*/layout/defaultlayout.ftl" as layout>
<@layout.vaultLayout>
<#import "/spring.ftl" as spring />

<div class="container">

    <ol class="breadcrumb">
        <li class="active"><b>Create User</b></li>
    </ol>

    <form id="create-user" class="form" role="form" action="" method="post">

        <div class="form-group">
            <label class="control-label">User ID:</label>
            <@spring.bind "user.id" />
            <input type="text"
                   class="form-control"
                   name="${spring.status.expression}"
                   value="${spring.status.value!""}"/>
        </div>


        <div class="form-group">
            <label class="control-label">User Name:</label>
            <@spring.bind "user.name" />
            <input type="text"
                   class="form-control"
                   name="${spring.status.expression}"
                   value="${spring.status.value!""}"/>
        </div>

        <div class="form-group">
            <button type="submit" name="action" value="submit" class="btn btn-primary"><span class="glyphicon glyphicon-save"></span>Save</button>
            <button type="submit" name="action" value="cancel" class="btn btn-danger cancel">Cancel</button>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    </form>
</div>

<script>
$(document).ready(function () {

$('#create-user').validate({
    rules: {
        note: {
            required: true
        }
    },
    highlight: function (element) {
        $(element).closest('.form-group').removeClass('has-success').addClass('has-error');
    },
    success: function (element) {
        element.addClass('valid')
                .closest('.form-group').removeClass('has-error').addClass('has-success');
    }
});
});
</script>

</@layout.vaultLayout>