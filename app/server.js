const express = require('express')
const os = require("os")
const PORT = process.env.PORT || 3000

var message = process.env.MESSAGE || "Hello world!";

express()
  .get('/', function (req, res) {
    res.send({
      message: message,
      platform: os.type(),
      release: os.release(),
      hostName: os.hostname()
    })
  })
  .listen(PORT, () => console.log(`Listening on ${ PORT }`))
