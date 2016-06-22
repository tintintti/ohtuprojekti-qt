drawAuthorCommitChart();

function drawAuthorCommitChart() {
    authorData = $("#git_data").data().authors;
    emptyContainers();
    addTitle("#charts", "pieChartTitle", "Committers");
    drawPieChart("authors", authorData, true, "#charts", "authorPieChart");
}

function drawAuthorsByCommitsChart() {
    authorData = $("#git_data").data().authors;
    emptyContainers();
    addTitle("#charts", "barChartTitle", "Committers by commit amounts");
    var xyLabels = ["Commits", "Committers"];
    var groupLabels = createAuthorBarChartGroupLabels();
    drawBarChart(createBarChartGroups(authorData, groupLabels), "#charts", xyLabels, "BarChart");
}

function drawAuthorEmailChart() {
    authorEmails = $("#git_data").data().emails;
    emptyContainers();
    addTitle("#charts", "pieChartTitle2", "Committer domains");
    drawPieChart("author_emails", authorEmails, true, "#charts", "emailPieChart");
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
