#!/usr/bin/swift

import Foundation

let destinationDirectory = "wallpapers/"

struct iDevice {
    let name: String
    let resolution: (height: Int, width: Int)
    let firstIOSVersion: Double
    let lastIOSVersion: Double

    func isCompatible(version: Double) -> Bool{
        return firstIOSVersion <= version && lastIOSVersion >= version
    }
}

func shell(args: String...) -> Int32 {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = args
    process.launch()
    process.waitUntilExit()
    return process.terminationStatus
}


let iosVersions = [
    7, 7.01, 7.02, 7.03, 7.04, 7.05, 7.10, 7.11, 7.12,
    8.00, 8.01, 8.02, 8.10, 8.11, 8.12, 8.13, 8.20, 8.30, 8.40, 8.41,
    9.00, 9.01, 9.02, 9.10, 9.20, 9.21, 9.30, 9.31, 9.32, 9.33, 9.34, 9.35,
    10.00, 10.01, 10.02
]

let iDevices = [
    iDevice(name: "iPhone 4", resolution: (960, 640), firstIOSVersion: 7.00, lastIOSVersion: 8.41),
    iDevice(name: "iPhone 4S", resolution: (960,640), firstIOSVersion: 7.00, lastIOSVersion: 9.35),
    iDevice(name: "iPhone 5", resolution: (1136, 640), firstIOSVersion: 7.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 5S", resolution: (1136, 640), firstIOSVersion: 7.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 6", resolution: (1334, 750), firstIOSVersion: 8.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 6+", resolution: (1920, 1080), firstIOSVersion: 8.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 6S", resolution: (1334, 750), firstIOSVersion: 9.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 6S+", resolution: (1920, 1080), firstIOSVersion: 9.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 7", resolution: (1334, 750), firstIOSVersion: 10.00, lastIOSVersion: 10.02),
    iDevice(name: "iPhone 7+", resolution: (1920, 1080), firstIOSVersion: 10.00, lastIOSVersion: 10.02),
    iDevice(name: "iPad Mini 4", resolution: (2048, 1536), firstIOSVersion: 9.00, lastIOSVersion: 10.02),
    iDevice(name: "iPad Pro 9.7", resolution: (2048, 1536), firstIOSVersion: 9.3, lastIOSVersion: 10.02)
]

for iDevice in iDevices {
    for iosVersion in iosVersions {
        if iDevice.isCompatible(version: iosVersion) {
            if let configuration = String(iDevice.name + " - iOS " + String(iosVersion)) {
                let wallpaperURL = "https://dummyimage.com/\(iDevice.resolution.width)x\(iDevice.resolution.height)&text=\(configuration)".replacingOccurrences(of: " ", with: "+")
                let outputFile = configuration + ".png"
                _ = shell(args: "curl", "-o", destinationDirectory + outputFile, wallpaperURL)
            }
        }
    }
}

_ = shell(args: "./index_generator.sh")

