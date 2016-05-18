// Haetaan tekstifilu jesarilla. Tää korvataan kun saadaan joku
// db pyörimään mistä se data haetaan
var file = "/file";
var rawFile = new XMLHttpRequest();
rawFile.open("GET", file, false);
rawFile.onreadystatechange = function() {
    var allText = rawFile.responseText;
    file = allText.toString();
};
rawFile.send(null);

//Se tekstitiedosto on yks iso tiedosto missä on peräkkäin ne viestiketjujen json-
//tiedostot. Jokasen json-tiedoston välissä on "split123" minkä avulla ne splitataan. Yskittäisisiksi jsoneiksi.
var files = file.split("split123");
var jsons = new Array();
for (var i = 0; i < files.length - 1; i++) {
    jsons.push(JSON.parse(files[i]));
}

//uniqueEmails sisältää kaikki uniikit sähköpostit väliltä "@"" ja sitä seuraava ".". Eli "asdgf@gmail.com"
//löytyy muodossa "gmail" sieltä. allEmails sisältää kaikki uniikit spostit kokonaisuudessaan.
var uniqueEmails = new Array(),
    allEmails = new Array();
for (var i = 0; i < jsons.length - 1; i++) {
    var currentJson = jsons[i];
    if (currentJson.posts != null) {
        for (var j = 0; j < currentJson.posts.length; j++) {
            var email = currentJson.posts[j].user.email;
            if (email == null) {
                continue;
            }
            if (allEmails.indexOf(email) == -1) {
                allEmails.push(email);
                email = email.split("@")[1];
                if (uniqueEmails.indexOf(email) == -1) {
                  uniqueEmails.push(email);
                }
            }
        }
    }
}

//Piirakka luodaan tässä. Tätä ei välttämättä tarvii siivota.
nv.addGraph(function() {
    var chart = nv.models.pieChart()
        .x(function(d) {
            return d.label
        })
        .y(function(d) {
            return d.value
        })
        .showLabels(true);

    d3.select("#chart svg")
        .datum(createJsonArray())
        .transition().duration(350)
        .call(chart);
    return chart;
});
uniqueEmails.sort();

//Luodaan lista json-muodossa olevista olioista mitkä annetaan piirakanluonti-metodille.
//Lasketaan myös monta mitäkin mailia(gmail, yahoo, hotmail jne.) on.
console.log(allEmails);
function createJsonArray() {
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
    return jsonArray;
}