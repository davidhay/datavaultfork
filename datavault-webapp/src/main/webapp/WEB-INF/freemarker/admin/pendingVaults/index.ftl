<#import "*/layout/defaultlayout.ftl" as layout>
<#-- Specify which navbar element should be flagged as active -->
<#global nav="admin">
<@layout.vaultLayout>

<div class="container">

    <ol class="breadcrumb">
        <li><a href="${springMacroRequestContext.getContextPath()}/admin/"><b>Administration</b></a></li>
        <li class="active"><b>Pending Vaults</b></li>
    </ol>
    
    <h1>Pending Vaults</h1>
    
     <form id="search-pendingvaults" class="form" role="form" action="" method="get">
        <div class="input-group">
            <input type="text" class="form-control" value="${query?url}" name="query" placeholder="Search for...">
            <div class="input-group-btn">
                <button class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> Search</button>
            </div>
        </div>
    </form>

    <#if confirmedPendingVaults?has_content>
        <h2>Confirmed</h2>
        
        <div class="table-responsive" id="pendingVaultsTable">
            <table class="table table-striped">
                <thead>
                    <tr class="tr">
                       <th><a href="?sort=name&order=${ordername}&query=${query?url}">Vault Name<#if sort == "name"><#if order == "desc"><span class="dropup"><span class="caret"></span></span><#else><span class="caret"></span></#if></#if></a></th>     
                       
                       <th>Owner</th>
                       <th>Vault Creator</th>
                       <th>Date Created</th>
                       <th>View</th>
                    </tr>
                </thead>

                <tbody>
                     <#list confirmedPendingVaults as pendingVault>
                        <tr class="tr">
                            <td>
                                ${pendingVault.name?html}
                            </td>
                             <td>
                               <#if (pendingVault.ownerId)??>
                                  ${pendingVault.ownerId?html}
                               </#if>
                              
                            </td>
                             <td>
                               <#if (pendingVault.vaultCreatorId)??>
                                  ${pendingVault.vaultCreatorId?html}
                               </#if>
                              
                            </td>
                             <td>
                                <#if (pendingVault.getCreationTime())??>
                                  ${pendingVault.getCreationTime()?date}
                                </#if>
                             </td>
                             <td>
                               
                                 <#if (pendingVault.getUserID())??>
                                    <a href="${springMacroRequestContext.getContextPath()}/admin/pendingVaults/summary/${pendingVault.getID()}" class="btn btn-primary">
                                      View 
                                    </a>
                                  </#if>  
                                </td>
                               
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>
        
         <div align="center">
            	<p class="text-info">${confirmedRecordsInfo}</p>
            </div>
            <div align="center">
            <nav aria-label="...">
			    <ul class="pagination pagination-lg" id="paginationButton">
                    <#list 1..numberOfConfirmedPages as page>
				    	<li <#if page == activePageId>class="page-item active"<#else>class="page-item"</#if> id="${page}">
				     	 <a class="page-link" href="${springMacroRequestContext.getContextPath()}/admin/pendingVaults?sort=${sort}&order=${order}&pageId=${page}&query=${query}" tabindex="-1">${page}</a>
				    	</li>
					</#list>
				 </ul>
			</nav>
        </div>
        
            
     </#if>

    <#if savedPendingVaults?has_content>
        <h2>Saved</h2>

        <div class="table-responsive" id="pendingVaultsTable">
            <table class="table table-striped">
                <thead>
                <tr class="tr">
                    <th><a href="?sort=name&order=${ordername}&query=${query?url}">Vault Name<#if sort == "name"><#if order == "desc"><span class="dropup"><span class="caret"></span></span><#else><span class="caret"></span></#if></#if></a></th>

                    <th>Owner</th>
                    <th>Vault Creator</th>
                    <th>Date Created</th>
                    <th>View</th>
                </tr>
                </thead>

                <tbody>
                <#list savedPendingVaults as pendingVault>
                    <tr class="tr">
                        <td>
                            ${pendingVault.name?html}
                        </td>
                        <td>
                            <#if (pendingVault.ownerId)??>
                                ${pendingVault.ownerId?html}
                            </#if>

                        </td>
                        <td>
                            <#if (pendingVault.vaultCreatorId)??>
                                ${pendingVault.vaultCreatorId?html}
                            </#if>

                        </td>
                        <td>
                            <#if (pendingVault.getCreationTime())??>
                                ${pendingVault.getCreationTime()?date}
                            </#if>
                        </td>
                        <td>

                            <#if (pendingVault.getUserID())??>
                                <a href="${springMacroRequestContext.getContextPath()}/admin/pendingVaults/summary/${pendingVault.getID()}" class="btn btn-primary">
                                    View
                                </a>
                            </#if>
                        </td>

                    </tr>
                </#list>
                </tbody>
            </table>
        </div>

        <div align="center">
            <p class="text-info">${savedRecordsInfo}</p>
        </div>
        <div align="center">
            <nav aria-label="...">
                <ul class="pagination pagination-lg" id="paginationButton">
                    <#list 1..numberOfSavedPages as page>
                        <li <#if page == activePageId>class="page-item active"<#else>class="page-item"</#if> id="${page}">
                            <a class="page-link" href="${springMacroRequestContext.getContextPath()}/admin/pendingVaults?sort=${sort}&order=${order}&pageId=${page}&query=${query}" tabindex="-1">${page}</a>
                        </li>
                    </#list>
                </ul>
            </nav>
        </div>


    </#if>
     
     
   
   
</div>
 

</@layout.vaultLayout>
