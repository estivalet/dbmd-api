<!-- Content Wrapper. Contains page content -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <h1>country<small>Control panel</small></h1>
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
                
                    <div class="box-header with-border"><h3 class="box-title">New country</h3></div>
                
                    <form role="form" id="country">
                
                        <div class="box-body">
                            <div class="form-group">
                                <label for="name">Name</label>
                                <input type="hidden" id="id">
                                <input type="text" class="form-control" id="name" name="name" placeholder="Enter country name">
                            </div>

                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <caption></caption>
                                    <thead class="thead-light">
                                        <tr>
                                            <th>country</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    
                                    <tbody id="countrys">
                                    </tbody>
                                </table>
                            </div> 
                            <ul class="pagination text-center" id="pagination">
                            </ul>
    
                        </div>
      
                        <div class="box-footer">
                            <button type="button" id="submit" class="btn btn-primary">Submit</button>
                        </div>
                
                    </form>
                
                </div>

            </div>

        </div>

    </section>
</div>

<script>
function save_country() {    
    $.ajax({
        url: $("#id").val() ? '/country/' + $("#id").val() : '/country',
        dataType: 'json',
        type: $("#id").val() ? 'put' : 'post',
        contentType: 'application/x-www-form-urlencoded',
        data: {
            "id": $("#id").val(),
            "name": $("#name").val(),
        },
        success: function( data, textStatus, jQxhr ) {
            $("#country")[0].reset();
            changePage("country", 1);
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}
$("#submit").click(function() {
    save_country();
});
document.onkeydown=function(){
    if(window.event.keyCode == '13'){
        event.preventDefault();
        save_country();
    }
}
function edit_country(id) {
    console.log(id);
    $.ajax({
        url: '/country/' + id,
        dataType: 'json',
        type: 'get',
        success: function( country, textStatus, jQxhr ) {
            console.log('-->update ');
            console.log(country);
            $('#id').val(country.id);
            $('#name').val(country.name);
            $('#name').focus();
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
}
function delete_country(id) {
    console.log(id);
    $.ajax({
      url : "/country/" + id,
      type : "delete",
      success : function(data) {
          console.log(data);
          changePage("country", 1);
      }
    });
}
