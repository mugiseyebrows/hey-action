const fs = require('fs')

console.log('Hello from index.js')

fs.writeFileSync("test.txt", "Hello from index.js")