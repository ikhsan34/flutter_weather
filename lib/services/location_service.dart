// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:isolate';

import 'package:flutter_weather/models/weather_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

enum COMMAND {
  init,
  getLocation,
  result,
}

class CommandArgs {
  final COMMAND command;
  final List<Object>? data;
  final SendPort? sendPort;

  CommandArgs(this.command, this.sendPort, this.data);
}

class LocationService {
  static final LocationService _instance = LocationService._internal();
  LocationService._internal();
  factory LocationService() => _instance;

  late bool serviceEnabled;
  late PermissionStatus permissionGranted;
  late LocationData locationData;

  final LocationWorker worker = LocationWorker();
  final ReceivePort _receivePort = ReceivePort();

  void init() {
    if (worker.isolateReady.isCompleted) {
      return;
    }
    worker.spawn().then((value) {
      worker.runCommand(CommandArgs(COMMAND.init, _receivePort.sendPort, null));
    });

    _receivePort.listen((message) {
      if (message is CommandArgs) {
        print('Main thread >>> ${message.command}');
        _handleCommand(message);
      }
    });
  }

  void getLocation() {
    worker.runCommand(CommandArgs(COMMAND.getLocation, _receivePort.sendPort, null));
  }

  void _handleCommand(CommandArgs args) {
    switch (args.command) {
      case COMMAND.result:
        final List<Object> data = args.data!;
        serviceEnabled = data[0] as bool;
        permissionGranted = data[1] as PermissionStatus;
        locationData = data[2] as LocationData;
        print('Data >>> ${locationData.latitude}, ${locationData.longitude}');
        break;
      default:
    }
  }
}

class LocationWorker {
  final Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  late SendPort _sendPort;
  final Completer<void> isolateReady = Completer.sync();

  Future<void> spawn() async {
    final receivePort = ReceivePort();
    receivePort.listen(_handleResponsesFromIsolate);
    await Isolate.spawn(_startRemoteIsolate, receivePort.sendPort);
  }

  void _handleResponsesFromIsolate(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      isolateReady.complete();
      print('Isolate ready!');
      return;
    }
    print('Isolate thread >>> ${message.command}');
    _handleCommand(message);
  }

  static void _startRemoteIsolate(SendPort port) {
    final receivePort = ReceivePort();
    port.send(receivePort.sendPort);

    receivePort.listen((dynamic message) async {
      port.send(message);
    });
  }

  void _handleCommand(CommandArgs args) async {
    switch (args.command) {
      case COMMAND.init:
        await _initLocationService();
        args.sendPort!.send(CommandArgs(COMMAND.result, null, [_serviceEnabled, _permissionGranted, _locationData]));
        break;
      case COMMAND.getLocation:
        _locationData = await location.getLocation();
        args.sendPort!.send(CommandArgs(COMMAND.result, null, [_serviceEnabled, _permissionGranted, _locationData]));
        break;
      default:
        break;
    }
  }

  Future<void> _initLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        print('Location permission denied.');
        return;
      }
    }

    _locationData = await location.getLocation();
    writeCache();

    print('Location Data: $_locationData');
  }

  Future<void> writeCache() async {
    final box = GetStorage();
    final Coordinate coordinate = Coordinate(
      lat: _locationData.latitude!,
      lon: _locationData.longitude!,
    );

    box.write('last_location', coordinate.toJson());
    box.write('location_timestamp', DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> runCommand(CommandArgs args) async {
    await isolateReady.future;
    _sendPort.send(args);
  }
}
