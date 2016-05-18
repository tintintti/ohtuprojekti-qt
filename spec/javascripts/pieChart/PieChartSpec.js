describe('Test piechart with jasmine ', function() {

    beforeEach(function() {

    });

    afterEach(function() {
        d3.selectAll('#chart svg').remove();
    });


    it('svg should be created', function() {
        drawEmailProviderPieChart();
        expect(getSvg()).not.toBeNull();
    });

    it('empty string returns empty array', function() {
        expect(textFileToArrayOfJsons("").length).toBe(0);
    });

    it('string with 2 jsons returns array of 2 jsons', function() {
       expect(textFileToArrayOfJsons('{"id":1}split123{"id":2}split123').length).toBe(2);
    });

    //it('2 same emails return array of 1 unique', function() {
       //expect nothing
    //});


    function getSvg() {
        return d3.select('#chart svg');
    }

});
