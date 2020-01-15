  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">${string.toCamelCase(model.name)} Maintenance</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">${string.toCamelCase(model.name)} Maintenance</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-12">
            <!-- Default box -->
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">${string.toCamelCase(model.name)}</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                    <i class="fas fa-minus"></i></button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove" data-toggle="tooltip" title="Remove">
                    <i class="fas fa-times"></i></button>
                </div>
              </div>
              <div class="card-body">
              
              
                
                <div class="box-body">
                
	                <div id="search-form">
	                    <div class="row">
		                    <div class="col-md-12">
		                        <div id="message" role="alert"></div>
		                    </div>
	                    </div>
	                	<#list model.attributes as attribute>
	                	<#assign append_id=""/>
						<#assign index=attribute?index/>
						<#if (attribute.searchBy == true)>						                        	
						<#assign append_id="_search"/>
	                	<#include "../attributes.ejs.ftlh"/>
	                	</#if>
	                    </#list>
	                    
	                	<button type="button" id="search" class="btn btn-primary">Search</button>
	                </div>
                
	                <div id="add-form" class="d-none" autocomplete="off">
    	                <form role="form" id="${string.toCamelCase(model.name)}">
                            <input type="hidden" id="id">
							<#assign append_id=""/>                       	
                        	<#list model.attributes as attribute>
							<#assign index=attribute?index/>
                        	<#include "../attributes.ejs.ftlh"/>
                            </#list>
	   				        <#list model.getRefModels() as refmodel>
	   				        <#list refmodel.model.getRefAttributes() as refattr>
							<div class="form-group">
							    <label for="${string.toCamelCase(refattr.model)}_id">${refattr.model}'s ${refattr.label}</label>
							    <select class="form-control" id="${string.toCamelCase(refattr.model)}_id">
							    </select>
							</div>
						    </#list>
						    </#list>
						    
                            <button type="button" id="submit" class="btn btn-primary">Submit</button>
	                    </form>                
					</div>
					
					<p>&nbsp;</p>
	                <div id="search-result">
	                    <div class="box-footer">
	                        <div id="table">
	                            
	                        </div>
	                    </div>
					</div>                    
					            
                </div>
                
                
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                  <button type="button" id="add" class="btn btn-primary">Add new</button>
              </div>
              <!-- /.card-footer-->
            </div>
            <!-- /.card -->
          </div>
        </div>
      </div>
      
      <!-- /.modal -->
      <div class="modal fade" id="delete-modal">
        <div class="modal-dialog modal-sm">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title">Delete</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>Are you sure you want to delete this record?</p>
            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="delete_${string.toCamelCase(model.name)}()">Delete Record</button>
            </div>
            <input type="hidden" id="delete-id"/>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>
      <!-- /.modal -->
      
    </section>
    <!-- /.content -->
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->


<script>
$('#delete-modal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget);
  var id = button.data('id');
  var modal = $(this);
  modal.find('#delete-id').val(id);
});

function switchToSearchForm() {
	$("#add").removeClass("d-none");
	
	$("#search-result").removeClass();
	$("#search-form").removeClass();
	$("#add-form").removeClass();   
	
	$("#search-result").addClass("d-block");
	$("#search-form").addClass("d-block");
	$("#add-form").addClass("d-none");

}

function resetForm() {
	$("#${string.toCamelCase(model.name)}")[0].reset();
	<#list model.attributes as attribute>
	<#if attribute.required>
    $("#div-${attribute.name}").removeClass("has-error");
    $("#${attribute.name}").removeClass("is-invalid");
    </#if>
	</#list>
	
	switchToSearchForm();
}


