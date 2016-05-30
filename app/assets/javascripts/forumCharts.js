var totalPosts = 0;


//nämä käyttävät chartDrawer.js:n drawPieChartia
function drawEmailPieChartOnly() {
    emptyContainers();
    insertTitle("Sähköpostien palveluntarjoajat");
    drawPieChart("emails", $("#user_data").data().emailcounts, true, "#chart svg");
}

function drawPosterPieChartOnly() {
    emptyContainers();
    insertTitle("Käyttäjien viestit");
    insertMinButton();
    drawWithMinPosts(10);
}

function drawWithMinPosts(minPosts) {
    if (minPosts > 0) {
        var postdata = getPostCountsByUsers($("#user_data").data().postcounts, minPosts);
        drawPieChart("posts", postdata, true, "#chart svg");
        insertTitle("Viimeiset " + totalPosts + " viestiä käyttäjien mukaan");
    }
}

function drawPosterBarChartOnly() {

}

//Ohjaa haettavan Qt:n foorumin käyttäjän sivuille
function redirectToQtUserPage(name) {
    if (!name.includes("users w/")) {
        window.open("http://forum.qt.io/user/" + name);
    }

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
    console.log(data)
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
    document.getElementById("buttonFeature").innerHTML = "";
    document.getElementById("usernames").innerHTML = "";
}
