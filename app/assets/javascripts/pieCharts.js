drawAllCharts()

//tähän vois sit tulla se data sieltä backendilta joka korvais ton getTextFile()
function drawAllCharts() {
    var jsons = jsonStringToArrayOfJsons(getTextFile());
    var allAndUniqueEmails = getAllAndUniqueEmails(jsons);
    var allEmails = allAndUniqueEmails[0],
        uniqueEmails = allAndUniqueEmails[1];
    var data = createJsonArrayForPieChart(allEmails, uniqueEmails);
    drawPieChart(data, true, "#chart svg");
    var postdata = getPostCountsByUsers(jsons);
    drawPieChart(postdata, true, "#chart2 svg");
}

function drawEmailChartOnly() {
    d3.selectAll("#chart svg > *").remove();
    var jsons = jsonStringToArrayOfJsons(getTextFile());
    var allAndUniqueEmails = getAllAndUniqueEmails(jsons);
    var allEmails = allAndUniqueEmails[0],
        uniqueEmails = allAndUniqueEmails[1];
    var data = createJsonArrayForPieChart(allEmails, uniqueEmails);
    drawPieChart(data, true, "#chart svg");

}

function drawPosterChartOnly() {
    d3.selectAll("#chart svg > *").remove();
    var jsons = jsonStringToArrayOfJsons(getTextFile());
    var postdata = getPostCountsByUsers(jsons);
    drawPieChart(postdata, true, "#chart svg");
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

//Se tekstitiedosto on yks iso tiedosto missä on peräkkäin ne viestiketjujen
//json-tiedostot. Jokasen json-tiedoston välissä on "split123" jonka avulla ne
//splitataan yksittäisisiksi jsoneiksi.
function jsonStringToArrayOfJsons(rawfiles) {
    var files = rawfiles.split("split123");
    var jsons = new Array();
    for (var i = 0; i < files.length - 1; i++) {
        jsons.push(JSON.parse(files[i]));
    }
    return jsons;
}

//uniqueEmails sisältää kaikki uniikit sähköpostit viimeisimmän pisteen
//ja toiseksi viimeisen pisteen väliltä tai jos pisteitä on vain yksi niin "@".
//Eli "asdgf@gmail.com" löytyy muodossa "gmail" ja @cs.helsinki.fi löytyy
//muodossa "helsinki". allEmails sisältää kaikki uniikit sähköpostit
//kokonaisuudessaan.
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
//Piirakka luodaan tässä. Tätä ei välttämättä tarvii siivota.
function drawPieChart(data, showlegend, divName) {
    nv.addGraph(function() {
        var chart = nv.models.pieChart()
            .x(function(d) {
                return d.label
            })
            .y(function(d) {
                return d.value
            })
            .showLabels(true).showLegend(showlegend);

        d3.select(divName)
            .datum(data)
            .transition().duration(350)
            .call(chart);
        return chart;
    });
}

function objectSorter(array) {
    return array.sort(function(a, b) {
        return parseInt(a.value) - parseInt(b.value);
    });
}