function save_${string.toCamelCase(model.name)}() {    
    <#list model.attributes as attribute>
	<#if (attribute.type=="checkbox" || attribute.type=="radio")>
    var ${attribute.name}Selected = "";
    var ${attribute.name}Chk = $('input[name="${attribute.name}"]:checked');
    ${attribute.name}Chk.each(function(){
        ${attribute.name}Selected += this.value + ",";
    });
    ${attribute.name}Selected = ${attribute.name}Selected.slice(0, -1);
	</#if>    
    </#list>
    
    $.ajax({
        url: $("#id").val() ? '/${string.toCamelCase(model.name)}/' + $("#id").val() : '/${string.toCamelCase(model.name)}',
        dataType: 'json',
        type: $("#id").val() ? 'put' : 'post',
        contentType: 'application/x-www-form-urlencoded',
        data: {
            "id": $("#id").val(),
            <#list model.attributes as attribute>
            <#if (attribute.type=="checkbox" || attribute.type=="radio")>
            "${attribute.name}": ${attribute.name}Selected,
            <#else>
            "${attribute.name}": $("#${attribute.name}").val(),
            </#if>
            </#list>
			<#list model.getRefAttributesOfRefModels() as refattr>
			"${string.toCamelCase(refattr.model)}_id": $("#${string.toCamelCase(refattr.model)}_id").val(),
			</#list>
        },
        success: function( data, textStatus, xhr ) {
            if(xhr.status==201 || xhr.status==200) {
            	$("#message").removeClass();
                $("#message").addClass("d-block alert alert-success alert-dismissible text-center");
                if(xhr.status==200) {
                	$("#message").text("${model.name} updated");
                } else {
                	$("#message").text("${model.name} added");
                }
            }
			resetForm();
            loadData("${string.toCamelCase(model.name)}");
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}

function validateForm() {
	<#list model.attributes as attribute>
	<#if (attribute.required)>
    if($('#${attribute.name}').val() == ''){
    	$("#${attribute.name}").addClass("form-control is-invalid");
        $("#p-${attribute.name}").text("This field is required");
        $("#p-${attribute.name}").addClass("text-danger");
        $('#${attribute.name}').focus();
	    return false;
    }
    </#if>
    </#list>    

	return true;
}


$("#submit").click(function() {
    if(validateForm()) {
        save_${string.toCamelCase(model.name)}();
    }
});

function switchToAddEditForm() {
	$("#search-result").removeClass();
	$("#search-form").removeClass();
	$("#add-form").removeClass();   
	
	$("#add").addClass("d-none");
	$("#search-result").addClass("d-none");
	$("#search-form").addClass("d-none");
	$("#add-form").addClass("d-block");
}

$("#add").click(function() {
	switchToAddEditForm();
});

$("#search").click(function() {
    $.ajax({
        url : "/${string.toCamelCase(model.name)}",
        type : "get",
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded',
        data: {
            "search": true,
            <#list model.attributes as attribute>
			<#if (attribute.searchBy == true)>	
			"${attribute.name}": $("#${attribute.name}_search").val(),					                        	
	    	</#if>
            </#list>
		},        
        success : function(result) {
        	$("#message").removeClass();
		    $("#message").addClass("d-none");
            createTable("${string.toCamelCase(model.name)}", result);
        }
    });    

});

document.onkeydown=function(){
    if(window.event.keyCode == '13'){
        event.preventDefault();
        save_${string.toCamelCase(model.name)}();
    }
}

function edit_${string.toCamelCase(model.name)}(id) {
    $.ajax({
        url: '/${string.toCamelCase(model.name)}/' + id,
        dataType: 'json',
        type: 'get',
        success: function(result, textStatus, xhr ) {
            $('#id').val(result.data[0].id);
            <#list model.attributes as attribute>
            <#if (attribute.type=="radio")>
            $("input[name=${attribute.name}][value='" + result.data[0].${attribute.name} + "']").prop("checked",true);
            <#elseif (attribute.type=="checkbox")>
            result.data[0].${attribute.name}.split(/\s*,\s*/).forEach(function(value) {
                $("input[name=${attribute.name}][value='" + value + "']").prop("checked",true);
            });
			<#else>
            $('#${attribute.name}').val(result.data[0].${attribute.name});
            </#if>
            <#if (attribute?index == 0)>
            $('#${attribute.name}').focus();
            </#if>
            </#list>
            <#list model.getRefAttributesOfRefModels() as refattr>
            $('#${string.toCamelCase(refattr.model)}_id').val(result.data[0].${string.toCamelCase(refattr.model)}_id);
            </#list>
            switchToAddEditForm();
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}

function delete_${string.toCamelCase(model.name)}() {
    $.ajax({
      url : "/${string.toCamelCase(model.name)}/" + $("#delete-id").val(),
      type : "delete",
      success : function(data, textStatus, xhr) {
          console.log(data);
            if(xhr.status==200) {
            	$("#message").removeClass();
                $("#message").addClass("d-block alert alert-success alert-dismissible text-center"); 
                $("#message").text("${model.name} deleted");
                $('#id').val('');
                $('#delete-id').val('');
            }
          
          loadData("${string.toCamelCase(model.name)}");
      }
    });
}

function createTable(target, result) {
    var tableDiv = document.getElementById("table");
    tableDiv.innerHTML = "";

    var table = document.createElement('TABLE');
    table.id = 'table${string.toCamelCase(model.name, true)}';
    table.border = '1';
    table.className = 'table table-striped table-bordered';

    var header = table.createTHead();
    var row = header.insertRow(0);
    <#list model.attributes as attribute>
    <#if attribute.visibleInList>
    row.insertCell(${attribute?index}).outerHTML = "<th>${attribute.name}</th>";
    </#if>
    </#list>
    <#list model.getRefModels() as refmodel>
    <#if (refmodel.visibleInList)>
    <#list refmodel.getModel().getAttributes() as refmodelattr>
    <#if (refmodelattr.referencedVisible)>
	row.insertCell(-1).outerHTML = "<th>${refmodelattr.referencedLabel}</th>";
    </#if>
	</#list>
    </#if>
	</#list>
    
    row.insertCell(-1).outerHTML = "<th>Actions</th>";

    var footer = table.createTFoot();
    var row = footer.insertRow(0);
    <#list model.attributes as attribute>
    <#if attribute.visibleInList>
    row.insertCell(${attribute?index}).outerHTML = "<th>${attribute.name}</th>";
    </#if>
    </#list>
    <#list model.getRefModels() as refmodel>
    <#if (refmodel.visibleInList)>
    <#list refmodel.getModel().getAttributes() as refmodelattr>
    <#if (refmodelattr.referencedVisible)>
	row.insertCell(-1).outerHTML = "<th>${refmodelattr.referencedLabel}</th>";
    </#if>
	</#list>
    </#if>
	</#list>
    row.insertCell(-1).outerHTML = "<th>Actions</th>";

    var tableBody = document.createElement('TBODY');
    table.appendChild(tableBody);

    $.each(result.data, function(index, element) {
        var tr = document.createElement('TR');
        tableBody.appendChild(tr);        
        
	    <#list model.attributes as attribute>
	    <#if attribute.visibleInList>
        var td = document.createElement('TD');
        td.appendChild(document.createTextNode(element.${attribute.name}));
        tr.appendChild(td);        
	    </#if>
	    </#list>
	    
	    <#list model.getRefModels() as refmodel>
	    <#if (refmodel.visibleInList)>
	    <#list refmodel.getModel().getAttributes() as refmodelattr>
	    <#if (refmodelattr.referencedVisible)>
        var td = document.createElement('TD');
        td.appendChild(document.createTextNode(element.${string.toCamelCase(refmodel.name)}.${refmodelattr.name}));
        tr.appendChild(td);        
	    </#if>
		</#list>
	    </#if>
		</#list>
	    
	    
        // Actions column.
        var td = document.createElement('TD');
        var span = document.createElement('SPAN');
        //span.innerHTML = '<a href="/system/' + element.id + '/detail">detail</a>&nbsp;<a href="#" onclick=edit_'+ target + '("'+ element.id + '")>edit</a>&nbsp;<a href="#" onclick=delete_' + target + '("'+ element.id + '")>delete</a>';
        var html = '<div class="btn-group">';
        html += '<button type="button" class="btn btn-xs btn-default" onclick=edit_'+ target + '("'+ element.id + '")>Edit</button>';
        html += '<button type="button" data-id="' + element.id + '" data-toggle="modal" data-target="#delete-modal" class="btn btn-xs btn-danger">Delete</button></div>';
        span.innerHTML = html;
        
        td.appendChild(span);
        tr.appendChild(td);
	    
    });

    tableDiv.appendChild(table);
    var dataTable = $("#table${string.toCamelCase(model.name, true)}").DataTable({
        "language": {
             "search": "Filter records:"
        }        
    });    
}

function loadData(target) {
    $.ajax({
        url : "/" + target,
        type : "get",
        success : function(result) {
            createTable(target, result);
        }
    });    
}

function loadReferencedData() {
    <#list model.getRefAttributesOfRefModels() as refattr>
	$.ajax({
	       url: '/${string.toCamelCase(refattr.model)}',
	       type: 'GET',
	       error: function() {
	          console.log('<p>An error has occurred</p>');
	       },
	       dataType: 'json',
	       success: function(result) {
	    	   $("#${string.toCamelCase(refattr.model)}_id").empty();
	    	   $.each(result.data, function (i, item) {
	    		   console.log(item);
	    		    $('#${string.toCamelCase(refattr.model)}_id').append($('<option>', { 
	    		        value: item.id,
	    		        text : item.${string.toCamelCase(refattr.name)}
	    		    }));
	    		});	    	   
	       }
	});
	</#list>
}

$( document ).ready(function() {
    loadData("${string.toCamelCase(model.name)}");
    loadReferencedData();
	<#list model.attributes as attribute>
	<#if (attribute.type=="date")>
 	$('#${attribute.name}').inputmask('${attribute.mask}', { 'placeholder': '${attribute.mask}' });
    </#if>
    </#list>
});

</script>    