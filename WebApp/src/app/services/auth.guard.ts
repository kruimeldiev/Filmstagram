import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, RouterStateSnapshot, Router } from '@angular/router';
import { take, tap, map, Observable } from 'rxjs';
import { AuthService } from './auth.service';

@Injectable({
  providedIn: 'root'
})

export class AuthGuard implements CanActivate {

  constructor(private auth: AuthService, private router: Router) { }

  // Whenever a route is called that has this canActivate set, this function will check if the user is signed in
  // Otherwise we will redirect to login page
  canActivate(next, state): Observable<boolean> {
    return this.auth.loggedInUser$.pipe(
      take(1),
      map(user => !!user),
      tap(loggedIn => {
        if (!loggedIn) {
          this.router.navigate(['/']);
        }
      })
    );  
  }
}
