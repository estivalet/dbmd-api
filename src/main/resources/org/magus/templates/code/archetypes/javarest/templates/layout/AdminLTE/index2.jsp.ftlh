<%@include file="../header.jsp"%>

<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
	<section class="content-header">
		<h1>
			Fixed Layout <small>Blank example to the fixed layout</small>
		</h1>
		<ol class="breadcrumb">
			<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
			<li><a href="#">Layout</a></li>
			<li class="active">Fixed</li>
		</ol>
	</section>

	<!-- Main content -->
	<section class="content">

		<!-- Default box -->
		<div class="box box-primary">
			<div class="box-header with-border">
				<h3 class="box-title">${model.name}</h3>

				<div class="box-tools pull-right">
					<button type="button" class="btn btn-box-tool"
						data-widget="collapse" data-toggle="tooltip" title="Collapse">
						<i class="fa fa-minus"></i>
					</button>
					<button type="button" class="btn btn-box-tool" data-widget="remove"
						data-toggle="tooltip" title="Remove">
						<i class="fa fa-times"></i>
					</button>
				</div>
			</div>
			<div class="box-body">
				<!-- form start -->
				<form role="form">
					<div class="box-body">
				    <#list model.attributes as attribute>
						<div class="form-group">
							<label for="${attribute.name}">${attribute.label}</label>
							<input type="text" class="form-control" id="${attribute.name}" placeholder="Enter ${attribute.name}">
							<#if (attribute.description?has_content)>
							<p class="help-block">${attribute.description}.</p>
							</#if>
						</div>
					</#list>
					</div>
					<!-- /.box-body -->
				</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button id="submit" type="button" class="btn btn-primary">Submit</button>
				<div id="box-body"/>
			</div>
			<!-- /.box-footer-->
		</div>
		<!-- /.box -->

	</section>
	<!-- /.content -->
</div>
<!-- /.content-wrapper -->

<!--#include "footer.jsp.ftlh"-->
<%@include file="../footer.jsp"%>

<script>
var currentObjId = null;

function edit(obj) {
	console.log(obj);
	currentObjId = obj.id;
    <#list model.attributes as attribute>
    document.getElementById("${attribute.name}").value = obj.${attribute.name};
	</#list>        	
}

function remove(obj) {
	console.log(obj);
	currentObjId = obj.id;
	callServer('http://localhost:8080/${app.shortName}/rest/${string.toCamelCase(model.name)}/delete', "delete", obj);
}


function callServer(url, type, obj) {
    $.ajax({
        url: url,
        contentType: "application/json",
        data: JSON.stringify(obj),                      
        type: type,
        error: function(xhr, status, error) {
        },
        success: function(data) {
            console.log("OK" + data);
            list();
        }
    });
}

function clearForm() {
    <#list model.attributes as attribute>
    document.getElementById("${attribute.name}").value = "";
	</#list>        	
}

function submitData() {
    var obj = { 
    <#list model.attributes as attribute>
    	"${attribute.name}" : document.getElementById("${attribute.name}").value,
	</#list>        	
    	"id":currentObjId,
    };
    clearForm();
    callServer('http://localhost:8080/${app.shortName}/rest/${string.toCamelCase(model.name)}/add', "post", obj);
}

function list() {
	currentObjId = null;
	$.ajax({
       url: 'http://localhost:8080/${app.shortName}/rest/${string.toCamelCase(model.name)}/list',
       type: 'GET',
       error: function() {
          console.log('<p>An error has occurred</p>');
       },
       dataType: 'json',
       success: function(data) {
           document.getElementById("box-body").innerHTML = "";

           // Creates the table to hold data.                   	   
		   var table = createTable("box-body","${string.toCamelCase(model.name)}s","table table-striped table-bordered");
		   
		   // Build table header by adding columns to the table.
		   var columns = [];
		   <#list model.attributes as attribute>
           columns.push("${attribute.label}");
		   </#list>
		   // Add extra columns for editing links.
           columns.push("");
           addTableHeader(table, columns);

           // Retrieve data to populate the table.
           var tableBody = addTableBody(table);
           data.forEach(function(obj) { 
               var tr = addTableRow(tableBody);
		       <#list model.attributes as attribute>
		       addTableCell(tr, obj.${attribute.name});
		       addTableCellHTML(tr, "<a href='#' onclick='edit(" + JSON.stringify(obj) + ")'>Edit</a>&nbsp;<a href='#' onclick='remove(" + JSON.stringify(obj) + ")'>Delete</a>");
		       </#list>
           });
		   
           $("#${string.toCamelCase(model.name)}s").DataTable({
               "ordering" : true,
               "searching" : true,
               "paging" : true,
               "dom" : "ftp",
               "pageLength" : 5,
               "language": {
                   //"url": "plugins/DataTables-1.10.12/i18n/ptBR.json"
               }
           });
		   
       }
    });
}    

$("#submit").click(function() {
	submitData();	
});    

list();

</script>



