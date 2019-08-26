<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<style>
        body {
        font-family: 'Open Sans', sans-serif;
    }
    
    .fb-profile img.fb-image-lg {
        z-index: 0;
        width: 100%;
        margin-bottom: 10px;
    }
    
    .fb-image-profile {
        margin: -90px 10px 20px 80px;
        z-index: 9;
        width: 20%;
    }
    /***
Bootstrap Line Tabs by @keenthemes
A component of Metronic Theme - #1 Selling Bootstrap 3 Admin Theme in Themeforest: http://j.mp/metronictheme
Licensed under MIT
***/
    /* Tabs panel */
    
    .tabbable-panel {
        border: 1px solid #eee;
        padding: 10px;
    }
    /* Default mode */
    
    .tabbable-line > .nav-tabs {
        border: none;
        margin: 0px;
    }
    
    .tabbable-line > .nav-tabs > li {
        margin-right: 2px;
    }
    
    .tabbable-line > .nav-tabs > li > a {
        border: 0;
        margin-right: 0;
        color: #737373;
    }
    
    .tabbable-line > .nav-tabs > li > a > i {
        color: #a6a6a6;
    }
    
    .tabbable-line > .nav-tabs > li.open,
    .tabbable-line > .nav-tabs > li:hover {
        border-bottom: 4px solid #fbcdcf;
    }
    
    .tabbable-line > .nav-tabs > li.open > a,
    .tabbable-line > .nav-tabs > li:hover > a {
        border: 0;
        background: none !important;
        color: #333333;
    }
    
    .tabbable-line > .nav-tabs > li.open > a > i,
    .tabbable-line > .nav-tabs > li:hover > a > i {
        color: #a6a6a6;
    }
    
    .tabbable-line > .nav-tabs > li.open .dropdown-menu,
    .tabbable-line > .nav-tabs > li:hover .dropdown-menu {
        margin-top: 0px;
    }
    
    .tabbable-line > .nav-tabs > li.active {
        border-bottom: 4px solid #f3565d;
        position: relative;
    }
    
    .tabbable-line > .nav-tabs > li.active > a {
        border: 0 !important;
        color: #333333;
    }
    
    .tabbable-line > .nav-tabs > li.active > a > i {
        color: #404040;
    }
    
    .tabbable-line > .tab-content {
        margin-top: -3px;
        background-color: #fff;
        border: 0;
        border-top: 1px solid #eee;
        padding: 15px 0;
    }
    
    .portlet .tabbable-line > .tab-content {
        padding-bottom: 0;
    }
    /* Below tabs mode */
    
    .tabbable-line.tabs-below > .nav-tabs > li {
        border-top: 4px solid transparent;
    }
    
    .tabbable-line.tabs-below > .nav-tabs > li > a {
        margin-top: 0;
    }
    
    .tabbable-line.tabs-below > .nav-tabs > li:hover {
        border-bottom: 0;
        border-top: 4px solid #fbcdcf;
    }
    
    .tabbable-line.tabs-below > .nav-tabs > li.active {
        margin-bottom: -2px;
        border-bottom: 0;
        border-top: 4px solid #f3565d;
    }
    
    .tabbable-line.tabs-below > .tab-content {
        margin-top: -10px;
        border-top: 0;
        border-bottom: 1px solid #eee;
        padding-bottom: 15px;
    }
    
    .menu_title {
        padding: 15px 10px;
        border-bottom: 1px solid #eee;
        margin: 0 5px;
    }
    
    @media (max-width:768px) {
        .fb-profile-text>h1 {
            font-weight: 700;
            font-size: 16px;
        }
        .fb-image-profile {
            margin: -45px 10px 0px 25px;
            z-index: 9;
            width: 20%;
        }
</style>
<script src="https://code.jquery.com/jquery-1.11.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<div class="container-fluid">
    <div class="row">
        <div class="fb-profile">
            <img align="left" class="fb-image-lg" src="https://dummyimage.com/850x200/f0f0f0/f0f0f0.png" alt="Profile image example" />
            <img align="left" class="fb-image-profile thumbnail" src="http://www.old-computers.com/museum/photos/gradiente_expert-plus_1.jpg" alt="Profile image example" />
            <div class="fb-profile-text">
                <h1><%=data.name%></h1>
                <p>
                    <%=data.manufacturer%>
                </p>
                <p>
                    <%=data.country%>
                </p>
                <p>
                    <%=data.year%>
                </p>
            </div>
        </div>
    </div>
</div>
<!-- container fluid-->
<div class="container">
    <div class="col-sm-8">

        <div data-spy="scroll" class="tabbable-panel">
            <div class="tabbable-line">
                <ul class="nav nav-tabs ">
                    <li class="active">
                        <a href="#tab_default_1" data-toggle="tab">About</a>
                    </li>
                    <li>
                        <a href="#tab_default_2" data-toggle="tab">Emulation</a>
                    </li>
                    <li>
                        <a href="#tab_default_3" data-toggle="tab">Documentation</a>
                    </li>
                    <li>
                        <a href="#tab_default_4" data-toggle="tab">Links</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_default_1">
                        <p>
                            <%=data.description%>
                        </p>
                    </div>
                    <div class="tab-pane" id="tab_default_2">

                    </div>
                    <div class="tab-pane" id="tab_default_3">

                    </div>
                    <div class="tab-pane" id="tab_default_4">
                        <div class="row">
                            <div class="col-sm-12">
                            <% for(var i=0; i < data.links.length; i++) { %>
                                <li><a href="<%= data.links[i]%>"><%= data.links[i]%></a></li>
                            <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class="col-sm-4">
        <div class="panel panel-default">
            <div class="menu_title">
                Technical Information
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12">
                        <% if (data.type) { %>
                        <div class="form-group">
                            <label for="email">Type:</label>
                            <p><%=data.type%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.cpu) { %>
                        <div class="form-group">
                            <label for="email">CPU:</label>
                            <p><%=data.technicalInformation.cpu%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.coprocessor) { %>
                        <div class="form-group">
                            <label for="email">Coprocessor:</label>
                            <p><%=data.technicalInformation.coprocessor%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.ram) { %>
                        <div class="form-group">
                            <label for="email">RAM:</label>
                            <p><%=data.technicalInformation.ram%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.rom) { %>
                        <div class="form-group">
                            <label for="email">ROM:</label>
                            <p><%=data.technicalInformation.rom%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.keyboard) { %>
                        <div class="form-group">
                            <label for="email">Keyboard:</label>
                            <p><%=data.technicalInformation.keyboard%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.language) { %>
                        <div class="form-group">
                            <label for="email">Language:</label>
                            <p><%=data.technicalInformation.language%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.buttons) { %>
                        <div class="form-group">
                            <label for="email">Buttons:</label>
                            <p><%=data.technicalInformation.buttons%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.controllers) { %>
                        <div class="form-group">
                            <label for="email">Controllers:</label>
                            <p><%=data.technicalInformation.controllers%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.builtInGames) { %>
                        <div class="form-group">
                            <label for="email">Built In Games:</label>
                            <p><%=data.technicalInformation.builtInGames%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.media) { %>
                        <div class="form-group">
                            <label for="email">Media:</label>
                            <p><%=data.technicalInformation.media%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.ports) { %>
                        <div class="form-group">
                            <label for="email">Ports:</label>
                            <p><%=data.technicalInformation.ports%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.size) { %>
                        <div class="form-group">
                            <label for="email">Size:</label>
                            <p><%=data.technicalInformation.size%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.colors) { %>
                        <div class="form-group">
                            <label for="email">Colors:</label>
                            <p><%=data.technicalInformation.colors%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.sound) { %>
                        <div class="form-group">
                            <label for="email">Sound:</label>
                            <p id="sound" contenteditable="true"><%=data.technicalInformation.sound%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.speed) { %>
                        <div class="form-group">
                            <label for="email">Speed:</label>
                            <p><%=data.technicalInformation.speed%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.graphics) { %>
                        <div class="form-group">
                            <label for="email">Graphics:</label>
                            <p><%=data.technicalInformation.graphics%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.vram) { %>
                        <div class="form-group">
                            <label for="email">VRAM:</label>
                            <p><%=data.technicalInformation.vram%></p>
                        </div>
                        <% } %>
                        
                        <% if (data.technicalInformation.text) { %>
                        <div class="form-group">
                            <label for="email">Text:</label>
                            <p><%=data.technicalInformation.text%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.switches) { %>
                        <div class="form-group">
                            <label for="email">Switches:</label>
                            <p><%=data.technicalInformation.switches%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.power) { %>
                        <div class="form-group">
                            <label for="email">Power:</label>
                            <p><%=data.technicalInformation.power%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.peripherals) { %>
                        <div class="form-group">
                            <label for="email">Peripherals:</label>
                            <p><%=data.technicalInformation.peripherals%></p>
                        </div>
                        <% } %>
                        
                        <% if (data.technicalInformation.batteries) { %>
                        <div class="form-group">
                            <label for="email">Batteries:</label>
                            <p><%=data.technicalInformation.batteries%></p>
                        </div>
                        <% } %>
                        <% if (data.technicalInformation.gun) { %>
                        <div class="form-group">
                            <label for="email">Gun:</label>
                            <p><%=data.technicalInformation.gun%></p>
                        </div>
                        <% } %>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
var editable = document.getElementById('sound');
editable.addEventListener('focusout', function() {
console.log(editable.innerHTML);

    $.ajax({
        url: '/system/<%=data.id%>',
        dataType: 'json',
        type: 'put',
        contentType: 'application/x-www-form-urlencoded',
        data: {
            "id": "<%=data.id%>",
            "technicalInformation.sound": editable.innerHTML,
        },
        success: function( data, textStatus, xhr ) {
            if(xhr.status==201 || xhr.status==200) {
                if(xhr.status==200) {
                	console.log("System updated");
                } else {
                	console.log("System added");
                }
            }
        },
        error: function( jqXhr, textStatus, errorThrown ){
            console.log( errorThrown );
        }
    });
  
});
</script>