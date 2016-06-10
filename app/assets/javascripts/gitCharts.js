// var commits = $('#git_data').data().commits;
var authors = $("#git_data").data().authors;
function drawAuthorPieChart() {
    addTitle("#charts", "pieChartTitle", "Commitit vuoden 2015 alusta nykyhetkeen");
    drawPieChart("authors", authors, true, "#charts");
}
