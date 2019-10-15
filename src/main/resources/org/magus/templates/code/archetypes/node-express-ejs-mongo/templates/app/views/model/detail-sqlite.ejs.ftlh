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
                <h1 class="databox" id="name" contenteditable="true"><%=rows[0].name%></h1>
                <p class="databox" id="manufacturer" contenteditable="true"><%=rows[0].manufacturer%></p>
                <p class="databox" id="country" contenteditable="true"><%=rows[0].country%></p>
                <p class="databox" id="year" contenteditable="true"><%=rows[0].year%></p>
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
                        <a href="#tab_default_2" data-toggle="tab">Hardware</a>
                    </li>
                    <li>
                        <a href="#tab_default_3" data-toggle="tab">Emulation</a>
                    </li>
                    <li>
                        <a href="#tab_default_4" data-toggle="tab">Documentation</a>
                    </li>
                    <li>
                        <a href="#tab_default_5" data-toggle="tab">Links</a>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-pane active" id="tab_default_1">
                        <span id="description"></span>
                    </div>
                    <div class="tab-pane" id="tab_default_2">
                    </div>
                    <div class="tab-pane" id="tab_default_3">

                    </div>
                    <div class="tab-pane" id="tab_default_4">
                    </div>
                    <div class="tab-pane" id="tab_default_5">
                        <div class="row">
                            <div class="col-sm-12">
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
                        <% if (rows[0].type) { %>
                            <div class="form-group">
                            <label for="email">Type:</label>
                            <p class="databox" id="type" contenteditable="true"><%=rows[0].type%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].cpu) { %>
                        <div class="form-group">
                            <label for="email">CPU:</label>
                            <p class="databox" id="technicalInformation.cpu" contenteditable="true"><%=rows[0].cpu%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].coprocessor) { %>
                        <div class="form-group">
                            <label for="email">Coprocessor:</label>
                            <p class="databox" id="technicalInformation.coprocessor" contenteditable="true"><%=rows[0].coprocessor%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].ram) { %>
                        <div class="form-group">
                            <label for="email">RAM:</label>
                            <p class="databox" id="technicalInformation.ram" contenteditable="true"><%=rows[0].ram%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].rom) { %>
                        <div class="form-group">
                            <label for="email">ROM:</label>
                            <p class="databox" id="technicalInformation.rom" contenteditable="true"><%=rows[0].rom%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].keyboard) { %>
                        <div class="form-group">
                            <label for="email">Keyboard:</label>
                            <p class="databox" id="technicalInformation.keyboard" contenteditable="true"><%=rows[0].keyboard%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].language) { %>
                        <div class="form-group">
                            <label for="email">Language:</label>
                            <p class="databox" id="technicalInformation.language" contenteditable="true"><%=rows[0].language%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].buttons) { %>
                        <div class="form-group">
                            <label for="email">Buttons:</label>
                            <p class="databox" id="technicalInformation.buttons" contenteditable="true"><%=rows[0].buttons%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].controllers) { %>
                        <div class="form-group">
                            <label for="email">Controllers:</label>
                            <p class="databox" id="technicalInformation.controllers" contenteditable="true"><%=rows[0].controllers%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].built_in_games) { %>
                        <div class="form-group">
                            <label for="email">Built In Games:</label>
                            <p class="databox" id="technicalInformation.builtInGames" contenteditable="true"><%=rows[0].builtInGames%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].media) { %>
                        <div class="form-group">
                            <label for="email">Media:</label>
                            <p class="databox" id="technicalInformation.media" contenteditable="true"><%=rows[0].media%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].ports) { %>
                        <div class="form-group">
                            <label for="email">Ports:</label>
                            <p class="databox" id="technicalInformation.ports" contenteditable="true"><%=rows[0].ports%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].size) { %>
                        <div class="form-group">
                            <label for="email">Size:</label>
                            <p class="databox" id="technicalInformation.size" contenteditable="true"><%=rows[0].size%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].colors) { %>
                        <div class="form-group">
                            <label for="email">Colors:</label>
                            <p class="databox" id="technicalInformation.colors" contenteditable="true"><%=rows[0].colors%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].sound) { %>
                        <div class="form-group">
                            <label for="email">Sound:</label>
                            <p class="databox" id="technicalInformation.sound" contenteditable="true"><%=rows[0].sound%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].speed) { %>
                        <div class="form-group">
                            <label for="email">Speed:</label>
                            <p class="databox" id="technicalInformation.speed" contenteditable="true"><%=rows[0].speed%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].graphics) { %>
                        <div class="form-group">
                            <label for="email">Graphics:</label>
                            <p class="databox" id="technicalInformation.graphics" contenteditable="true"><%=rows[0].graphics%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].vram) { %>
                        <div class="form-group">
                            <label for="email">VRAM:</label>
                            <p class="databox" id="technicalInformation.vram" contenteditable="true"><%=rows[0].vram%></p>
                        </div>
                        <% } %>
                        
                        <% if (rows[0].text) { %>
                        <div class="form-group">
                            <label for="email">Text:</label>
                            <p class="databox" id="technicalInformation.text" contenteditable="true"><%=rows[0].text%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].switches) { %>
                        <div class="form-group">
                            <label for="email">Switches:</label>
                            <p class="databox" id="technicalInformation.switches" contenteditable="true"><%=rows[0].switches%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].power) { %>
                        <div class="form-group">
                            <label for="email">Power:</label>
                            <p class="databox" id="technicalInformation.power" contenteditable="true"><%=rows[0].power%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].peripherals) { %>
                        <div class="form-group">
                            <label for="email">Peripherals:</label>
                            <p class="databox" id="technicalInformation.peripherals" contenteditable="true"><%=rows[0].peripherals%></p>
                        </div>
                        <% } %>
                        
                        <% if (rows[0].batteries) { %>
                        <div class="form-group">
                            <label for="email">Batteries:</label>
                            <p class="databox" id="technicalInformation.batteries" contenteditable="true"><%=rows[0].batteries%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].gun) { %>
                        <div class="form-group">
                            <label for="email">Gun:</label>
                            <p class="databox" id="technicalInformation.gun" contenteditable="true"><%=rows[0].gun%></p>
                        </div>
                        <% } %>
                        <% if (rows[0].price) { %>
                            <div class="form-group">
                                <label for="email">Price:</label>
                                <p class="databox" id="price" contenteditable="true"><%=rows[0].price%></p>
                            </div>
                        <% } %>
                                    
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
document.body.addEventListener('focusout', function (evt) {
    if (evt.target.className === 'databox') {
        $.ajax({
            url: '/system/<%=rows[0].id%>/fieldSQLite',
            dataType: 'json',
            type: 'put',
            contentType: 'application/x-www-form-urlencoded',
            data: {
                "id": "<%=rows[0].id%>",
                "field": evt.target.id,
                "value": evt.target.innerHTML
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
    }
}, false);

const load = () => {
    description = "<%=rows[0].description.toString()%>"
                        .replace(/\&lt;/g,'<')
                        .replace(/\&gt;/g,'>')
                        .replace(/&amp;quot;/g,'"')
                        .replace(/&amp;/g,'&')
    document.getElementById("description").innerHTML = description;
} 

window.onload = load; 

</script>