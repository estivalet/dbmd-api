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
							<p class="help-block">${attribute.description}.</p>
						</div>
					</div>
					</#list>
					<!-- /.box-body -->
				</form>
			</div>
			<!-- /.box-body -->
			<div class="box-footer">
				<button id="submit" type="button" class="btn btn-primary">Submit</button>
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
$(function() {
	
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
            }
        });
    }
    
    function submitData() {
        var obj = { 
        <#list model.attributes as attribute>
        	"${attribute.name}" : document.getElementById("${attribute.name}").value,
		</#list>        	
        };
        callServer('http://localhost:8080/${app.shortName}/rest/${model.name}/add', "post", obj);
    }
    
    $("#submit").click(function() {
    	submitData();	
    });    
	
});
</script>



