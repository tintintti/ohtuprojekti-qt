// HTML operations here

function addTitle(divName, id, title) {
  var $div = $(divName);
  $div.append('<h2 id='+id+'>'+title+'</h2>');
}

function addSvg(divName, id) {
  var $div = $(divName);
  $div.append('<svg id='+id+'></svg>');
}

//for appending a list to the HTML
function makeUL(array) {
    var list = document.createElement('ul');
    for (var i = 0; i < array.length; i++) {
        var item = document.createElement('li');
        item.appendChild(document.createTextNode(array[i]));
        list.appendChild(item);
    }
    return list;
}

function emptyCharts() {
  d3.selectAll("#charts > *").remove();
}

function emptyChartByTitle(title) {
  d3.selectAll("#" + title + " > *").remove();
}

//empties the containers so that some other chart can use them
function emptyContainers() {
    document.getElementById("buttonFeature").innerHTML = "";
    if (document.getElementById("info")) document.getElementById("info").innerHTML = "";
    if (document.getElementById("usernames")) document.getElementById("usernames").innerHTML = "";
    if (document.getElementById("barChartTitle")) document.getElementById("barChartTitle").innerHTML = "";
    emptyCharts();
}

//  Piechart-related

function drawPieChart(type, data, showlegend, divName, id) {
    addSvg(divName, id);
    var height = setPieChartHeight(data.length);
    nv.addGraph(function() {
            d3.select('#' + id).attr('height', height);
            var chart = nv.models.pieChart()
                .x(function(d) {
                    return d.label
                })
                .y(function(d) {
                    return d.value
                })
                .valueFormat(d3.format(".0f"))
                .height(height)
                .showLabels(true).showLegend(showlegend);
            if (type == "forumEmails") {
                setToolTipContent(chart, $("#forum_data").data().usersbyemail);
            }
            d3.select('#' + id)
                .datum(data)
                .transition().duration(1200)
                .call(chart);

            d3.selectAll(".nv-label text")
                .attr("text-anchor", "middle")
                // Alter CSS attributes
                .style({
                    "font-size": "1em"
                });

            d3.select('#' + id).selectAll(".nv-slice").on('click',
                function(d) {
                    if (type == "forumEmails") listUsersOfProvider(d.data.label);
                    if (type == "forumPosts") redirectToQtUserPage(d.data.label);
            });
            return chart;
        });
}

//sets the nodes in the given data to a tooltip for the chart
function setToolTipContent(chart, data) {
  chart.tooltipContent(function(key, y, e, graph) {
      var dataForTooltip = data[key.data.label],
          tooltipContent = "<p><b>" + key.data.label + ": " + dataForTooltip.length + "</b></p>",
          length = 10;
      if (dataForTooltip.length < length) length = dataForTooltip.length;
      for (var i = 0; i < length; i++) {
          tooltipContent = tooltipContent + "<p>" + dataForTooltip[i].user + "</p>"
      }
      if (dataForTooltip.length > length) tooltipContent = tooltipContent + "<p>" + "..." + "</p>";
      return tooltipContent;
  });
}

//scales the piechart size with the amount of data (length)
function setPieChartHeight(length) {
    var height = 800;
    height += length * 3;
    if (height > 2000) height = 2000;
    return height;
}

//adds total counts under the set minimum as its own node with the label words
//("users w/ <10 posts" for example) and then sorts the data using objectSorter
function sortDataWithMin(counts, min, labelWords) {
    var data = []
    var totalCountsUnderMin = 0;
    for (var count in counts) {
        if (counts[count].value < min) {
            totalCountsUnderMin++;
        } else {
            data.push(counts[count])
        }
    }
    if (min > 1) {
        data.push({
            "label": labelWords[0] + " w/ <" + min + " " + labelWords[1],
            "value": totalCountsUnderMin
        });
    }
    return objectSorter(data);
}

//  Barchart-related

function drawBarChart(data, divName, xyLabels, id) {
  addSvg(divName, id);

  var barChartData = [{
    key: "Cumulative Return",
    values:data
  }]

  nv.addGraph(function() {
    var height = 600;

    d3.select('#' + id).attr('height', height);
    var chart = nv.models.discreteBarChart()
        .x(function(d) { return d.label })
        .y(function(d) { return d.value })
        .staggerLabels(true)
        .tooltips(false)
        .showValues(true)
        .valueFormat(d3.format(".0f"))
        .height(height)
        chart.xAxis.axisLabel(xyLabels[0])
        .axisLabelDistance(-14)
        chart.yAxis.axisLabel(xyLabels[1])
        .axisLabelDistance(-14)
        chart.yAxis.tickFormat(d3.format(',f'));


    d3.select('#' + id)
        .datum(barChartData)
        .call(chart);

    nv.utils.windowResize(chart.update);
    return chart;
  });
}

//these create the groups to be shown in the barchart based on
//given data and labels

function createBarChartGroups(data, labels) {
  var labelValues = initializeBarChartMap(labels);

  var counts = objectSorter(data);

  for (i in counts) {
    var count = counts[i].value
    mapCounts(labelValues, count, labels);
  }
  return mapToArrayForNvd3(labelValues);
}

function initializeBarChartMap(labels) {
  var dataMap = new Map();
  labels.forEach(function(label) {
    dataMap.set(label[0], 0);
  });
  return dataMap;
}

function mapCounts(dataMap, counts, labels) {
    labels.forEach(function(label) {
      if (counts >= label[1] && counts <= label[2]) dataMap.set(label[0], dataMap.get(label[0])+1);
    });
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

//  Other

function objectSorter(array) {
    return array.sort(function(a, b) {
        return parseInt(a.value) - parseInt(b.value);
    });
}
