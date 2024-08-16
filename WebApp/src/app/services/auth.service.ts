import { Injectable } from '@angular/core';
import { Router } from '@angular/router';

import { AngularFireAuth } from "@angular/fire/compat/auth";

import { User } from '../models/User';
import { Observable, of } from 'rxjs';
import { switchMap } from 'rxjs/operators';

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

export class AuthService {

  loggedInUser$: Observable<User | null | undefined>;

  private apiUrl = 'http://localhost:3636/api/users/';

  constructor(
    private http:HttpClient,
    private afAuth: AngularFireAuth,
    private router: Router
  ) {
    // Using this observable, we get notified whenever the auth state of the user changes
    // Whenever the auth state changes, we set the loggedInUser object and fill it with data from the Node server
    this.loggedInUser$ = this.afAuth.authState.pipe(
      switchMap(user => {
        if (user) {
          return this.getUserData(user.uid);
        } else {
          return of(null);
        }
      })
    )
  }

  async signInUser(email: string, password: string) {
    this.afAuth.signInWithEmailAndPassword(email, password).then((result) => {
      if (result.user) {
        this.router.navigate(['/reviewsOverview'])
      } else {
        console.log(`TODO: Error handling`)
      }
    });
  }

  async signUpUser(email: string, password: string, username: string) {
    this.afAuth.createUserWithEmailAndPassword(email, password).then((userCredentials) => {
      if (userCredentials.user) {
        this.setUserData(userCredentials.user.uid, email, username).subscribe((user) => {
          this.router.navigate(['/reviewsOverview']);
        });
      }
    })
  } 

  async signOutUser() {
    this.afAuth.signOut().then(() => {
      this.router.navigate(['/']);
    })
  }

  // Get the user data from Node backend
  private getUserData(uid: string): Observable<User | null | undefined> {
    return this.http.get<User>(`${this.apiUrl}${uid}`);
  }

  // Set the registered user data via the Node backend
  private setUserData(uid: string, email: string, username: string): Observable<User> {
    const user: User = {
      uid: uid,
      email: email,
      username: username
    }
    return this.http.post<User>(`${this.apiUrl}/register`, user, httpOptions);
  }
}