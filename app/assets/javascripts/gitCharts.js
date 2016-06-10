// var commits = $('#git_data').data().commits;
var authors = $("#git_data").data().authors;
function drawAuthorPieChart() {
    addTitle("#charts", "pieChartTitle", "Committien tekijät");
    drawPieChart("authors", authors, true, "#charts");
}
