const functions = require("firebase-functions");
const admin = require("firebase-admin");

// admin.initializeApp();
var serviceAccount = require("./appfirebase-656ab-firebase-adminsdk-6slkz-7b0bf38821.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://appfirebase-656ab-de46f.firebaseio.com"
});


exports.kakaologin = functions.https.onRequest((request, response) => {
  functions.logger.info(request.query.code);
  response.redirect(`kakaologincallback://success?code=${request.query.code}`);
});