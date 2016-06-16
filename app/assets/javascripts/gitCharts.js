// var commits = $('#git_data').data().commits;
var authorData;

function drawAuthorCharts() {
    authorData = $("#git_data").data().authors;
    drawAuthorPieChart();
    drawAuthorBarChart();
}

function drawAuthorPieChart() {
    emptyCharts();
    addTitle("#charts", "pieChartTitle", "Committien tekijät");
    drawPieChart("authors", authorData, true, "#charts");
}

function drawAuthorBarChart() {
    addTitle("#charts", "barChartTitle", "Tekijät committien määrän mukaan");
    var xyLabels = ["Committien määrä", "Tekijöiden määrä"];
    var groupLabels = createAuthorBarChartGroupLabels();
    drawBarChart(createBarChartGroups(authorData, groupLabels), "#charts", xyLabels);
}


function createAuthorBarChartGroupLabels() {
    var labels = [
        ["1-49", 1, 49],
        ["50-99", 50, 99],
        ["100-149", 100, 149],
        ["150-199", 150, 199],
        ["200-299", 200, 299],
        ["300-399", 300, 399],
        ["500-999", 500, 999],
        ["1000+", 1000, Number.MAX_SAFE_INTEGER]
    ]
    return labels;
}
