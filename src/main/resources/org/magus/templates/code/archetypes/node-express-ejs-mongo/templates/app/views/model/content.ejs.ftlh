<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>${model.name}<small>Maintenance</small></h1>
        <ol class="breadcrumb">
            <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
            <li class="active">Dashboard</li>
        </ol>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="row">
        
            <!-- left column -->
            <div class="col-md-6">

                <div class="box box-primary">
                
                    <div class="box-header with-border"><h3 class="box-title">New ${model.name}</h3></div>
                	
                    <form role="form" id="${string.toCamelCase(model.name)}">
                
                        <div class="box-body">
		                    <div class="row">
			                    <div class="col-md-10 col-md-offset-1">
			                        <div id="message" role="alert"></div>
			                    </div>
		                    </div>
                        
                        	<#list model.attributes as attribute>
                            <div id="div-${attribute.name}" class="form-group">
                                <label for="name"><i id="i-${attribute.name}"></i> ${attribute.label}</label>
                                <input type="hidden" id="id">
                                <input type="text" class="form-control" id="${attribute.name}" name="${attribute.name}" placeholder="Enter ${attribute.name} name">
								<#if (attribute.description?has_content)>
								<p id="p-${attribute.name}" class="help-block">${attribute.description}.</p>
								</#if>
                            </div>
                            </#list>
                            
	   				        <#list model.getReferencedAttributes() as refattr>
							<div class="form-group">
							    <label for="${string.toCamelCase(refattr.model.name)}Id">${refattr.model.name}'s ${refattr.label}</label>
							    <select class="form-control" id="${string.toCamelCase(refattr.model.name)}Id">
							    </select>
							</div>
						    </#list>
                            
                            <button type="button" id="submit" class="btn btn-primary">Submit</button>

    
                        </div>
      
                        <div class="box-footer">
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <caption></caption>
                                    <thead class="thead-light">
                                    <#list model.attributes as attribute>
                                        <tr>
                                            <th>${attribute.name}</th>
                                            <th></th>
                                        </tr>
									</#list>                                        
                                    </thead>
                                    
                                    <tbody id="${string.toCamelCase(model.name)}List">
                                    </tbody>
                                </table>
                            </div> 
                            <ul class="pagination text-center" id="pagination">
                            </ul>
                        </div>
                
                    </form>
                
                </div>

            </div>

        </div>

    </section>
</div>

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
    $.ajax({
        url: $("#id").val() ? '/${string.toCamelCase(model.name)}/' + $("#id").val() : '/${string.toCamelCase(model.name)}',
        dataType: 'json',
        type: $("#id").val() ? 'put' : 'post',
        contentType: 'application/x-www-form-urlencoded',
        data: {
            "id": $("#id").val(),
            <#list model.attributes as attribute>
            "${attribute.name}": $("#${attribute.name}").val(),
            </#list>
			<#list model.getReferencedAttributes() as refattr>
			"${string.toCamelCase(refattr.model.name)}Id": $("#${string.toCamelCase(refattr.model.name)}Id").val(),
			</#list>
        },
        success: function( data, textStatus, xhr ) {
            if(xhr.status==201 || xhr.status==200) {
                $("#message").addClass("alert alert-success alert-dismissible fade in text-center");
                if(xhr.status==200) {
                	$("#message").text("Author updated");
                } else {
                	$("#message").text("Author added");
                }
            }
			resetForm();        
            changePage("${string.toCamelCase(model.name)}", 1);
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
            $('#${string.toCamelCase(refattr.model.name)}Id').val(data.${string.toCamelCase(refattr.model.name)});
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
                $("#message").text("Author deleted");
            }
          
          changePage("${string.toCamelCase(model.name)}", 1);
          $("#message").text(data.message);
      }
    });
}


function changePage(target, page) {
    $.ajax({
      url : "/" + target + "?page=" + page,
      type : "get",
      success : function(result) {
          $("#id").val("");
          var tableBody = document.getElementById(target + "List");
          tableBody.innerHTML = "";
          $.each(result.data, function(index, element) {
            
            // Create a row.
            <#list model.attributes as attribute>
            var tr = document.createElement('TR');
            tableBody.appendChild(tr);
            // Name column.
            var td = document.createElement('TD');
            var span = document.createElement('SPAN');
            span.innerHTML = element.${string.toCamelCase(attribute.name)};
            td.appendChild(span);
            tr.appendChild(td);
            </#list>
            // Actions column.
            var td = document.createElement('TD');
            var span = document.createElement('SPAN');
            span.innerHTML = '<a href="#" onclick=edit_'+ target + '("'+ element.id + '")>edit</a>&nbsp;<a href="#" onclick=delete_' + target + '("'+ element.id + '")>delete</a>';
            td.appendChild(span);
            tr.appendChild(td);
          });
          var pagination = document.getElementById("pagination");
          pagination.innerHTML = "";
          var li = document.createElement('LI');
          var a = document.createElement('A');
          a.innerText = "First";
          li.appendChild(a);
          if (result.current == 1) {
            li.className = "disabled";
          } else {
            a.onclick = function() {
                changePage("${string.toCamelCase(model.name)}", 1);
            }
          }
          pagination.appendChild(li);
        
          var i = (Number(result.current) > 5 ? Number(result.current) - 4 : 1);
          if (i !== 1) {
            var li = document.createElement('LI');
            li.className = "disabled";
            var a = document.createElement('A');
            a.innerText = "...";
            li.appendChild(a);
            pagination.appendChild(li);
          }
          for (; i <= (Number(result.current) + 4) && i <= result.pages; i++) {
              var li = document.createElement('LI');
              var a = document.createElement('A');
              a.innerHTML = i;
              if (i == result.current) {
                li.className = "active";
              } else {
                a.onclick = function() {
                    changePage("${string.toCamelCase(model.name)}", this.innerText);
                }
              }
              if (i == Number(result.current) + 4 && i < result.pages) {
                li.className = "disabled";
                a.innerHTML = "...";
              } 
              li.appendChild(a);
              pagination.appendChild(li);
          }
          var li = document.createElement('LI');
          var a = document.createElement('A');
          a.innerHTML = "Last";
          if (result.current == result.pages) {
            li.className = "disabled";
          } else {
            a.onclick = function() {
                changePage("${string.toCamelCase(model.name)}", result.pages);
            }
          }
          li.appendChild(a);
          pagination.appendChild(li);
      }
    });
}

function loadReferencedData() {
    <#list model.getReferencedAttributes() as refattr>
	$.ajax({
	       url: '/${string.toCamelCase(refattr.model.name)}',
	       type: 'GET',
	       error: function() {
	          console.log('<p>An error has occurred</p>');
	       },
	       dataType: 'json',
	       success: function(data) {
	    	   $("#${string.toCamelCase(refattr.model.name)}Id").empty();
	    	   $.each(data, function (i, item) {
	    		   console.log(item);
	    		    $('#${string.toCamelCase(refattr.model.name)}Id').append($('<option>', { 
	    		        value: item.id,
	    		        text : item.${string.toCamelCase(refattr.name)}
	    		    }));
	    		});	    	   
	       }
	});
	</#list>
}

$( document ).ready(function() {
    changePage("${string.toCamelCase(model.name)}", 1);
    loadReferencedData();
});

</script>