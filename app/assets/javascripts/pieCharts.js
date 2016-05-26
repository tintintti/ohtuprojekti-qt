//tähän vois sit tulla se data sieltä backendilta joka korvais ton getTextFile()
var jsons = jsonStringToArrayOfJsons(getTextFile());
var allAndUniqueEmails = getAllAndUniqueEmails(jsons);
var allEmails = allAndUniqueEmails[0],
    uniqueEmails = allAndUniqueEmails[1];
var data = createJsonArrayForPieChart(allEmails, uniqueEmails);
//console.log(postdata)
var postdata2 = $("#postcount").data().postcounts;
console.log("dfsf")
console.log(postdata2)

var postdata = getPostCountsByUsers(jsons, 10);

function drawAllCharts() {
    emptyContainers();
    drawPieChart("emails", data, true, "#chart svg");
    drawPieChart("posts", postdata, true, "#chart2 svg");
}

function drawEmailChartOnly() {
    emptyContainers();
    insertTitle("Sähköpostien palveluntarjoajat");
    drawPieChart("emails", data, true, "#chart svg");
}

function drawPosterChartOnly() {
    emptyContainers();
    insertMinButton();
    insertTitle("Viimeiset ~5000 viestiä käyttäjien mukaan");
    drawPieChart("posts", postdata, true, "#chart svg");
}

function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
        var postdata = getPostCountsByUsers(jsons, minPosts);
        drawPieChart("posts", postdata, true, "#chart svg");
    }
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
function getPostCountsByUsers(jsons, minPosts) {
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
        if (count >= minPosts) {
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
        "label": "users w/ <" + minPosts + " posts",
        "value": smallPostCountUserPostCount
    });
    return objectSorter(userNamesAndPosts);
}

//Luodaan lista json-muodossa olevista sähköposteista jotka annetaan sitten
//piirakanluonti-metodille. Lasketaan myös monta eri käyttäjää on yhteensä
//eri palveluntarjoajilla (gmail, yahoo, hotmail jne.)
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
    if (height > 1800) height = 1800;
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
