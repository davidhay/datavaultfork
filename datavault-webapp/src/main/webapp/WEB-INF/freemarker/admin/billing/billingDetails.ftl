<#import "*/layout/defaultlayout.ftl" as layout> 
<#global nav="admin">
<#import "/spring.ftl" as spring />
<@layout.vaultLayout>
<div class="container">

	<ol class="breadcrumb">
		<li><a
			href="${springMacroRequestContext.getContextPath()}/admin/"><b>Administration</b></a></li>
		<li><a
			href="${springMacroRequestContext.getContextPath()}/admin/billing"><b>Billing</b></a></li>
		<li class="active"><b>BillingDetails:</b>${billingDetails.vaultName?html}</li>
	</ol>
<div class="panel panel-uoe-low">
 <div class="panel-body">
	<h2>Billing Details: <small>${billingDetails.vaultName?html}</small></h2>
		
		<br/>
		<table class="table table-sm">
			<tbody>
				<tr>
					<th scope="col">Contact Name</th>
					<td><#if billingDetails.contactName??>${billingDetails.contactName?html}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">School/Unit</th>
					<td><#if billingDetails.school??>${billingDetails.school?html}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">Subunit</th>
					<td><#if billingDetails.subUnit??>${billingDetails.subUnit}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">Project Id</th>
					<td><#if billingDetails.projectID??>${billingDetails.projectID}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">Use Budget code</th>
					<td><#if billingDetails.getBudgetCodeStr()??>${billingDetails.getBudgetCodeStr()?html}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">Amount to be billed</th>
					<td><#if billingDetails.getAmountToBeBilled()??>${billingDetails.getAmountToBeBilled()?html}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">Amount billed</th>
					<td><#if billingDetails.getAmountBilled()??>${billingDetails.getAmountBilled()?html}<#else>_</#if></td>
				</tr>
				<tr>
					<th scope="col">Special arrangement comments</th>
					<td><#if billingDetails.getSpecialComments()??>${billingDetails.getSpecialComments()?html}<#else>_</#if></td>
				</tr>
			</tbody>
		</table>
		
		<div class="btn-toolbar pull-right">
			<button type="button" class="btn btn-default pull-right" data-toggle="modal" data-target="#update-billingDetails">
                                        Edit
             </button>
        </div>
        <div id="update-billingDetails" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="updateBillingDetails" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form id="update-billingDetails-form" class="form" role="form" action="${springMacroRequestContext.getContextPath()}/admin/billing/${billingDetails.vaultID}/updateBillingDetails" method="post">
                    <div class="modal-header">
                        <h4 class="modal-title" id="addDataManger">Billing Details</h4>
                    </div>
                    <div class="modal-body">
                    	<div class="form-group">
                            <label class="control-label">Contact Name:</label>
                            <@spring.bind "billingDetails.contactName" />
                            <input type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="contactName"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">School/Unit:</label>
                            <@spring.bind "billingDetails.school" />
                            <input type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="school"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Subunit:</label>
                            <@spring.bind "billingDetails.subUnit" />
                            <input type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="subunit"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">ProjectId:</label>
                            <@spring.bind "billingDetails.projectID" />
                            <input type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="projectId"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Use BudgetCode:</label>
                            <@spring.bind "billingDetails.budgetCode" />
                            <input type="hidden" name="_${spring.status.expression}" value="false"/>
                             <input type="checkbox" id="budgetCode" name="${spring.status.expression}"
                   <#if spring.status.value?? && spring.status.value?string=="true">checked="true"</#if> /> 
                        </div>
                        <div class="form-group">
                            <label class="control-label">Amount to be billed:</label>
                            <@spring.bind "billingDetails.amountToBeBilled" />
                            <input type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="amountToBeBilled"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Amount billed:</label>
                            <@spring.bind "billingDetails.amountBilled" />
                            <input type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="amountBilled"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label">Special arrangements comments:</label>
                            <@spring.bind "billingDetails.specialComments" />
                            <textarea type="text" class="form-control" name="${spring.status.expression}"
                   value="${spring.status.value!""}" id="comments" rows="4" cols="60"><#if billingDetails.getSpecialComments()??>${billingDetails.getSpecialComments()}</#if></textarea>
                        </div>
                    </div>

                    <input type="hidden" id="submitAction" name="action" value="submit"/>
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="vaultID" value="${billingDetails.getVaultID()}"/>
					<input type="hidden" name="vaultName" value="${billingDetails.getVaultName()}"/>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" id="update-billingDetails-btn" class="btn btn-primary btn-ok">Save</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>

<input type="hidden" name="${_csrf.parameterName}"
	value="${_csrf.token}" />
</div>
</@layout.vaultLayout> 