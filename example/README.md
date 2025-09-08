# openvpn_flutter_example

Demonstrates how to use the openvpn_flutter plugin.

## Compile the openvpn_flutter plugin

Running the example app will also compile the plugin.

```
cd example
flutter clean
dart pub cache clean
flutter pub cache clean
Remove-Item -Path "android\.gradle"
flutter pub get
flutter run
```

## VPN Configuration Setup

**Important:** Before running this app, you need to set up your VPN configuration file.

📋 **See [VPN_CONFIG_README.md](VPN_CONFIG_README.md) for detailed setup instructions.**

The app loads VPN configuration from an external file (`assets/vpn_config.ovpn`) that contains your certificates and private keys. This file is excluded from git for security reasons.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
