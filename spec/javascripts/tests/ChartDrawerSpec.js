describe('Test chartDrawer ', function() {

    beforeEach(function() {

    });

    afterEach(function() {

    });

    it('testAddTitle', function() {
      addTitle("title", "id", "asd")
      expect($("#id")).toHaveText("asd");
    });

    it('height won\'t be set higher than 1500', function() {
        var height = setPieChartHeight(300);
        expect(height).toEqual(1500);
    });

    it('testAddSvg', function() {
      addSvg("title", "chart")
      expect($("#chart")).toBeInDOM();
    });

    describe("long asynchronous specs", function() {

      var originalTimeout;

      beforeEach(function(done) {
        originalTimeout = jasmine.DEFAULT_TIMEOUT_INTERVAL;
        jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000;
        jasmine.clock().install();
             //needs karma
          // browser().navigateTo('../app/views/charts/forumCharts.html');
          postBarData = [{
              "label": "1-5",
              "value": 9
          }, {
              "label": "6-9",
              "value": 20
          }, {
              "label": "10+",
              "value": 14
          }]

          emailChartData = [{
            "label": "email",
            "value": 300
          }, {
            "label": "anotherEmail",
            "value": 2
          }]
          done();
      });

      afterEach(function() {
        jasmine.clock().uninstall();
        jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
      });

      it('testDrawBarChart', function() {
        drawBarChart(postBarData, "title");
        jasmine.clock().tick(1000);
        expect($('#barChartTitle')).toHaveText("Käyttäjät viestimäärien mukaan");
        expect($('#barChart')).toContainText('1-5');
        expect($('#barChart')).toContainText('10+');
        expect($('#barChart')).toContainText('14');
        expect($('#barChart')).not.toContainText('100+');
      });

      it('testDrawPieChart', function() {
        drawPieChart("email", emailChartData, true, "title");
        jasmine.clock().tick(1000);
        expect($('#pieChartTitle')).toHaveText("Sähköpostien palveluntarjoajat");
        expect($('#pieChart')).toContainText('email');
        expect($('#pieChart')).toContainText('anotherEmail');
      });
    });


    //it('users will be sorted by post count', function() {
      //  var list = getPostCountsByUsers(data, 5);
      //  expect(list[3]).toEqual(data[1]);
    //});

});
