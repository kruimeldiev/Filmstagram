import { Component, OnInit, Output } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})

export class LoginComponent implements OnInit {

  emailAddress: string;
  password: string;

  constructor(
    private authService: AuthService) { }

  ngOnInit(): void {
  }

  onLoginSubmit() {
    if (!this.emailAddress || !this.password) {
      alert('Enter a valid email and password to login.');
      return;
    }
    this.authService.signInUser(this.emailAddress, this.password);
  }
}
