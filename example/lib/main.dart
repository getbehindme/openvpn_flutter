import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:openvpn_flutter/openvpn_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late OpenVPN engine;
  VpnStatus? status;
  String? stage;
  bool _granted = false;
  String? _config;

  @override
  void initState() {
    engine = OpenVPN(
      onVpnStatusChanged: (data) {
        setState(() {
          status = data;
        });
      },
      onVpnStageChanged: (data, raw) {
        setState(() {
          stage = raw;
        });
      },
    );

    engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier:
          "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (stage) {
        setState(() {
          this.stage = stage.name;
        });
      },
      lastStatus: (status) {
        setState(() {
          this.status = status;
        });
      },
    );
    
    // Load VPN configuration from file
    _loadVpnConfig();
    super.initState();
  }

  Future<void> _loadVpnConfig() async {
    try {
      final configString = await rootBundle.loadString('assets/vpn_config.ovpn');
      setState(() {
        _config = configString;
      });
    } catch (e) {
      print('Error loading VPN config: $e');
      // You might want to show an error dialog here
    }
  }

  Future<void> initPlatformState() async {
    if (_config == null) {
      print('VPN config not loaded yet');
      return;
    }
    
    engine.connect(
      _config!,
      "GetBehind.Me VPN",
      username: defaultVpnUsername,
      password: defaultVpnPassword,
      certIsRequired: true,
    );
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(stage?.toString() ?? VPNStage.disconnected.toString()),
              Text(status?.toJson().toString() ?? ""),
              Text(_config != null ? "Config loaded" : "Loading config..."),
              TextButton(
                child: const Text("Start"),
                onPressed: _config != null ? () {
                  initPlatformState();
                } : null,
              ),
              TextButton(
                child: const Text("STOP"),
                onPressed: () {
                  engine.disconnect();
                },
              ),
              if (Platform.isAndroid)
                TextButton(
                  child: Text(_granted ? "Granted" : "Request Permission"),
                  onPressed: () {
                    engine.requestPermissionAndroid().then((value) {
                      setState(() {
                        _granted = value;
                      });
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

const String defaultVpnUsername = "";
const String defaultVpnPassword = "";
