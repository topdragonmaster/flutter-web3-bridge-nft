# Flutter Web3 reference project

A new Flutter project which supports bridging of VID and VIVID NFT metadata serialization and deserialization.

## Getting Started

Project supports the following features:

**Web3 wallet** 

Holding keys for trnsaction signing with Videocoin and Ethereum blockchains

Functionality for bridging of VID (move VID tokens to/form VideoCoin to Ethereum Mainnet)  

**Support for retrieving VIVID NFT Tokens**

Reading token metadata directly from blockchain based on wallet address from a given contract.

Support for VIVID NFT token metadata schema (Serialized, deserizlizer) 

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/videocoin/flutter-bridge-nft-metadata.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**
Run the project.
```
flutter run
```

### Libraries & Tools Used

* [web3dart](https://github.com/xclud/web3dart)
* [json_serializable](https://github.com/google/json_serializable.dart/tree/master/json_serializable)
* [json_annotation](https://github.com/google/json_serializable.dart/tree/master/json_annotation)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
├── pages
│   │
│   ├── nft                      # NFT folder
│   │    ├── serializer          # serialize/deserialze contract service
│   │    ├── nftBox.dart         # NFTBox Component
│   │    └── index.dart          # NFT main page
│   │
│   └── vividwallet              # VID Bridge folder
│        ├── service             # Contract service
│        ├── staker.dart         # staker server
│        └── index.dart          # Wallet main page
│
└── main.dart                    # main funtion
```


A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
