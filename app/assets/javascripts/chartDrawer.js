
// HTML:ään lisäämistä

function emptyCharts() {
  d3.selectAll("#chart svg > *").remove()
  d3.selectAll("#chart2 svg > *").remove()
  d3.select("#chart svg").attr('height', 0);
  d3.select("#chart2 svg").attr('height', 0);
}

function insertTitle(title) {
    document.getElementById("title").innerHTML = title + "";
}

function makeUL(array) {
    var list = document.createElement('ul');
    for (var i = 0; i < array.length; i++) {
        var item = document.createElement('li');
        item.appendChild(document.createTextNode(array[i]));
        list.appendChild(item);
    }
    return list;
}

// pitkät piirtometodit tänne

function drawPieChart(type, data, showlegend, divName) {
    var height = setPieChartHeight(data);
    nv.addGraph(function() {
            d3.select(divName).attr('height', height);
            var chart = nv.models.pieChart()
                .x(function(d) {
                    return d.label
                })
                .y(function(d) {
                    return d.value
                })
                .height(height)
                .showLabels(true).showLegend(showlegend);
            if (type == "emails") {
                chart.showLabels(true).showLegend(showlegend).tooltipContent(function(key, y, e, graph) {
                    var wantedEmailForTooltip = $("#user_data").data().usersbyemail[key.data.label],
                        tooltipcontent = "<p><b>" + key.data.label + ": " + wantedEmailForTooltip.length + "</b></p>",
                        length = 10;
                    if (wantedEmailForTooltip.length < 10) length = wantedEmailForTooltip.length;
                    for (var i = 0; i < length; i++) {
                        tooltipcontent = tooltipcontent + "<p>" + wantedEmailForTooltip[i].user + "</p>"
                    }
                    if (wantedEmailForTooltip.length > 10) tooltipcontent = tooltipcontent + "<p>" + "..." + "</p>";
                    return tooltipcontent;
                });
            }
            d3.select(divName)
                .datum(data)
                .transition().duration(1200)
                .call(chart);

            d3.selectAll(".nv-label text")
                .attr("text-anchor", "middle")
                // Alter CSS attributes
                .style({
                    "font-size": "1em"
                });
            return chart;
        },
        function() {
            d3.select("#chart svg").selectAll(".nv-slice").on('click',
                function(d) {
                    if (type == "emails") listUsersOfProvider(d.data.label);
                    if (type == "posts") redirectToQtUserPage(d.data.label);
                });
        });
}

function setPieChartHeight(data) {
    var height = 800;
    height += data.length * 3;
    if (height > 1500) height = 1500;
    return height;
}

function objectSorter(array) {
    return array.sort(function(a, b) {
        return parseInt(a.value) - parseInt(b.value);
    });
}

function drawBarChart(data, divName) {

  addTitle(divName, "barChartTitle", "Käyttäjät viestimäärien mukaan");

  var barChartData = [{
    key: "Cumulative Return",
    values:data
  }]

  nv.addGraph(function() {
    var height = 600;

    d3.select(divName).attr('height', height);

    var chart = nv.models.discreteBarChart()
        .x(function(d) { return d.label })    //Specify the data accessors.
        .y(function(d) { return d.value })
        .staggerLabels(true)    //Too many bars and not enough room? Try staggering labels.
        .tooltips(false)        //Don't show tooltips
        .showValues(true)       //...instead, show the bar value right on top of each bar.
        .height(height);

    d3.select(divName)
        .datum(barChartData)
        .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });
}

function addTitle(divName, id, title) {
  var $div = $(divName).parent();
  $div.prepend('<h2 id='+id+'>'+title+'</h2>');
}
