import { Component, Input, OnInit, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-button',
  templateUrl: './button.component.html',
  styleUrls: ['./button.component.css']
})
export class ButtonComponent implements OnInit {

  // When a property is marked with @Input, we can add the property to the initializer to make the component more custom
  @Input() buttonText: string;
  @Input() color: string;
  @Input() hasBorder: boolean;

  // Just like the @Input properties, we can pass in @Output to receive events from the component
  // In header.component.html for example, we set this @Output to call toggleNewReview()
  @Output() btnClick = new EventEmitter();

  constructor() { }

  ngOnInit(): void { }

  // MARK: - Down here we can add Events, these are functions for a component

  // In button.component.html we set the onClick() function to get called when the user clicks on the button
  // Using .emit() we call the @Output EventEmitter so that we can use functions from other components
  // Think of this as the Swift Delegate pattern
  onClick() {
    this.btnClick.emit();
  }
}
