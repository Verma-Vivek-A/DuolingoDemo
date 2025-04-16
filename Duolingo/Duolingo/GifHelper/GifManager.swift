//
//  GifManager.swift
//  Duolingo
//
//  Created by PC on 07/01/25.
//

import SwiftUI
import Photos

class GifManager {
    
    static let defaultDuration: Double = 0.03

    static func gif(url: URL) -> ([CGImage], [Double]) {
        guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else { return ([], []) }
        
        let frameCount = CGImageSourceGetCount(source)
        var frames: [CGImage] = []
        var durations: [Double] = []
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }
            
            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil),
               let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
               let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) {
                durations.append(frameDuration.doubleValue)
            } else {
                durations.append(self.defaultDuration)
            }

            frames.append(cgImage)
        }
        
        return (frames, durations)
    }
    
    static func gif(data: Data) -> ([CGImage], [Double]) {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return ([], []) }
        
        let frameCount = CGImageSourceGetCount(source)
        var frames: [CGImage] = []
        var durations: [Double] = []
        
        for i in 0..<frameCount {
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else { continue }

            if let properties = CGImageSourceCopyPropertiesAtIndex(source, i, nil),
               let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary as String] as? NSDictionary,
               let frameDuration = (gifInfo[kCGImagePropertyGIFDelayTime as String] as? NSNumber) {
                durations.append(frameDuration.doubleValue)
            } else {
                durations.append(defaultDuration)
            }

            frames.append(cgImage)
        }
        
        return (frames, durations)
    }
    
    static func saveGif(_ cgImages: [CGImage], durations: [Double]) async {
        guard
            let directoryPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            print("Cannot access local file domain")
            return
        }

        let fileName = "gif_temp"
        let filePath = directoryPath
            .appendingPathComponent(fileName)
            .appendingPathExtension("gif")
        
        if FileManager.default.fileExists(atPath: filePath.absoluteString) {
            try? FileManager.default.removeItem(at: filePath)
        }

        guard let destination = CGImageDestinationCreateWithURL(filePath as CFURL, UTType.gif.identifier as CFString, cgImages.count, nil) else {
            print("not able to create a destination")
            return
        }
        for i in 0..<cgImages.count {
            let cgImage = cgImages[i]
            let duration = durations[i]
            let options: CFDictionary = [kCGImagePropertyGIFDictionary: [kCGImagePropertyGIFDelayTime : duration]] as CFDictionary
            CGImageDestinationAddImage(destination, cgImage, options)

        }
        
        let writeResult = CGImageDestinationFinalize(destination)
        if !writeResult {
            print("error finalizing destination")
            return
        }
        
        do {
            try await PHPhotoLibrary.shared().performChanges {
                let request = PHAssetCreationRequest.forAsset()
                request.addResource(with: .photo, fileURL: filePath, options: nil)
            }
            try FileManager.default.removeItem(at: filePath)
        } catch (let error) {
            print("Failed to create asset: \(error.localizedDescription)")
        }
    }
   
}
