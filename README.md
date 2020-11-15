# ItunesSearch
MVVM pattern

Model - represents simple data or to the data access layer
View - refers to the View or ViewController objects accompanied by Storyboards or .xibs
ViewModel - The view model is an abstraction of the view exposing public properties

Collaborative working

By separating the visual part of the app (the user interface, or UI) from the related code it becomes possible to have specialists in each area work on related items at the same time. The theory is designers can work on the UI at the same time as developers are working on the code without needing to have them both work on the same files at the same time.

Ease of testing

MVVM  breaks the coupling between the application logic and the UI and makes testing more accessible.

With MVVM each piece of code is more granular and if it is implemented right your external and internal dependences are in separate pieces of code from the parts with the core logic that you would like to test. That makes it a lot easier to write unit tests against a core logic.

Ease of maintainability

By having a separation between the different parts of an app’s code it brings a level of structure and uniformity to the code. It’s easy to see where things should go or where they’re likely to be.

Transparent Communication

The view model provides a transparent interface to the view controller, which it uses to populate the view layer and interact with the model layer. This results in transparent communication between the four layers of your application.


