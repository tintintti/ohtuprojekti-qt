
// HTML:ään lisäämistä

function emptyCharts() {
  d3.selectAll("#charts > *").remove();
}

function emptyPieChart() {
  d3.selectAll("#pieChart > *").remove();
}

function emptyBarChart() {
  d3.selectAll("#barChart > *").remove();
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

function addTitle(divName, id, title) {
  var $div = $(divName);
  $div.append('<h2 id='+id+' class="container">'+title+'</h2>');
}

function addSvg(divName, id) {
  var $div = $(divName);
  $div.append('<svg id='+id+'></svg>');
}

// pitkät piirtometodit tänne

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
            if (type == "emails") {
                setEmailToolTipContent(chart);
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
                    if (type == "emails") listUsersOfProvider(d.data.label);
                    if (type == "posts") redirectToQtUserPage(d.data.label);
            });
            return chart;
        });
}

function setEmailToolTipContent(chart) {
  chart.tooltipContent(function(key, y, e, graph) {
      var emailForTooltip = $("#forum_data").data().usersbyemail[key.data.label],
          tooltipContent = "<p><b>" + key.data.label + ": " + emailForTooltip.length + "</b></p>",
          length = 10;
      if (emailForTooltip.length < length) length = emailForTooltip.length;
      for (var i = 0; i < length; i++) {
          tooltipContent = tooltipContent + "<p>" + emailForTooltip[i].user + "</p>"
      }
      if (emailForTooltip.length > length) tooltipContent = tooltipContent + "<p>" + "..." + "</p>";
      return tooltipContent;
  });
}

function setPieChartHeight(length) {
    var height = 800;
    height += length * 3;
    if (height > 2000) height = 2000;
    return height;
}

function objectSorter(array) {
    return array.sort(function(a, b) {
        return parseInt(a.value) - parseInt(b.value);
    });
}

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
        .x(function(d) { return d.label })    //Specify the data accessors.
        .y(function(d) { return d.value })
        .staggerLabels(true)    //Too many bars and not enough room? Try staggering labels.
        .tooltips(false)        //Don't show tooltips
        .showValues(true)       //...instead, show the bar value right on top of each bar.
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

function createBarChartGroups(data, labels) {
  var labelValues = initializeBarChartMap(labels);

  var counts = objectSorter(data);

  for (i in counts) {
    var count = counts[i].value
    mapCounts(labelValues, count, labels);
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
