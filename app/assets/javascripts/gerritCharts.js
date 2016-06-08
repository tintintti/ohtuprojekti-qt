function drawOwnerPieChart() {
    var ownerData = $("#gerrit_data").data().owners;
    addTitle("#charts", "pieChartTitle", "Omistajat");
    drawPieChart("owners", ownerData, true, "#charts");
}
