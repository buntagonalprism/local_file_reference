import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:uuid/uuid.dart';

// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

class LocalFileReferencePlugin {

  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'com.buntagon/local_file_reference',
      const StandardMethodCodec(),
      registrar.messenger,
    );
    final LocalFileReferencePlugin instance = LocalFileReferencePlugin();
    channel.setMethodCallHandler(instance.onMethodCall);
  }

  static final _files = Map<String, html.File>();

  static String getLocalFileIdentifier(html.File file) {
    final identifier = Uuid().v4() + '/' + file.name;
    _files[identifier] = file;
    return identifier;
  }

  static html.File getLocalFileByIdentifier(String identifier) {
    return _files[identifier];
  }

  Future<dynamic> onMethodCall(MethodCall call) {
    try {
      switch (call.method) {
        case "getData":
          return _getData(call.arguments['path']);
          break;
        default:
          throw PlatformException(
              code: 'Unimplemented',
              details:
              "The shared_preferences plugin for web doesn't implement "
                  "the method '${call.method}'");
          break;
      }
    } catch (e, stackTrace) {
      throw PlatformException(
          code: "PlatformError",
          message: e.toString(),
          details: stackTrace.toString());
    }
  }

  Future<Uint8List> _getData(String fileIdentifier) {
    final file = _files[fileIdentifier];
    final completer = Completer<Uint8List>();

    html.FileReader reader = html.FileReader();
    reader.onLoad.listen((fileEvent) {
      completer.complete(reader.result);
    });
    reader.onError.listen((error) {
      // Handle the error
      completer.complete(null);
    });
    reader.readAsArrayBuffer(file);
    return completer.future;
  }




}
