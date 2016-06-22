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
    addTitle("#charts", "changeTimeChart", "Time for changes to pass")
    drawChangeTimeToPassChart();

    addTitle("#charts", "changeRevisionsChart", "Revisions for changes to pass")
    drawRevisionsToPassChart();

    $('#info').append("<h3>Average time for a change to pass CI: " + formatTime(averageData.time) + "</h3>");
    $('#info').append("<h3>Average revisions needed for a change to pass CI: " + averageData.revisions + "</h3>");
}

function drawChangeTimeToPassChart() {
    times = $("#gerrit_data").data().changes.times
    var xyLabels = ["Time to pass", "Changes"];
    var groupLabels = createChangeTimeToPassChartGroupLabels();
    drawBarChart(createBarChartGroups(times, groupLabels), "#charts", xyLabels, "changeTimeToPassBarChart");
}

function drawRevisionsToPassChart() {
  revisions = $("#gerrit_data").data().changes.revisions
  var xyLabels = ["Revisions to pass", "Changes"];
  var groupLabels = createRevisionsToPassChartGroupLabels();
  drawBarChart(createBarChartGroups(revisions, groupLabels), "#charts", xyLabels, "changeRevisionsBarChart");
}

function drawDomainsCharts() {
    domainsData = $("#gerrit_data").data().domains;
    emptyContainers();
    drawDomainsPieChart();
}

//Piechart-metodit

function drawDomainsPieChart() {
    addTitle("#charts", "pieChartTitle", "Owner domains");
    var sortedDomains = sortDataWithMin(domainsData, 0, ["", ""]);
    drawPieChart("domains", sortedDomains, true, "#charts", "DomainsPieChart");
}

function drawOwnerPieChart() {
    insertMinOwnersButton();
    addTitle("#charts", "pieChartTitle", "Change owners");
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
        "<input type=number value=1 id='minimum'/><p><input type = button value = 'Set minimum amount of changes' onclick = 'drawWithMinOwners(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function formatTime(seconds) {
    var mm = Math.floor(seconds / 60),
        hh = Math.floor(mm / 60),
        dd = Math.floor(hh / 24);
    return dd + " days, " + hh % 24 + " hours, " + mm % 60 + " minutes and " + seconds % 60 + " seconds.";
}

//Barchart-metodit

function drawOwnerBarChart() {
    addTitle("#charts", "barChartTitle", "Owners by change amounts");
    var xyLabels = ["Changes", "Owners"];
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

function createRevisionsToPassChartGroupLabels() {
    var labels = [
      ["0", 0, 0],
      ["1", 1, 1],
      ["2", 2, 2],
      ["3", 3, 3],
      ["4", 4, 4],
      ["5", 5, 5],
      ["6", 6, 6],
      ["7", 7, 7],
      ["8", 8, 8],
      ["9", 9, 9],
      ["10", 10, 10],
      [">10", 11, Number.MAX_SAFE_INTEGER]
    ]
    return labels;
}
