var fs = require('fs');
var files = fs.readdirSync('lib');

describe('woothee', function(){
  it('should be required successfully', function(){
    files.forEach(function(f){
      var modname = (/^(.*)\.js$/.exec(f) || [null,null])[1];
      if (! modname)
        return;
      var x = require('../lib/' + modname);
    });
  });
});
