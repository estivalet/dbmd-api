  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">Dashboard v2</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Dashboard v2</li>
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
                <h3 class="card-title">Title</h3>

                <div class="card-tools">
                  <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="Collapse">
                    <i class="fas fa-minus"></i></button>
                  <button type="button" class="btn btn-tool" data-card-widget="remove" data-toggle="tooltip" title="Remove">
                    <i class="fas fa-times"></i></button>
                </div>
              </div>
              <div class="card-body">
                
                
                    <form role="form" id="${string.toCamelCase(model.name)}">
                
                        <div class="box-body">
		                    <div class="row">
			                    <div class="col-md-10 col-md-offset-1">
			                        <div id="message" role="alert"></div>
			                    </div>
		                    </div>
                        
                            <input type="hidden" id="id">
                        	<#list model.attributes as attribute>
                            <div id="div-${attribute.name}" class="form-group">
                                <label for="name"><i id="i-${attribute.name}"></i> ${attribute.label}</label>
                                
                                <#if (attribute.type=="text")>
								<input type="text" class="form-control" id="${attribute.name}" name="${attribute.name}" placeholder="Enter ${attribute.name}" ${(attribute?index == 0)?then('autofocus','')}>

								<#elseif (attribute.type=="listbox")>
							    <select class="form-control" id="${attribute.name}">
								<#list attribute.options as option>
								<option value="${option.value}"> ${option.label}</option>
								</#list>	
							    </select>

								<#elseif (attribute.type=="date")>
								<input type="text" class="form-control" id="${attribute.name}" name="${attribute.name}" placeholder="Enter ${attribute.name}" ${(attribute?index == 0)?then('autofocus','')}>
																																
								<#elseif (attribute.type=="radio")>
								<#list attribute.options as option>
								<div class="radio">
								<label><input type="radio" name="${attribute.name}[]" value="${option.value}"> ${option.label}</label>
								</div>
								</#list>	

								<#elseif (attribute.type=="checkbox")>
								<#list attribute.options as option>
								<div class="form-check">
								<input type="checkbox" class="form-check-input" name="${attribute.name}[]" value="${option.value}"> 
								<label class="form-check-label">${option.label}</label>
								</div>
								</#list>	
																
								<#elseif (attribute.type=="textarea")>
								<textarea class="form-control" id="${attribute.name}" name="${attribute.name}" rows="3" placeholder="Enter ${attribute.name}" ${(attribute?index == 0)?then('autofocus','')}></textarea>								
																								
								</#if>
                                
								<#if (attribute.description?has_content)>
								<p id="p-${attribute.name}" class="help-block">${attribute.description}.</p>
								</#if>
                            </div>
                            </#list>
                            
	   				        <#list model.getReferencedAttributes() as refattr>
							<div class="form-group">
							    <label for="${string.toCamelCase(refattr.model)}Id">${refattr.model}'s ${refattr.label}</label>
							    <select class="form-control" id="${string.toCamelCase(refattr.model)}Id">
							    </select>
							</div>
						    </#list>
                            
                            <button type="button" id="submit" class="btn btn-primary">Submit</button>

    
                        </div>
      
                        <div class="box-footer">
                            <div id="table">
                                
                            </div>
                        </div>
                
                    </form>                
                
                
              </div>
              <!-- /.card-body -->
              <div class="card-footer">
                Footer
              </div>
              <!-- /.card-footer-->
            </div>
            <!-- /.card -->
          </div>
        </div>
      </div>
    </section>
    <!-- /.content -->
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->


<script>
function resetForm() {
	$("#${string.toCamelCase(model.name)}")[0].reset();
	<#list model.attributes as attribute>
	<#if attribute.required>
    if($('#${attribute.name}').val() == ''){
        $("#div-${attribute.name}").removeClass("has-error");
        $("#p-${attribute.name}").text("");
        <#if (attribute.description?has_content)>
        $("#p-${attribute.name}").html("${attribute.description}.");
        </#if>
        $("#i-${attribute.name}").removeClass("fa fa-times-circle-o");
    }
    </#if>
	</#list>
}


function save_${string.toCamelCase(model.name)}() {    
    <#list model.attributes as attribute>
	<#if (attribute.type=="checkbox" || attribute.type=="radio")>
    var ${attribute.name}Selected = "";
    var ${attribute.name}Chk = $('input[name="${attribute.name}[]"]:checked');
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
			<#list model.getReferencedAttributes() as refattr>
			"${string.toCamelCase(refattr.model)}Id": $("#${string.toCamelCase(refattr.model)}Id").val(),
			</#list>
        },
        success: function( data, textStatus, xhr ) {
            if(xhr.status==201 || xhr.status==200) {
                $("#message").addClass("alert alert-success alert-dismissible fade in text-center");
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
        $("#div-${attribute.name}").addClass("has-error");
        $("#p-${attribute.name}").text("This field is required");
        $("#i-${attribute.name}").addClass("fa fa-times-circle-o");
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

document.onkeydown=function(){
    if(window.event.keyCode == '13'){
        event.preventDefault();
        save_${string.toCamelCase(model.name)}();
    }
}

function edit_${string.toCamelCase(model.name)}(id) {
    console.log(id);
    $.ajax({
        url: '/${string.toCamelCase(model.name)}/' + id,
        dataType: 'json',
        type: 'get',
        success: function( data, textStatus, xhr ) {
        
            console.log('-->update ');
            console.log(data);
            $('#id').val(data.id);
            <#list model.attributes as attribute>
            $('#${attribute.name}').val(data.${attribute.name});
            </#list>
            <#list model.getReferencedAttributes() as refattr>
            $('#${string.toCamelCase(refattr.model)}Id').val(data.${string.toCamelCase(refattr.model)}.id);
            </#list>
            //$('#name').focus();
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}

function delete_${string.toCamelCase(model.name)}(id) {
    console.log(id);
    $.ajax({
      url : "/${string.toCamelCase(model.name)}/" + id,
      type : "delete",
      success : function(data, textStatus, xhr) {
          console.log(data);
            if(xhr.status==200) {
                $("#message").addClass("alert alert-success alert-dismissible fade in text-center"); 
                $("#message").text("${model.name} deleted");
            }
          
          loadData("${string.toCamelCase(model.name)}");
          $("#message").text(data.message);
      }
    });
}

function createTable(target, data) {
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

    $.each(data, function(index, element) {
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
        span.innerHTML = '<a href="/system/' + element.id + '/detail">detail</a>&nbsp;<a href="#" onclick=edit_'+ target + '("'+ element.id + '")>edit</a>&nbsp;<a href="#" onclick=delete_' + target + '("'+ element.id + '")>delete</a>';
        td.appendChild(span);
        tr.appendChild(td);
	    
    });

    tableDiv.appendChild(table);
    var dataTable = $("#table${string.toCamelCase(model.name, true)}").DataTable();    
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
    <#list model.getReferencedAttributes() as refattr>
	$.ajax({
	       url: '/${string.toCamelCase(refattr.model)}',
	       type: 'GET',
	       error: function() {
	          console.log('<p>An error has occurred</p>');
	       },
	       dataType: 'json',
	       success: function(data) {
	    	   $("#${string.toCamelCase(refattr.model)}Id").empty();
	    	   $.each(data, function (i, item) {
	    		   console.log(item);
	    		    $('#${string.toCamelCase(refattr.model)}Id').append($('<option>', { 
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
});

</script>    