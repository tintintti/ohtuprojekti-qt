var ownerData;
var averageData;

function showChangeData() {
  averageData = $("#gerrit_data").data().changeAverages;
  emptyContainers();
  $('#info').append("<h3>Keskimääräinen aika, että muutos menee läpi: " + formatTime(averageData.time) + "</h3>");
  $('#info').append("<h3>Keskimääräinen muutosten määrä läpimenoon: " + averageData.revisions + "</h3>");
}

function drawOwnerCharts() {
    ownerData = $("#gerrit_data").data().owners;
    emptyContainers();
    drawOwnerPieChart();
    drawOwnerBarChart();
}

function drawDomainsCharts() {
    domainsData = $("#gerrit_data").data().domains;
    emptyContainers();
    drawDomainsPieChart();
}

//Piechart-metodit

function drawDomainsPieChart() {
    addTitle("#charts", "pieChartTitle", "Omistajien eri domainien määrät");
    var sortedDomains = sortDataWithMin(domainsData, 0, ["",""]);
    drawPieChart("domains", sortedDomains, true, "#charts", "DomainsPieChart");


function drawOwnerPieChart() {
    insertMinOwnersButton();
    addTitle("#charts", "pieChartTitle", "Muutosten omistajat");
    drawPieChart("owners", ownerData, true, "#charts", "OwnerPieChart");
}

function drawWithMinOwners(minOwners) {
    if (minOwners > 0) {
        emptyPieChart("OwnerPieChart");
        var labelWords = ["owners", "changes"];
        var ownersByMin = sortDataWithMin(ownerData, minOwners, labelWords);
        drawPieChart("owners", ownersByMin, true, "#charts", "OwnerPieChart");
    }
}

function insertMinOwnersButton() {
    document.getElementById("buttonFeature").innerHTML =
        "<input type=number value=1 id='minimum'/><p><input type = button value = 'Aseta muutosten minimimäärä' onclick = 'drawWithMinOwners(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function formatTime(seconds) {
  var mm = Math.floor(seconds / 60);
  var ss = seconds % 60;
  var hh = Math.floor(mm / 60);
  mm = mm % 60;
  var dd = Math.floor(hh / 24);
  hh = hh % 24;
  var time = dd + " päivää, " + hh + " tuntia, " + mm + " minuuttia ja " + ss + " sekuntia.";
  return time;
}

//Barchart-metodit

function drawOwnerBarChart() {
    addTitle("#charts", "barChartTitle", "Omistajat muutosten määrän mukaan");
    var xyLabels = ["Muutosten määrä", "Omistajien määrä"];
    var groupLabels = createOwnerBarChartGroupLabels();
    drawBarChart(createBarChartGroups(ownerData, groupLabels), "#charts", xyLabels, "OwnerBarChart");
}

function createOwnerBarChartGroupLabels() {
    var labels = [
        ["1", 1, 1],
        ["2", 2, 2],
        ["3-5", 3, 5],
        ["6-9", 6, 9],
        ["10-19", 10, 19],
        ["20-29", 20, 29],
        ["30-49", 30, 49],
        ["50+", 50, Number.MAX_SAFE_INTEGER]
    ]
    return labels;
}
