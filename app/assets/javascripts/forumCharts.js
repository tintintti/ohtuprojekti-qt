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

//Piechart-metodit

function drawEmailPieChart() {
    addTitle("#charts", "pieChartTitle", "Sähköpostien palveluntarjoajat");
    drawPieChart("emails", emailData, true, "#charts", "EmailPieChart");
}

function drawPosterPieChart() {
    insertMinPostsButton();
    var totalPosts = getTotalPostCount(postData);
    addTitle("#charts", "pieChartTitle", "Viimeiset " + totalPosts + " viestiä käyttäjien mukaan");
    drawWithMinPosts(10);
}

function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
      emptyPieChart("PostPieChart");
      var labelWords = ["users", "posts"];
      var postsByMin = sortDataWithMin(postData, minPosts, labelWords);
      drawPieChart("posts", postsByMin, true, "#charts", "PostPieChart");
  }
}


function insertMinPostsButton() {
    document.getElementById("buttonFeature").innerHTML =
        "<input type=number value=10 id='minimum'/><p><input type = button value = 'Aseta viestien minimimäärä' onclick = 'drawWithMinPosts(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

//Barchart-metodit

function drawPosterBarChart() {
    addTitle("#charts", "barChartTitle", "Käyttäjät viestimäärien mukaan");
    var xyLabels = ["Viestien määrä", "Käyttäjien määrä"];
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

//Muut jutut

function getTotalPostCount(postCounts) {
    totalPosts = 0;

    for (var postCount in postCounts) {
        totalPosts += postCounts[postCount].value;
    }

    return totalPosts;
}

//Ohjaa haettavan Qt:n foorumin käyttäjän sivuille
function redirectToQtUserPage(name) {
    if (!name.includes("users w/")) window.open("http://forum.qt.io/user/" + $("#forum_data").data().postcounts[1][name]);
}

//Listaa sivulla kaikki yhden palveluntarjoajan käyttäjät
function listUsersOfProvider(emailprovider) {
    document.getElementById("usernames").innerHTML = "";
    document.getElementById("usernames").innerHTML += "<h2>Käyttäjät tarjoajalla " + emailprovider + "</h2>";
    var objectArray = $("#forum_data").data().usersbyemail[emailprovider],
        userArray = [];
    for (var i = 0; i < objectArray.length; i++) {
        userArray.push(objectArray[i].user)
    }
    document.getElementById("usernames").appendChild(makeUL(userArray));
}
