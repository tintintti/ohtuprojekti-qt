describe('Test chartDrawer ', function() {

    beforeEach(function() {

    });

    afterEach(function() {

    });

    it('test adding title', function() {
      addTitle("title", "id", "asd")
      expect($("#id")).toHaveText("asd");
    });

    it('height shouldn\'t be set higher than 1500', function() {
        var height = setPieChartHeight(300);
        expect(height).toEqual(1500);
    });

    it('test adding svg', function() {
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

          labels = ["Käyttäjien määrä", "Viestien määrä"];
          done();
      });

      afterEach(function() {
        jasmine.clock().uninstall();
        jasmine.DEFAULT_TIMEOUT_INTERVAL = originalTimeout;
      });

      it('test drawing barchart', function() {
        drawBarChart(postBarData, "title", labels);
        jasmine.clock().tick(1000);
        expect($('#barChart')).toContainText('1-5');
        expect($('#barChart')).toContainText('10+');
        expect($('#barChart')).toContainText('14');
        expect($('#barChart')).not.toContainText('100+');
      });

      it('test barchart has labels', function() {
        drawBarChart(postBarData, "title", labels);
        jasmine.clock().tick(1000);
        expect($('#barChart')).toContainText('Käyttäjien määrä');
        expect($('#barChart')).toContainText('Viestien määrä');
      });

      it('test drawing piechart', function() {
        drawPieChart("email", emailChartData, true, "title");
        jasmine.clock().tick(1000);
        expect($('#pieChart')).toContainText('email');
        expect($('#pieChart')).toContainText('anotherEmail');
      });
    });
});
