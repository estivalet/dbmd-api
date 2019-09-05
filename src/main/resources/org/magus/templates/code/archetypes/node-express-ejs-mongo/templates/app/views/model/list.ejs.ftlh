<head>
<meta charset="UTF-8">
<meta name="google" content="notranslate">
<meta http-equiv="Content-Language" content="en">
<meta name="description" content="Free Web tutorials">
<meta name="keywords" content="HTML,CSS,XML,JavaScript">
<meta name="author" content="John Doe">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>

body{
font-family: "Times New Roman", Times, serif;
margin: 0;
} 
.wrapper{
min-height: 100vh;
background: #ccc;
display: flex;
flex-direction: column;
}
.header, .footer{
height: 50px;
background: #666;
color: #fff;
}
.content {
display: flex;
flex: 1;
background: #999;
color: #000; 
}
.columns{
display: flex;
flex:1;
}
.main{
flex: 1;
order: 2;
background: #eee;
overflow: auto;
}
.sidebar-first{
width: 20%;
background: #ccc;
order: 1;
overflow: auto;
}
.sidebar-second{ 
width: 20%;
order: 3;
background: #ddd;
overflow: auto;
}





/* */
.card {
/* Add shadows to create the "card" effect */
box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
transition: 0.3s;
}

/* On mouse-over, add a deeper shadow */
.card:hover {
box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
transform: scale(1.05);
}


/* Add some padding inside the card container */
.container {
padding: 2px 16px;
}


/* */
.flex-container {
display: flex;
flex-wrap: nowrap;
/*background-color: DodgerBlue;*/
}

.flex-container > div {
/*padding: 10px;*/
background-color: #f1f1f1;
width: 200px;
margin: 10px;
/*text-align: center;
line-height: 75px;
font-size: 30px;*/
}


/* */
.collapsible {
background-color: #777;
color: white;
cursor: pointer;
padding: 18px;
width: 100%;
border: none;
text-align: left;
outline: none;
font-size: 15px;
}

.active, .collapsible:hover {
background-color: #555;
}

.collapsible:after {
content: '\002B';
color: white;
font-weight: bold;
float: right;
margin-left: 5px;
}

.active:after {
content: "\2212";
}

.collapsible-content {
padding: 0 18px;
max-height: 0;
overflow: hidden;
transition: max-height 0.2s ease-out;
background-color: #f1f1f1;
}
</style>
</head>


<div class="wrapper">
<header class="header">Header: Fixed height</header>
<section class="content">
    <div class="columns">
    <main class="main">

<div class="flex-container">     

    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      

    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      

    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      

    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      

</div>

<div class="flex-container">      
    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      
    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      
    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      
    <div class="card">
    <img src="img_avatar.png" alt="Avatar" style="width:100%">
    <div class="container">
        <h4><b>John Doe</b></h4> 
        <p>Architect & Engineer</p> 
    </div>
    </div>      
</div>

            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
            <p>Content: Flexible width</p>
        </main>
    
    <aside class="sidebar-first">
    
<% for(var i=0; i < result.length; i++) { %>
<button class="collapsible"><%=result[i]._id%></button>
<div class="collapsible-content">
    <% for(var j=0; j < result[i].entry.length; j++) { %>    
    <p><a href="#"><%=result[i].entry[j].name%></a>
    <% } %>
</div>
<% } %>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
            <p>Sidebar first: Fixed width</p>
        </aside>
    <aside class="sidebar-second">
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
            <p>Sidebar second: Fixed width</p>
    </aside>
    </div>
</section>
<footer class="footer">Footer: Fixed height</footer>
</div>
<script>
var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
coll[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    if (content.style.maxHeight){
    content.style.maxHeight = null;
    } else {
    content.style.maxHeight = content.scrollHeight + "px";
    } 
});
}
</script>


