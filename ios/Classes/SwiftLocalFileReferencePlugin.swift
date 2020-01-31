import Flutter
import UIKit

public class SwiftLocalFileReferencePlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.buntagon/local_file_reference", binaryMessenger: registrar.messenger())
        let instance = SwiftLocalFileReferencePlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch (call.method) {
            case "getData":
                let arguments = call.arguments as! Dictionary<String, AnyObject>
                let filePath = arguments["path"] as! String
                if let data = NSData(contentsOfFile: filePath) {
                    var flutterResult = FlutterStandardTypedData.init(bytes: data as Data)
                    result(flutterResult)
                } else {
                    result(FlutterError(code: "FILE_READ_ERROR", message: "The file data could not be read.", details: nil))
                }
                break;
            default:
                result(FlutterMethodNotImplemented)
        }
    }
}
