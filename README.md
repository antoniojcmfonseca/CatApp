# CatApp

## Description

CatApp is a Swift application designed to provide a list of cat breeds with a detailed description of each one, allowing to user to save their favorite breeds.

## Features

* Get list of breeds
* Get detailed information of a specific breed
* Add and remove breeds as favorite

## Dependencies

* Alamofire - Used to interact with RESTful APIs and handle network requests in a simplified way with request and response handling.

* AlamofireImage - Used for downloading and caching images from the internet.

## Code Structure

The app is structured as follows:

* **/BreedsView** - Contains the logic for the main view of the app
    * **/Model** - Contains the models logic
        * **/FavoriteBreed** - Model of the favorite breeds to save in SwiftData
    * **/ViewModel** - Contains the view models logic
        * **/BreedsViewModel** - View model of the breeds list
        * **/BreedViewModel** - View model of a specific breed
    * **/View** - Contains the views
        * **/BreedsView** - Views of the main component, with tabs to show all breeds and favorite breeds
        * **/BreedCellView** - View of the cell component used in the list views
        * **/SearchBar** - View of the search bar component
* **/BreedDetailView** - Contains the logic for the detail view of a breed
    * **/View** - Contains the views
        * **/BreedDetailView** - View of the component with the detailed information of a breed
* **/Utils** - Helpers
    * **/Extensions** - Extensions of native components
        * **/Array+CatApp** - Extension of Array to help remove duplicates
        * **/UIDevice+CattApp** - Extension of UIDevice to check if the current device is iPhone or iPad

* **/Core** - Contains the core functionalities of the app.
    * **/Interface** - Contains the exposed interfaces for the UI
        * **/Protocols** - Contains protocol definitions used throughout the UI
            * **/APIFactory** - Exposed protocol to create instances of Core services to the UI
            * **/Manager** - Contains manager protocols
                * **/NetworkManager** - Network manager to handle RESTful requests to API
            * **/Services** - Contains service protocols definitions
                * **/BreedService** - Service to get breeds results from network
                * **/ImageService** - Service to download images from network
            * **/Models*
                * **/Breed** - Model of the breed
                * **/BreedImage** - Model of the breed image
    * **/Implementation** - Contains the implementations of the exposed Core services
        * **/Factories**
            * **/APIFactoryImpl** - Implementation of APIFactory protocol
        * **/Manager**
            * **/NetworkManagerImpl** - Implementation of NetworkManager
        * **/Services**
            * **/BreedsServiceImpl** - Implementation of BreedsService
            * **/ImageServiceImpl** - Implementation of ImageService
        * **/Models**
            * **/BreedResponse** - Parse of API response, implementation of Breed model
            * **/BreedImageResponse** - Parse of API Response, implementation of BreedImage model
        * **/Utils** - Helpers
            * **/breeds.json** - Mock of breeds used in unit testing
