describe('Test forumCharts ', function() {

    beforeEach(function() {

    });

    afterEach(function() {

    });

    it('users will be properly sorted by post count', function() {
        postData = [{
          "label": "1",
          "value": 1
        }, {
          "label": "3",
          "value": 3
        }, {
          "label": "2",
          "value": 2
        }]
        var list = getPostCountsByUsers(postData, 0);
        expect(list[3]).toEqual(postData[1]);
    });

});