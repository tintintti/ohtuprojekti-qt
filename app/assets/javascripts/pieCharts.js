//tähän vois sit tulla se data sieltä backendilta joka korvais ton getTextFile()
var jsons = jsonStringToArrayOfJsons(getTextFile());
var allAndUniqueEmails = getAllAndUniqueEmails(jsons);
var allEmails = allAndUniqueEmails[0],
    uniqueEmails = allAndUniqueEmails[1];
var data = createJsonArrayForPieChart(allEmails, uniqueEmails);
var postdata = getPostCountsByUsers(jsons);

function drawAllCharts() {
    drawPieChart("emails", data, true, "#chart svg");
    drawPieChart("posts", postdata, true, "#chart2 svg");
}

function drawEmailChartOnly() {
    document.getElementById("title").innerHTML = "Sähköpostien palveluntarjoajat";
    d3.selectAll("#chart svg > *").remove();
    drawPieChart("emails", data, true, "#chart svg");
}

function drawPosterChartOnly() {
    document.getElementById("emails").innerHTML = "";
    document.getElementById("title").innerHTML = "Viimeiset ~5000 viestiä käyttäjien mukaan";
    d3.selectAll("#chart svg > *").remove();
    drawPieChart("posts", postdata, true, "#chart svg");
}

// Haetaan tekstifilu jesarilla. Tää korvataan kun saadaan joku
// db pyörimään mistä se data haetaan
function getTextFile() {
    var file = "/file";
    var rawFile = new XMLHttpRequest();
    rawFile.open("GET", file, false);
    rawFile.onreadystatechange = function() {
        var allText = rawFile.responseText;
        file = allText.toString();
    };
    rawFile.send(null);
    return file;
}

//Tekstitiedosto pilkotaan yksittäisiksi json-objekteiksi.
function jsonStringToArrayOfJsons(rawfiles) {
    var files = rawfiles.split("split123");
    var jsons = new Array();
    for (var i = 0; i < files.length - 1; i++) {
        jsons.push(JSON.parse(files[i]));
    }
    return jsons;
}


function getAllAndUniqueEmails(jsons) {
    var uniqueEmails = new Array(),
        allEmails = new Array();
    for (var i = 0; i < jsons.length - 1; i++) {
        var currentJson = jsons[i];
        if (currentJson.posts == null) continue;
        for (var j = 0; j < currentJson.posts.length; j++) {
            var email = currentJson.posts[j].user.email;
            if (email == null) continue;
            if (allEmails.indexOf(email) == -1) {
                allEmails.push(email);
                email = email.split("@")[1].split(".");
                if (uniqueEmails.indexOf(email[email.length - 2]) == -1) {
                    uniqueEmails.push(email[email.length - 2]);
                }
            }
        }
    }
    var allAndUniqueEmails = new Array();
    allAndUniqueEmails.push(allEmails.sort()), allAndUniqueEmails.push(uniqueEmails.sort());
    return allAndUniqueEmails;
}

//Hakee erikseen postausmäärät käyttäjiltä joilla on yli 10 postia ja laskee
//myös yhteen alle 10-postisten käyttäjien postausmäärän.
function getPostCountsByUsers(jsons) {
    var usernames = new Array();
    for (var i = 0; i < jsons.length - 1; i++) {
        var currentJson = jsons[i];
        if (currentJson.posts == null) continue;
        for (var j = 0; j < currentJson.posts.length; j++) {
            usernames.push(currentJson.posts[j].user.username);
        }
    }
    usernames.sort();
    var userNamesAndPosts = new Array(),
        smallPostCountUserPostCount = 0;
    for (var i = 0; i < usernames.length; i++) {
        var count = usernames.filter(function(x) {
            return x == usernames[i];
        }).length
        if (count > 10) {
            userNamesAndPosts.push({
                "label": usernames[i],
                "value": count
            });
        } else {
            smallPostCountUserPostCount += count;
        }
        i += count - 1;
    }
    userNamesAndPosts.push({
        "label": "users w/ <10 posts",
        "value": smallPostCountUserPostCount
    });
    return objectSorter(userNamesAndPosts);
}

//Luodaan lista json-muodossa olevista olioista jotka annetaan
//piirakanluonti-metodille. Lasketaan myös monta eri palveluntarjoajaa
//(gmail, yahoo, hotmail jne.) on yhteensä.
function createJsonArrayForPieChart(allEmails, uniqueEmails) {
    var jsonArray = new Array();
    for (var i = 0; i < uniqueEmails.length - 1; i++) {
        var count = allEmails.filter(function(x) {
            return x.split("@")[1].split(".")[0] == uniqueEmails[i];
        }).length
        jsonArray.push({
            "label": uniqueEmails[i],
            "value": count
        });
    }
    return objectSorter(jsonArray);
}

//Piirakka luodaan tässä.
function drawPieChart(type, data, showlegend, divName) {
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
            .showLabels(true).showLegend(showlegend).tooltipContent(function(key, y, e, graph) {
                var tooltipcontent = "<p>" + key.data.label + "</p>",
                    count = 0;
                for (var i = 0; i < allEmails.length; i++) {
                    if (allEmails[i].split("@")[1].split(".")[0] == key.data.label) {
                        tooltipcontent = tooltipcontent + "<p>" + allEmails[i] + "</p>";
                        count++;
                    }
                    if (count > 10) {
                        break;
                    }
                }
                return tooltipcontent;
            });

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
    }, function() {
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
    if (height > 1800) height = 1800;
    return height;
}

function redirectToQtUserPage(name) {
    if (name != "users w/ <10 posts") {
        window.open("http://forum.qt.io/user/" + name);
    }

}

function listEmailsOfProvider(name) {
    document.getElementById("emails").innerHTML = "";
    document.getElementById("emails").innerHTML += "<h2>Emails by provider " + name + "</h2>";

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
