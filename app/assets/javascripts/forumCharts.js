drawEmailCharts();

function drawEmailCharts() {
    emailData = $("#forum_data").data().emailcounts;
    emptyContainers();
    drawEmailPieChart();
}

function drawPosterCharts() {
    postData =  $("#forum_data").data().postcounts[0];
    emptyContainers();
    drawPosterPieChart();
    drawPosterBarChart();
}

//  Piechart-related

function drawEmailPieChart() {
    addTitle("#charts", "pieChartTitle", "Email service providers");
    drawPieChart("forumEmails", emailData, true, "#charts", "EmailPieChart");
}

function drawPosterPieChart() {
    insertMinPostsButton();
    var totalPosts = getTotalPostCount(postData);
    addTitle("#charts", "pieChartTitle", "Last " + totalPosts + " posts by users");
    drawWithMinPosts(10);
}

function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
      emptyChartByTitle("PosterPieChart");
      var labelWords = ["users", "posts"];
      var postsByMin = sortDataWithMin(postData, minPosts, labelWords);
      drawPieChart("forumPosts", postsByMin, true, "#charts", "PosterPieChart");
  }
}

//  Barchart-related

function drawPosterBarChart() {
    addTitle("#charts", "barChartTitle", "Users by postcount");
    var xyLabels = ["Posts", "Users"];
    var groupLabels = createPostBarChartGroupLabels();
    drawBarChart(createBarChartGroups(postData, groupLabels), "#charts", xyLabels, "PosterBarChart");
}

function createPostBarChartGroupLabels() {
  var labels = [
    ["1", 1, 1],
    ["2", 2, 2],
    ["3-5", 3, 5],
    ["6-9", 6, 9],
    ["10-19", 10, 19],
    ["20-49", 20, 49],
    ["50-99", 50, 99],
    ["100+", 100, Number.MAX_SAFE_INTEGER]
  ]
  return labels;
}

//  Other

function getTotalPostCount(postCounts) {
    totalPosts = 0;

    for (var postCount in postCounts) {
        totalPosts += postCounts[postCount].value;
    }

    return totalPosts;
}


function insertMinPostsButton() {
    document.getElementById("buttonFeature").innerHTML =
        "<input type=number value=10 id='minimum'/><p><input type = button value = 'Set minimum postcount' onclick = 'drawWithMinPosts(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function redirectToQtUserPage(name) {
    if (!name.includes("users w/")) {
    window.open("http://forum.qt.io/user/" + $("#forum_data").data().postcounts[1][name]);
  }
}

//For listing (appending) the users of a provider on the page
function listUsersOfProvider(emailprovider) {
    document.getElementById("usernames").innerHTML = "";
    document.getElementById("usernames").innerHTML += "<h2>Users with " + emailprovider + "</h2>";
    var objectArray = $("#forum_data").data().usersbyemail[emailprovider],
        userArray = [];
    for (var i = 0; i < objectArray.length; i++) {
        userArray.push(objectArray[i].user)
    }
    document.getElementById("usernames").appendChild(makeUL(userArray));
}
