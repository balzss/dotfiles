const miio = require('miio');

const devices = miio.devices({
    cacheTime: 300 // 5 minutes. Default is 1800 seconds (30 minutes)
});

devices.on('available', device => {
    console.log(device);
    device.setBrightness(5);
});
