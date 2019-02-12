# CS-523: IOT Carbon Monoxide/Smoke Detector
Robert Herley

## Features
1. Hardware will be an always-on internet connected Arduino and/or Raspberry Pi with Carbon Monoxide and Smoke sensors that will connect to the client's network.
2. The app will send notifications to the client's iOS Device and/or Apple Watch if the hardware component detects CO/Smoke, also it will display the current reading of their devices.
3. iOS Companion app will allow for users to configure warning levels (in parts-per-million) and configure how they would like to recieve notifications.
4. The watchOS app will have a similar but simplified environment compared to the iOS App.
5. The app will support HomeKit, allowing easily integration with the client's other IOT HomeKit devices.


## Frameworks

- HomeKit: [Apple Docs](https://developer.apple.com/documentation/homekit)
	- For easy integration with other smart home devices.
- UserNotifications: [Apple Docs](https://developer.apple.com/documentation/usernotifications)
	- For the iOS app to push notifications to the client when there is an alarm/warning.
- Alamofire (http requests): [GitHub](https://github.com/Alamofire/Alamofire)
	- For making web requests easier/simplified.
- socket.io-client-swift: [GitHub](https://github.com/socketio/socket.io-client-swift)
	- To connect to the server so the client can recieve real-time readings. 	
