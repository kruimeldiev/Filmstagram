
/// This is the model for a Review object that we fetch from the Node backend

export interface FetchReview {
    uid: string;
    title: string;
    authorName: string;
    writeDate: string;
    filmTitle: string;
    filmDirector: string;
    reviewText: string;
    imageUrl: string;
}

export interface PostReview {
    title: string;
    filmTitle: string;
    filmDirector: string;
    reviewText: string;
    authorName: string;
}