import { Component, OnInit } from '@angular/core';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  emailAddress: string;
  password: string;
  verifyPassword: string;
  username: string;

  constructor(private authService: AuthService) { }

  ngOnInit(): void {
  }

  onRegisterUser() {
    if (this.password != this.verifyPassword) {
      alert('Passwords do not match');
      return;
    }
    if (!this.emailAddress || !this.password || !this.verifyPassword || !this.username) {
      alert('Please fill in all the fields.');
      return;
    }
    this.authService.signUpUser(this.emailAddress, this.password, this.username);
  }
}
