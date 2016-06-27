drawAuthorCommitPieChart();

//  Piechart-related

function drawAuthorCommitPieChart() {
    authorData = $("#git_data").data().authors;
    emptyContainers();
    addTitle("#charts", "pieChartTitle", "Committers");
    drawPieChart("gitAuthors", authorData, true, "#charts", "AuthorPieChart");
}

function drawAuthorEmailPieChart() {
    authorEmails = $("#git_data").data().emails;
    emptyContainers();
    addTitle("#charts", "pieChartTitle2", "Committer domains");
    drawPieChart("gitEmails", authorEmails, true, "#charts", "EmailPieChart");
}

//  Barchart-related

function drawAuthorsByCommitsBarChart() {
    authorData = $("#git_data").data().authors;
    emptyContainers();
    addTitle("#charts", "barChartTitle", "Committers by commit amounts");
    var xyLabels = ["Commits", "Committers"];
    var groupLabels = createAuthorBarChartGroupLabels();
    drawBarChart(createBarChartGroups(authorData, groupLabels), "#charts", xyLabels, "AuthorBarChart");
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
