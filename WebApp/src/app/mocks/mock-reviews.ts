/// This is a mock file for reviews. It is just test data

/// Using this import we know what the model is for our mock data
import { FetchReview } from "../models/Review";

/// export returns the mock data itself as an array
export const REVIEWS: FetchReview[] = [
    {
        uid: '1',
        title: 'Test title',
        authorName: 'Casper',
        writeDate: '21 may 2022',
        filmTitle: 'Ex Machina',
        filmDirector: 'Steven Spielberg',
        reviewText: 'Film about robots',
        imageUrl: ''
    },
    {
        uid: '2',
        title: 'Second title',
        authorName: 'Cody',
        writeDate: '18 may 2022',
        filmTitle: 'Rabat',
        filmDirector: 'Paus',
        reviewText: 'Roadtrip to Marokko',
        imageUrl: ''
    }
];