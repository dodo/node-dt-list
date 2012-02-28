List = require './lib/list'

n = 0
l = new List console.log

l.push ((done) -> setTimeout(done, 300);return n++)
l.push ((done) -> setTimeout(done, 100);return n++)
l.push ((done) -> setTimeout(done, 200);return n++)

l.insert 1, ((done) -> setTimeout(done, 40);return n++)

console.log l


