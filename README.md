# TikTok Flutter

Clone of TikTok with Flutter and Firebase.

## Preview

<img src="https://raw.githubusercontent.com/salvadordeveloper/TikTok-Flutter/master/images/screenshot.png" alt="drawing" width="200"/>

Video Demo: https://youtu.be/sMKg6ILYgv0 

## Caracteristics 

-TikTok UI                                 
-Swipe Videos                                                            
-Dynamic Video Data Source                                                                  
-User Data (Name, Image)  
-Animations(Image rotation)  

## Libraries
-video_player.   
-cloud_firestore:  
-cached_network_image

## Installation

1.-Clone or download this repository 

```bash
git clone https://github.com/salvadordeveloper/TikTok-Flutter.git
```

2.-Config your Firebase instance and insert the google-service.json in android/app/ or ios/Runner

3.-Config flutter project : 

```bash
flutter pub get
```

## Database

The app obtains the data from Firestore and Firebase Storage. The format is Firestore is : 

<img src="https://raw.githubusercontent.com/salvadordeveloper/TikTok-Flutter/master/images/database.png" alt="drawing" width="500"/>

I use Firebase Storage for videos and Profile Pic's, but you can set the URL to any server that you want.

<img src="https://raw.githubusercontent.com/salvadordeveloper/TikTok-Flutter/master/images/Storage.png" alt="drawing" width="700"/>

## TODO

-Likes.   
-Comments.   
-System of User (Register, Login, Profile Screen).   
-Upload Videos from the app


## Changelog

19/06/2020 
- Realtime Database To Firestore
- caroulsel_slider To PageView 

21/06/2020
- Bloc Pattern
- VideoManager
- Performace Improvements.

