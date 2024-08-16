import { Injectable } from '@angular/core';
import { FetchReview, PostReview } from '../models/Review';
import { REVIEWS } from 'src/app/mocks/mock-reviews';
import { Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';

// Create an object that passens the HttpHeaders for any post or update API call
const httpOptions = {
  headers: new HttpHeaders({
    'Content-Type': 'application/json'
  })
}

@Injectable({
  providedIn: 'root'
})

export class ReviewsService {

  private apiUrl = 'http://localhost:3636/api/reviews';

  constructor(private http:HttpClient) { }

  /// This function returns the available reviews
  /// Using the Observable, we make this function asycronous
  getReviews(): Observable<FetchReview[]> {
    return this.http.get<FetchReview[]>(this.apiUrl);

    // To fetch test data: uncomment these lines
    // const reviews = of(REVIEWS);
    // return reviews;
  }

  getSingleReview(uid: string): Observable<FetchReview> {
    return this.http.get<FetchReview>(`${this.apiUrl}/review/${uid}`);
  }

  postReview(review: PostReview): Observable<PostReview> {
    return this.http.post<PostReview>(this.apiUrl, review, httpOptions);
  }
}
