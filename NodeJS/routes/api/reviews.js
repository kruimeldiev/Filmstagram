const express = require('express');
const uuid = require('uuid');
const moment = require('moment');
const router = express.Router();

// Initialize Firestore
const admin = require('firebase-admin');
const serviceAccount = require('../../ServiceAccountKey.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});
const db = admin.firestore();

// Route which gets all the reviews from Firebase
router.get('/', async (req, res) => {
    const snapshot = await db.collection('reviews').get();
    const reviews = [];
    snapshot.forEach((doc) => { reviews.push(doc.data()) });
    res.json(reviews);
});

// Route to get specific reviews using the author's name
router.get('/author/:authorName', async (req, res) => {

    const reviewsRef = db.collection('reviews');
    const snapshot = await reviewsRef.where('authorName', '==', req.params.authorName).get();
    const reviews = [];

    if (snapshot.empty) {
        res.status(400).json({ msg: `No reviews found from this author: ${req.params.uid}` });
    } else {
        snapshot.forEach((doc) => { reviews.push(doc.data()) });
        res.json(reviews);
    }
});

// Router to get a specific review based on the UID
router.get('/review/:uid', async (req, res) => {

    const usersRef = db.collection('reviews').doc(req.params.uid);
    const doc = await usersRef.get();

    if (!doc.exists) {
        res.status(400).json({ msg: `No review found for this UID: ${req.params.uid}` });
    } else {
        res.json( doc.data() );
    }
});

// Create a new review and store in Firestore asynchronously
router.post('/', async (req, res) => {
    // Generate an ID
    const generatedUid = uuid.v4();
    // Check if all data is available
    if (!req.body.title ||
        !req.body.filmTitle ||
        !req.body.filmDirector ||
        !req.body.reviewText) {
            return res.status(400).json({ msg: `Invalid review.` });
        }
    // Grab the document referance from Firestore
    const docRef = db.collection('reviews').doc(generatedUid);
    // Store the created review object
    await docRef.set({ 
        uid: generatedUid,
        title: req.body.title,
        authorName: req.body.authorName,
        writeDate: moment().format(),
        filmTitle: req.body.filmTitle,
        filmDirector: req.body.filmDirector,
        reviewText: req.body.reviewText,
        imageUrl: ''
    });
    res.json({ msg: `New review stored in database: ${ generatedUid }.`});
});

module.exports = router;