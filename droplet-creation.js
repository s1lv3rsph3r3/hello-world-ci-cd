const axios = require('axios');

// example comment for pointless pull request
// Send a POST request
axios({
  method: 'post',
  url: 'https://api.digitalocean.com/v2/droplets',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${process.env.DO_AUTH_TOKEN}`
  },
  data: {
    "name": "testing-deployment",
    "region": "fra1",
    "size": "s-1vcpu-1gb",
    "image": "ubuntu-20-04-x64",
    "ssh_keys": null,
    "backups": false,
    "ipv6": true,
    "user_data": null,
    "private_networking": null,
    "tags": [
      "web"
    ]
  }
}).then((result) => {
  console.log(result);
}).catch((err) => {
  console.log('err occurred: ' + err.message);
});
