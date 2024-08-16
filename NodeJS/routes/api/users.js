const express = require('express');
const router = express.Router();

const admin = require('firebase-admin');
const db = admin.firestore();

// Route to get specific user based on their UID
router.get('/:uid', async (req, res) => {

    const usersRef = db.collection('users').doc(req.params.uid);
    const doc = await usersRef.get();

    if (!doc.exists) {
        res.status(400).json({ msg: `No user found for this UID: ${req.params.uid}` });
    } else {
        res.json( doc.data() );
    }
});

// Route to set the user data after a user has registered via the web app
router.post('/register', async (req, res) => {
    if (!req.body.uid ||
        !req.body.email ||
        !req.body.username) {
            return res.status(400).json({ msg: `Invalid user data.`});
        }
    const docRef = db.collection('users').doc(req.body.uid);
    await docRef.set({
        uid: req.body.uid,
        email: req.body.email,
        username: req.body.username
    });
    res.json({ msg: `New user registerd to database: ${ req.body.uid }`});
});

module.exports = router;