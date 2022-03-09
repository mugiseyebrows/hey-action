const fs = require('fs')
const axios = require('axios')

axios
  .get('https://www.npmjs.com/package/axios#example')
  .then(res => {
    console.log(`statusCode: ${res.status}`)
    console.log(res)
  })
  .catch(error => {
    console.error(error)
  })