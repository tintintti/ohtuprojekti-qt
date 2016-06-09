var ownerData;
drawOwnerCharts();

function drawOwnerCharts() {
    ownerData = $("#gerrit_data").data().owners;
    drawOwnerPieChart();
    drawOwnerBarChart();
}

function drawOwnerPieChart() {
    addTitle("#charts", "pieChartTitle", "Muutosten omistajat");
    drawPieChart("owners", ownerData, true, "#charts");
}

function drawOwnerBarChart() {
    addTitle("#charts", "barChartTitle", "Omistajat muutosten määrän mukaan");
    var labels = ["Omistajien määrä", "Muutosten määrä"];
    drawBarChart(divideOwnersIntoChangeCountGroups(), "#charts", labels);
}

function divideOwnersIntoChangeCountGroups() {
  var labels = createOwnerBarChartLabels();
  return createBarChartGroups(ownerData, labels);
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
