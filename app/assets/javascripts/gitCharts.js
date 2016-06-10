// var commits = $('#git_data').data().commits;
var authors = $("#git_data").data().authors;
function drawAuthorPieChart() {
    addTitle("#charts", "pieChartTitle", "asdasdlolkebab");
    drawPieChart("authors", authors, true, "#charts");
}
