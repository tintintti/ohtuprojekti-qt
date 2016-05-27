describe('Test piechart with jasmine ', function() {

    beforeEach(function() {
      data = [{"label":"testUser1", "value":14}, {"label":"testUser2", "value":9}]
    });

    afterEach(function() {
        //d3.selectAll('#chart svg').remove();
    });

    //it('2 same emails return array of 1 unique', function() {
       //expect nothing
    //});


    function getSvg() {
        return d3.select('#chart svg');
    }

});
