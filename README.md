# TikTok Flutter

Clone of TikTok with Flutter and Firebase.

## Preview

-Image -Image

Video Demo: https://youtu.be/sMKg6ILYgv0 

## Caracteristics 

-TikTok UI                                 
-Swipe Videos                                                            
-Dynamic Video Data Source                                                                  
-User Data (Name, Image)  
-Animations(Image rotation)  

## Libraries
-video_player.   
-firebase_database.   
-carousel_slider (To obtain the swipe effect).    
-cached_network_image

## Installation

1.-Clone or download this repository 

2.-Config your Firebase instance and replace the google-service.json in android/app/ or ios/Runner

3.-Config flutter project : 

```bash
flutter pug get
```

## Database

The app obtains the data from a Realtime Database and Firebase Storage, in reality, you can use the server that you want, only need's an API that returns a JSON in this format.


-Image

This is the link of template JSON to import the data in your firebase instance. 

-image

I use Firebase Storage for videos and Profile Pic's, but you can set the URL to any server that you want.

-Image


## TODO

-Likes.   
-Comments.   
-System of User (Register, Login, Profile Screen).   
-Upload Videos from the app