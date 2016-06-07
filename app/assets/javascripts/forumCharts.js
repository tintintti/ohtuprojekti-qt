var totalPosts = 0;

function drawEmailCharts() {
  emptyContainers();
  addTitle("#charts", "pieChartTitle", "Sähköpostien palveluntarjoajat");
  drawEmailPieChart();
}

function drawPosterCharts() {
  emptyContainers();
  drawPosterPieChart();
  drawPosterBarChart();
}
//nämä käyttävät chartDrawer.js:n drawPieChartia
function drawEmailPieChart() {
    drawPieChart("emails", $("#user_data").data().emailcounts, true, "#charts");
}

function drawPosterBarChart() {
  drawBarChart(divideUsersIntoPostCountGroups(), "#charts");
}

function drawPosterPieChart() {
    insertMinButton();
    drawWithMinPosts(10);
}

function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
        var postdata = getPostCountsByUsers($("#user_data").data().postcounts[0], minPosts);
        drawPieChart("posts", postdata, true, "#charts");
        insertTitle("Viimeiset " + totalPosts + " viestiä käyttäjien mukaan");
    }
}

//Ohjaa haettavan Qt:n foorumin käyttäjän sivuille
function redirectToQtUserPage(name) {
    if (!name.includes("users w/")) window.open("http://forum.qt.io/user/" + $("#user_data").data().postcounts[1][name]);
}

//Hakee erikseen postausmäärät käyttäjiltä joilla on yli n postia ja laskee
//myös yhteen alle n-postisten käyttäjien postausmäärän.
function getPostCountsByUsers(postCounts, minPosts) {
    totalPosts = 0;
    var data = []
    var postCountForGroupedUsers = 0;
    for (var postCount in postCounts) {
        totalPosts += postCounts[postCount].value;
        if (postCounts[postCount].value < minPosts) {
            postCountForGroupedUsers++;
        } else {
            data.push(postCounts[postCount])
        }
    }
    data.push({
        "label": "users w/ <" + minPosts + " posts",
        "value": postCountForGroupedUsers
    })
    return objectSorter(data);
}

//Listaa sivulla kaikki yhden palveluntarjoajan käyttäjät
function listUsersOfProvider(emailprovider) {
    document.getElementById("usernames").innerHTML = "";
    document.getElementById("usernames").innerHTML += "<h2>Käyttäjät tarjoajalla " + emailprovider + "</h2>";
    var objectArray = $("#user_data").data().usersbyemail[emailprovider],
        userArray = [];
    for (var i = 0; i < objectArray.length; i++) {
        userArray.push(objectArray[i].user)
    }
    document.getElementById("usernames").appendChild(makeUL(userArray));
}

function insertMinButton() {
    document.getElementById("buttonFeature").innerHTML =
        "<input type=number value=10 id='minimum'/><p><input type = button value = 'Aseta viestien minimimäärä' onclick = 'drawWithMinPosts(document.getElementById(&quot;minimum&quot;).value)'></input></p>";
}

function emptyContainers() {
    document.getElementById("title").innerHTML = "";
    document.getElementById("buttonFeature").innerHTML = "";
    document.getElementById("usernames").innerHTML = "";
    if (document.getElementById("barChartTitle")) document.getElementById("barChartTitle").innerHTML = "";
    emptyCharts();
}

//Viestien ryhmittely määrien mukaan

function divideUsersIntoPostCountGroups() {
  var labels = createPostBarChartLabels();
  var labelValues = initializePostCountMap(labels);

  var postCounts = objectSorter($("#user_data").data().postcounts[0]);

  for (i in postCounts) {
    var posts = postCounts[i].value
    mapPosts(labelValues, posts, labels);
  }
  return mapToArrayForNvd3(labelValues);
}

function mapToArrayForNvd3(dataMap) {
  var data = [];
  dataMap.forEach(function (value, key, map){
   data.push({
     "label": key,
     "value": value
   });
  });
  return data;
}

function initializePostCountMap(labels) {
  var dataMap = new Map();
  labels.forEach(function(label) {
    dataMap.set(label[0], 0);
  });
  return dataMap;
}

function mapPosts(dataMap, posts, labels) {
    labels.forEach(function(label) {
      if (posts >= label[1] && posts <= label[2]) dataMap.set(label[0], dataMap.get(label[0])+1);
    });
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
