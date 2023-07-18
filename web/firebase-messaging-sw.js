importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyDmwvFbvgplskdgvNhNOJaUXq5RSwCpyzo",
    authDomain: "city-events-flutter.firebaseapp.com",
    projectId: "city-events-flutter",
    storageBucket: "city-events-flutter.appspot.com",
    messagingSenderId: "870130822992",
    appId: "1:870130822992:web:d08f77048f19b2ace50655",
    measurementId: "G-J1DV18W1VW"
});

// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage(function(payload) {
    console.log('Received background message ', payload);

    const notificationTitle = payload.notification.title;
    const notificationOptions = {
      body: payload.notification.body,
    };

    self.registration.showNotification(notificationTitle,
      notificationOptions);
  });