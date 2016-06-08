drawOwnerPieChart();

function drawOwnerPieChart() {
    var ownerData = $("#gerrit_data").data().owners;
    addTitle("#charts", "pieChartTitle", "Omistajat muutosten määrän mukaan");
    drawPieChart("owners", ownerData, true, "#charts");
}
