TODOOOOOOOOOOOOOOOOOOOOO


<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>System<small>Maintenance</small></h1>
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
                
                    <div class="box-header with-border"><h3 class="box-title">New System</h3></div>
                	
                    <form role="form" id="system">
                
                        <div class="box-body">
		                    <div class="row">
			                    <div class="col-md-10 col-md-offset-1">
			                        <div id="message" role="alert"></div>
			                    </div>
		                    </div>
                        
                            <input type="hidden" id="id">
                            <div id="div-name" class="form-group">
                                <label for="name"><i id="i-name"></i> System</label>
                                
								<input type="text" class="form-control" id="name" name="name" placeholder="Enter name" autofocus>

                                
                            </div>
                            <div id="div-manufacturer" class="form-group">
                                <label for="name"><i id="i-manufacturer"></i> Manufacturer</label>
                                
								<input type="text" class="form-control" id="manufacturer" name="manufacturer" placeholder="Enter manufacturer" >

                                
                            </div>
                            <div id="div-type" class="form-group">
                                <label for="name"><i id="i-type"></i> Type</label>
                                
								<input type="text" class="form-control" id="type" name="type" placeholder="Enter type" >

                                
                            </div>
                            <div id="div-country" class="form-group">
                                <label for="name"><i id="i-country"></i> Country</label>
                                
								<input type="text" class="form-control" id="country" name="country" placeholder="Enter country" >

                                
                            </div>
                            <div id="div-year" class="form-group">
                                <label for="name"><i id="i-year"></i> Year</label>
                                
								<input type="text" class="form-control" id="year" name="year" placeholder="Enter year" >

                                
                            </div>
                            <div id="div-description" class="form-group">
                                <label for="name"><i id="i-description"></i> Description</label>
                                
								<input type="text" class="form-control" id="description" name="description" placeholder="Enter description" >

                                
                            </div>
                            <div id="div-price" class="form-group">
                                <label for="name"><i id="i-price"></i> price</label>
                                
								<input type="text" class="form-control" id="price" name="price" placeholder="Enter price" >

                                
                            </div>
                            <div id="div-technicalInformation" class="form-group">
                                <label for="name"><i id="i-technicalInformation"></i> technicalInformation</label>
                                
                                
                            </div>
                            <div id="div-adverts" class="form-group">
                                <label for="name"><i id="i-adverts"></i> adverts</label>
                                
                                
                            </div>
                            <div id="div-emulators" class="form-group">
                                <label for="name"><i id="i-emulators"></i> emulators</label>
                                
                                
                            </div>
                            <div id="div-links" class="form-group">
                                <label for="name"><i id="i-links"></i> links</label>
                                
                                
                            </div>
                            <div id="div-hardware" class="form-group">
                                <label for="name"><i id="i-hardware"></i> hardware</label>
                                
                                
                            </div>
                            <div id="div-shots" class="form-group">
                                <label for="name"><i id="i-shots"></i> shots</label>
                                
                                
                            </div>
                            
                            
                            <button type="button" id="submit" class="btn btn-primary">Submit</button>

    
                        </div>
      
                        <div class="box-footer">
                            <div id="table">
                                
                            </div>
                        </div>
                
                    </form>
                
                </div>

            </div>

        </div>

    </section>
</div>

<script>
function resetForm() {
	$("#system")[0].reset();
}


