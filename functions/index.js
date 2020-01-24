const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

const firestore = admin.firestore();
const settings = { timestampsInSnapshots: true };
firestore.settings(settings);

//For setup/creation of the user accounts...we can do this client side also, but that means more data usage / computation
//from the client...instead offloading this work to server side...

exports.createUserAccount = functions.auth.user().onCreate(event => {
    console.log('User id to be created..', event.uid);

    const userID = event.uid;
    const email = event.email;
    const photoURL = event.photoURL;
    const name = event.displayName;

    return firestore.collection('user').doc(`${userID}`).set({
        email: email,
        photoURL: photoURL || 'happy',
        userID:userID,
        name: name
    }).then(function () {
        return   console.log("Created user... ", userID);
    }).catch(error => {
        console.error("Error while creating ", error);
    });
});
