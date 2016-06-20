var authorData;
var authorEmails;

function drawAuthorCharts() {
    authorData = $("#git_data").data().authors;
    emptyContainers();
    drawAuthorPieChart();
    drawAuthorBarChart();
    drawAuthorEmailPieChart();
}

function drawAuthorPieChart() {
    addTitle("#charts", "pieChartTitle", "Committien tekijät");
    drawPieChart("authors", authorData, true, "#charts", "AuthorPieChart");
}

function drawAuthorBarChart() {
    addTitle("#charts", "barChartTitle", "Tekijät committien määrän mukaan");
    var xyLabels = ["Committien määrä", "Tekijöiden määrä"];
    var groupLabels = createAuthorBarChartGroupLabels();
    drawBarChart(createBarChartGroups(authorData, groupLabels), "#charts", xyLabels, "BarChart");
}

function drawAuthorEmailPieChart() {
  authorEmails = $("#git_data").data().emails;
  addTitle("#charts", "pieChartTitle2", "Committaajien domainit");
  drawPieChart("author_emails", authorEmails, true, "#charts", "EmailPieChart");
}

function createAuthorBarChartGroupLabels() {
    var labels = [
        ["1-9", 1, 9],
        ["10-19", 10, 19],
        ["20-29", 20, 29],
        ["30-49", 30, 49],
        ["50-99", 50, 99],
        ["100-199", 100, 199],
        ["200-499", 200, 499],
        ["500+", 500, Number.MAX_SAFE_INTEGER]
    ]
    return labels;
}
