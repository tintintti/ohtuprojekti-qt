function drawEmailChartOnly() {
    emptyContainers();
    insertTitle("Sähköpostien palveluntarjoajat");
    drawPieChart("emails", $("#user_data").data().emailcounts, true, "#chart svg");
}
function drawPosterChartOnly() {
    document.getElementById("emails").innerHTML = "";
    document.getElementById("title").innerHTML = "Viimeiset ~5000 viestiä käyttäjien mukaan";
    d3.selectAll("#chart svg > *").remove();
    drawPieChart("posts", objectSorter($("#user_data").data().postcounts), false, "#chart svg");
}
function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
        var postdata = getPostCountsByUsers(jsons, minPosts);
        drawPieChart("posts", postdata, true, "#chart svg");
    }
}

//Piirakka luodaan tässä.
function drawPieChart(type, data, showlegend, divName) {
    d3.selectAll("#chart svg > *").remove();
    var height = setPieChartHeight(data);
    nv.addGraph(function() {
            d3.select(divName).attr('height', height);
            var chart = nv.models.pieChart()
                .x(function(d) {
                    return d.label
                })
                .y(function(d) {
                    return d.value
                })
                .height(height)
                .showLabels(true).showLegend(showlegend);
            if (type == "emails") {
                chart.showLabels(true).showLegend(showlegend).tooltipContent(function(key, y, e, graph) {
                    var wantedEmailForTooltip = $("#user_data").data().usersbyemail[key.data.label],
                        tooltipcontent = "<p><b>" + key.data.label + ": " + wantedEmailForTooltip.length + "</b></p>",
                        length = 10;
                    if (wantedEmailForTooltip.length < 10) length = wantedEmailForTooltip.length;
                    for (var i = 0; i < length; i++) {
                        tooltipcontent = tooltipcontent + "<p>" + wantedEmailForTooltip[i].user + "</p>"
                    }
                    if (wantedEmailForTooltip.length > 10) tooltipcontent = tooltipcontent + "<p>" + "..." + "</p>";
                    return tooltipcontent;
                });
            }
            d3.select(divName)
                .datum(data)
                .transition().duration(1200)
                .call(chart);

            d3.selectAll(".nv-label text")
                .attr("text-anchor", "middle")
                // Alter CSS attributes
                .style({
                    "font-size": "1em"
                });
            return chart;
        },
        function() {
            d3.select("#chart svg").selectAll(".nv-slice").on('click',
                function(d) {
                    if (type == "emails") listEmailsOfProvider(d.data.label);
                    if (type == "posts") redirectToQtUserPage(d.data.label);
                });
        });
}

function objectSorter(array) {
    return array.sort(function(a, b) {
        return parseInt(a.value) - parseInt(b.value);
    });
}

function setPieChartHeight(data) {
    var height = 800;
    height += data.length * 3;
    if (height > 1500) height = 1500;
    return height;
}

//Ohjaa haettavan Qt:n foorumin käyttäjän sivuille
function redirectToQtUserPage(name) {
    if (!name.includes("users w/")) {
        window.open("http://forum.qt.io/user/" + name);
    }

}

//Listaa sivulla kaikki yhden palveluntarjoajan osoitteet
function listEmailsOfProvider(name) {
    document.getElementById("emails").innerHTML = "";
    document.getElementById("emails").innerHTML += "<h2>Osoitteet tarjoajalta " + name + "</h2>";
    var emailArray = [];

    for (var i = 0; i < allEmails.length; i++) {
        if (allEmails[i].split("@")[1].split(".")[0] == name) {
            emailArray.push(allEmails[i]);
        }
    }

    document.getElementById("emails").appendChild(makeUL(emailArray));
}

function makeUL(array) {
    var list = document.createElement('ul');
    for (var i = 0; i < array.length; i++) {
        var item = document.createElement('li');
        item.appendChild(document.createTextNode(array[i]));
        list.appendChild(item);
    }
    return list;
}

function insertTitle(title) {
    document.getElementById("title").innerHTML = title + "";
}

function insertMinButton() {
    document.getElementById("minButton").innerHTML =
        "<input type=number value=10 id='minimum'/><p><input type = button value = 'Aseta viestien minimimäärä' onclick = 'drawWithMinPosts(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function emptyContainers() {
    document.getElementById("minButton").innerHTML = "";
    document.getElementById("emails").innerHTML = "";
}
