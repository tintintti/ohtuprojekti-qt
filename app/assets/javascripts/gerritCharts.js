var ownerData;

$(document).ready(function() {
    ownerData = $("#gerrit_data").data().owners;
    if (ownerData != null) {
        $('#waiting').empty();
        emptyCharts();
        drawOwnerCharts(ownerData);
    } else {
        $('#waiting').text("Waiting for data. Please check back again later.");
    }
})

function drawOwnerCharts(data) {
    drawOwnerPieChart(data);
    drawOwnerBarChart(data);
}

function drawOwnerPieChart(data) {
    addMinOwnersButton();
    addTitle("#charts", "pieChartTitle", "Muutosten omistajat");
    drawWithMinOwners(1);
}

function drawWithMinOwners(minOwners) {
    if (minOwners > 0) {
        emptyPieChart();
        var ownersByMin = getOwnersByMin(minOwners);
        drawPieChart("owners", ownersByMin, true, "#charts");
    }
}

function drawOwnerBarChart(data) {
    addTitle("#charts", "barChartTitle", "Omistajat muutosten määrän mukaan");
    var labels = ["Omistajien määrä", "Muutosten määrä"];
    drawBarChart(divideOwnersIntoChangeCountGroups(data), "#charts", labels);
}

function getOwnersByMin(min) {
    var labelWords = ["owners", "changes"];
    return sortDataWithMin(ownerData, min, labelWords);
}

function divideOwnersIntoChangeCountGroups(data) {
    var labels = createOwnerBarChartLabels();
    return createBarChartGroups(data, labels);
}

function addMinOwnersButton() {
    document.getElementById("buttonFeature").innerHTML =
        "<input type=number value=1 id='minimum'/><p><input type = button value = 'Aseta muutosten minimimäärä' onclick = 'drawWithMinOwners(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function createOwnerBarChartLabels() {
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
