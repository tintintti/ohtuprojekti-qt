describe('Test charts ', function() {

    beforeEach(function() {
        data = [{
            "label": "testUser1",
            "value": 9
        }, {
            "label": "testUser2",
            "value": 25
        }, {
            "label": "testUser3",
            "value": 14
        }]
    });

    afterEach(function() {

    });

    it('height won\'t be set higher than 1500', function() {
        var height = setPieChartHeight(300);
        expect(height).toEqual(1500);
    });

    it('users will be sorted by post count', function() {
        var list = getPostCountsByUsers(data, 5);
        expect(list[3]).toEqual(data[1]);
    });

    function getSvg() {
        return d3.select('#chart svg');
    }

});