function save_system() {    
    
    $.ajax({
        url: $("#id").val() ? '/system/' + $("#id").val() : '/system',
        dataType: 'json',
        type: $("#id").val() ? 'put' : 'post',
        contentType: 'application/x-www-form-urlencoded',
        data: {
            "id": $("#id").val(),
            "name": $("#name").val(),
            "manufacturer": $("#manufacturer").val(),
            "type": $("#type").val(),
            "country": $("#country").val(),
            "year": $("#year").val(),
            "description": $("#description").val(),
            "price": $("#price").val(),
            "technicalInformation": $("#technicalInformation").val(),
            "adverts": $("#adverts").val(),
            "emulators": $("#emulators").val(),
            "links": $("#links").val(),
            "hardware": $("#hardware").val(),
            "shots": $("#shots").val(),
        },
        success: function( data, textStatus, xhr ) {
            if(xhr.status==201 || xhr.status==200) {
                $("#message").addClass("alert alert-success alert-dismissible fade in text-center");
                if(xhr.status==200) {
                	$("#message").text("System updated");
                } else {
                	$("#message").text("System added");
                }
            }
			resetForm();        
            loadData("system");
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}

function validateForm() {

	return true;
}


$("#submit").click(function() {
    if(validateForm()) {
        save_system();
    }
});

document.onkeydown=function(){
    if(window.event.keyCode == '13'){
        event.preventDefault();
        save_system();
    }
}

function edit_system(id) {
    console.log(id);
    $.ajax({
        url: '/system/' + id,
        dataType: 'json',
        type: 'get',
        success: function( data, textStatus, xhr ) {
        
            console.log('-->update ');
            console.log(data);
            $('#id').val(data.id);
            $('#name').val(data.name);
            $('#manufacturer').val(data.manufacturer);
            $('#type').val(data.type);
            $('#country').val(data.country);
            $('#year').val(data.year);
            $('#description').val(data.description);
            $('#price').val(data.price);
            $('#technicalInformation').val(data.technicalInformation);
            $('#adverts').val(data.adverts);
            $('#emulators').val(data.emulators);
            $('#links').val(data.links);
            $('#hardware').val(data.hardware);
            $('#shots').val(data.shots);
            //$('#name').focus();
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}

function delete_system(id) {
    console.log(id);
    $.ajax({
      url : "/system/" + id,
      type : "delete",
      success : function(data, textStatus, xhr) {
          console.log(data);
            if(xhr.status==200) {
                $("#message").addClass("alert alert-success alert-dismissible fade in text-center"); 
                $("#message").text("System deleted");
            }
          
          loadData("system");
          $("#message").text(data.message);
      }
    });
}

function createTable(target, data) {
    var tableDiv = document.getElementById("table");
    tableDiv.innerHTML = "";

    var table = document.createElement('TABLE');
    table.id = 'tableSystem';
    table.border = '1';
    table.className = 'table table-striped table-bordered';

    var header = table.createTHead();
    var row = header.insertRow(0);
    row.insertCell(0).outerHTML = "<th>name</th>";
    row.insertCell(1).outerHTML = "<th>manufacturer</th>";
    row.insertCell(2).outerHTML = "<th>type</th>";
    
    row.insertCell(-1).outerHTML = "<th>Actions</th>";

    var footer = table.createTFoot();
    var row = footer.insertRow(0);
    row.insertCell(0).outerHTML = "<th>name</th>";
    row.insertCell(1).outerHTML = "<th>manufacturer</th>";
    row.insertCell(2).outerHTML = "<th>type</th>";
    row.insertCell(-1).outerHTML = "<th>Actions</th>";

    var tableBody = document.createElement('TBODY');
    table.appendChild(tableBody);

    $.each(data, function(index, rows) {
        console.log(rows);
        for(var i=0; i < rows.length; i++) {
            var tr = document.createElement('TR');
            tableBody.appendChild(tr);        
            
            var td = document.createElement('TD');
            td.appendChild(document.createTextNode(rows[i].name));
            tr.appendChild(td);        
            var td = document.createElement('TD');
            td.appendChild(document.createTextNode(rows[i].manufacturer));
            tr.appendChild(td);        
            var td = document.createElement('TD');
            td.appendChild(document.createTextNode(rows[i].type));
            tr.appendChild(td);        
            
            
            
            // Actions column.
            var td = document.createElement('TD');
            var span = document.createElement('SPAN');
            span.innerHTML = '<a href="/system/' + rows[i].id + '/detail">detail</a>&nbsp;<a href="#" onclick=edit_'+ target + '("'+ rows[i].id + '")>edit</a>&nbsp;<a href="#" onclick=delete_' + target + '("'+ rows[i].id + '")>delete</a>';
            td.appendChild(span);
            tr.appendChild(td);
        };
    });

    tableDiv.appendChild(table);
    var dataTable = $("#tableSystem").DataTable();    
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
}

$( document ).ready(function() {
    loadData("system");
    //loadReferencedData();
});

</script>