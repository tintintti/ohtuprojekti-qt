var emailData;
var postData;

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

//nämä käyttävät chartDrawer.js:n drawPieChartia
function drawEmailPieChart() {
    addTitle("#charts", "pieChartTitle", "Sähköpostien palveluntarjoajat");
    drawPieChart("emails", emailData, true, "#charts");
}

function drawPosterPieChart() {
    addMinPostsButton();
    var totalPosts = getTotalPostCount(postData);
    addTitle("#charts", "pieChartTitle", "Viimeiset " + totalPosts + " viestiä käyttäjien mukaan");
    drawWithMinPosts(10);
}

function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
      emptyPieChart();
      var postsByMin = sortPostsByMin(minPosts);
      drawPieChart("posts", postsByMin, true, "#charts");
    }
}

function drawPosterBarChart() {
    addTitle("#charts", "barChartTitle", "Käyttäjät viestimäärien mukaan");
    var labels = ["Käyttäjien määrä", "Viestien määrä"];
    drawBarChart(divideUsersIntoPostCountGroups(), "#charts", labels);
}

function sortPostsByMin(min) {
    var dataAndTotal = getDataWithCountsAndTotalUnderMin(postData, min);
    var data = dataAndTotal[0];
    var total = dataAndTotal[1];
    if (min > 1) {
        data.push({
            "label": "users w/ <" + min + " posts",
            "value": total
        })
    }
    return objectSorter(data);
}

//Ohjaa haettavan Qt:n foorumin käyttäjän sivuille
function redirectToQtUserPage(name) {
    if (!name.includes("users w/")) window.open("http://forum.qt.io/user/" + $("#forum_data").data().postcounts[1][name]);
}

function getTotalPostCount(postCounts) {
    totalPosts = 0;

    for (var postCount in postCounts) {
        totalPosts += postCounts[postCount].value;
    }

    return totalPosts;
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

function addMinPostsButton() {
    document.getElementById("buttonFeature").innerHTML =
        "<input type=number value=10 id='minimum'/><p><input type = button value = 'Aseta viestien minimimäärä' onclick = 'drawWithMinPosts(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function emptyContainers() {
    document.getElementById("buttonFeature").innerHTML = "";
    document.getElementById("usernames").innerHTML = "";
    if (document.getElementById("barChartTitle")) document.getElementById("barChartTitle").innerHTML = "";
    emptyCharts();
}

//Viestien ryhmittely määrien mukaan

function divideUsersIntoPostCountGroups() {
  var labels = createPostBarChartLabels();
  return createBarChartGroups(postData, labels);
}

function createPostBarChartLabels() {
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
