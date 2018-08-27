var xmlhttp = new XMLHttpRequest();
/**
 * Create a new AJAX request to the server.
 *
 * @param method
 *      HTTP method being invoked (POST, DELETE, UPDATE, PUT)
 * @param url
 *      Server URL.
 * @param f
 *      Callback function to be invoked after completion of AJAX request.
 * @param data
 *      Data in JSON format being passed as a parameter to URL.
 */
callServerJSON = function(method, url, f, data) {
    xmlhttp.onreadystatechange = f;
    xmlhttp.open(method, url, true);
    xmlhttp.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xmlhttp.send(JSON.stringify(data));
}


/**
 * @param url Server URL to call.
 * @param f Function to execute after server return.
 */
function callServer(url, f) {
	// Check if browser supports Ajax calls.
    if (document.getElementById) { 
        if (window.XMLHttpRequest) {
            HttpReq = new XMLHttpRequest();
            HttpReq.onreadystatechange = f;
            HttpReq.open("GET", url, true);
            HttpReq.send(null);
        } else if (window.ActiveXObject) {
            HttpReq = new ActiveXObject("Microsoft.XMLHTTP");
            if (HttpReq) {
                HttpReq.onreadystatechange = XMLHttpRequestChange;
                HttpReq.open("GET", url, true);
                HttpReq.send();
            }
        }
    }  
}

function createForm(id, method, action) {
	var form = document.createElement("form");
	form.setAttribute("id", id);
	form.setAttribute("method", method);
	form.setAttribute("action", action);
	
	return form;
}

function createInput(id, type, value) {
	var field = document.createElement("input");
	field.setAttribute("id", id);
	field.setAttribute("name", id);
	field.setAttribute("type", type);
	field.setAttribute("value", value);
	
	return field;
}

function checkNodeUndefined(node) {
	if(node == undefined) {
		return "";
	}
	return node.nodeValue;
}

function setUpPagination(pageNum, totalPages, filterFunction) {
    document.getElementById("pagination").innerHTML = "";
    
    var divPag = document.getElementById("pagination");
    var ul = document.createElement("ul");
    ul.className = "pager";
    divPag.appendChild(ul);    

    var li = document.createElement("li");
    ul.appendChild(li);

    if(pageNum == 1) {
        li.className = "disabled";
        li.innerHTML = "Previous";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"" + filterFunction + "('" + (pageNum-1) + "')\">Previous</a>";
    }

    var start = pageNum - 5;
    if(start < 1) {
        start = 1;
    }
    var end = pageNum + 5;
    if(end > totalPages) {
        end = totalPages;
    }
    for(var i=start; i<=end; i++) {
        var li = document.createElement("li");
        ul.appendChild(li);

        if(i==pageNum) {
            li.innerHTML = i;
            li.className = "current";
        } else {
            li.innerHTML = "<a href=\"#\" onclick=\"" + filterFunction + "('" + i + "')\">" + i + "</a>";
        }
    }
    if(end != totalPages) {
        var li = document.createElement("li");
        li.innerHTML = "...";
        li.className = "separator";
        ul.appendChild(li);

        var li = document.createElement("li");
        li.innerHTML = "<a href=\"#\" onclick=\"" + filterFunction + "('" + totalPages + "')\">" + totalPages + "</a>";
        ul.appendChild(li);
    }
    var li = document.createElement("li");
    if(pageNum == totalPages) {
        li.className = "disabled";
        li.innerHTML = "Next";
    } else {
        li.innerHTML = "<a href=\"#\" onclick=\"" + filterFunction + "('" + (parseInt(pageNum)+1) + "')\">Next</a>";
    }
    ul.appendChild(li);
}

function openModal() {
    document.getElementById('modal').style.display = 'block';
    document.getElementById('fade').style.display = 'block';
}

function closeModal() {
	document.getElementById('modal').style.display = 'none';
	document.getElementById('fade').style.display = 'none';
}

function createTable(div, id, className) {
    var myTableDiv = document.getElementById(div);
    var table = document.createElement('TABLE');
    table.id = id;
    table.className = className;
    myTableDiv.appendChild(table);
    return table;
}

function addTableHeader(table, columns) {
    var header = table.createTHead();
    var row = header.insertRow(0);
    for(index = 0; index < columns.length; index++) {
        var cell = row.insertCell();
        cell.innerHTML = "<b>" + columns[index] + "</b>";
    }
        
}

function addTableBody(table) {
    var tableBody = document.createElement('TBODY');
    table.appendChild(tableBody);
    return tableBody;
}

function addTableRow(tableBody) {
    var tr = document.createElement('TR');
    tableBody.appendChild(tr);
    return tr;
}

function addTableCell(tr, data) {
    var td = document.createElement('TD');
    td.appendChild(document.createTextNode(typeof data == "undefined" ? "" : data));
    tr.appendChild(td);
}

function addTableCellHTML(tr, data) {
    var td = document.createElement('TD');
    td.innerHTML = data;
    tr.appendChild(td);
}	

function isEmpty(value) {
	return typeof value == 'string' && !value.trim() || typeof value == 'undefined' || value === null;
}