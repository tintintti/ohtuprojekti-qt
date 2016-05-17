var file = "theFile.txt";
var rawFile = new XMLHttpRequest();
rawFile.open("GET", file, false);
rawFile.onreadystatechange = function () {
    var allText = rawFile.responseText;
    file = allText.toString();
};
rawFile.send(null);
var files = file.split("split123");
var jsons = new Array();
for (var i = 0; i < files.length - 1; i++) {
    jsons.push(JSON.parse(files[i]));
}
var uniqueEmails = new Array(), allEmails = new Array();
for (var i = 0; i < jsons.length - 1; i++) {
    var currentJson = jsons[i];
    if (currentJson.posts != null) {
        for (var j = 0; j < currentJson.posts.length; j++) {
            var email = currentJson.posts[j].user.email;
            if (email == null) {
                continue;
            }
            if (allEmails.indexOf(email) == -1) {
                allEmails.push(email)
                email = email.split("@")[1].split(".");
                uniqueEmails.push(email[0]);
            }
        }
    }
}
nv.addGraph(function () {
    var chart = nv.models.pieChart()
            .x(function (d) {
                return d.label
            })
            .y(function (d) {
                return d.value
            })
            .showLabels(true);

    d3.select("#chart svg")
            .datum(testi)
            .transition().duration(350)
            .call(chart);

    return chart;
});

var testi = new Array();
uniqueEmails.sort();
console.log(uniqueEmails.length);

var count = 0;
var uniqueEmail = uniqueEmails.pop();
var count = 1;
while (uniqueEmails.length !== 0) {
    var anotherEmail = uniqueEmails.pop();
    if (anotherEmail == uniqueEmail) {
        count++;
    } else {
        testi.push({"label": uniqueEmail,
            "value": count});
        uniqueEmail = uniqueEmails.pop();
        count = 1;
    }
}


nv.addGraph(function () {
    var chart = nv.models.pieChart()
            .x(function (d) {
                return d.label
            })
            .y(function (d) {
                return d.value
            })
            .showLabels(true);

    d3.select("#chart2 svg")
            .datum(testi)
            .transition().duration(350)
            .call(chart);

    return chart;
});
