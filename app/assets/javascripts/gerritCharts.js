drawOwnerCharts();

function drawOwnerCharts() {
    ownerData = $("#gerrit_data").data().owners;
    emptyContainers();
    drawOwnerPieChart();
    drawOwnerBarChart();
}

function showChangeData() {
    averageData = $("#gerrit_data").data().changeAverages;
    emptyContainers();
    addTitle("#charts", "changeTimeChart", "Ajat muutosten läpimenoon")
    drawChangeTimeToPassChart();
    $('#info').append("<h3>Keskimääräinen aika, että muutos menee läpi: " + formatTime(averageData.time) + "</h3>");
    $('#info').append("<h3>Keskimääräinen muutosten määrä läpimenoon: " + averageData.revisions + "</h3>");
}

function drawChangeTimeToPassChart() {
    times = $("#gerrit_data").data().changes.times
    var xyLabels = ["Time to pass", "Changes"];
    var groupLabels = createChangeTimeToPassChartGroupLabels();
    drawBarChart(createBarChartGroups(times, groupLabels), "#charts", xyLabels, "ChangeBarChart");
}

function drawDomainsCharts() {
    domainsData = $("#gerrit_data").data().domains;
    emptyContainers();
    drawDomainsPieChart();
}

//Piechart-metodit

function drawDomainsPieChart() {
    addTitle("#charts", "pieChartTitle", "Omistajien eri domainien määrät");
    var sortedDomains = sortDataWithMin(domainsData, 0, ["", ""]);
    drawPieChart("domains", sortedDomains, true, "#charts", "DomainsPieChart");
}

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
    var mm = Math.floor(seconds / 60),
        hh = Math.floor(mm / 60),
        dd = Math.floor(hh / 24);
    return dd + " päivää, " + hh % 24 + " tuntia, " + mm % 60 + " minuuttia ja " + seconds % 60 + " sekuntia.";
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

function createChangeTimeToPassChartGroupLabels() {
    var labels = [
        ["less than 1 hour", 0, 3599],
        ["1 to 3 hours", 3600, 10799],
        ["3 to 10 hours", 10800, 35999],
        ["10 to 24 hours", 36000, 86399],
        ["1 to 3 days", 86400, 259199],
        ["3 to 10 days", 259200, 864000],
        ["10 days to 1 month", 864000, 2629744],
        ["Over a month", 2629745, Number.MAX_SAFE_INTEGER]
    ]
    return labels;
}
