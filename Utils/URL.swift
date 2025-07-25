//
//  URL.swift
//  ReduceProjectSize
//
//  Created by Home on 29/01/25.
//

import UniformTypeIdentifiers
#if os(macOS)
import AppKit
#endif
//extension String {
//    static let imageset = "imageset"
//    static let appiconset = "appiconset"
//    static let xcassets = "xcassets"
//
//    // TODO: - for future
////    static let sidebariconset = "sidebariconset"
////    static let imagestack = "imagestack"
//}

extension URL {
#if os(macOS)
    func showInFinder() {
        NSWorkspace.shared.activateFileViewerSelecting([self])
    }
#endif
    
    func fileExists()-> Bool {
        return FileManager.default.fileExists(atPath: self.path(percentEncoded: false))
    }
    
    // MARK: - Get Child of directory
    func subDirectories() throws -> [URL] {
        return try children(predicate: \.hasDirectoryPath)
    }
    
    func childFiles() throws -> [URL] {
        return try children(predicate: \.isFileURL)
    }
    
    func children(
        options mask: FileManager.DirectoryEnumerationOptions? = nil,
        predicate: ((URL) -> Bool)? = nil
    ) throws -> [URL] {
        let options = mask ?? fileEnumerationOptions
        let children = try FileManager.default.contentsOfDirectory(at: self, includingPropertiesForKeys: nil, options: options)
        
        return predicate.map { children.filter($0) } ?? children
    }
    
    var memorySpace: Int64 {
        let attrs = try? FileManager.default.attributesOfItem(atPath: self.path(percentEncoded: false))
        return attrs?[.size] as? Int64 ?? 0
    }

    // MARK: - filetype checks
    var fileType: UTType? {
        try? self.resourceValues(forKeys: [.contentTypeKey]).contentType
    }
    
    func conformsTo(type: UTType)-> Bool {
         fileType?.conforms(to: type) ?? false
    }
    
    func conformsAny(_ types: [UTType])-> Bool {
        fileType.map { fileType in
            types.contains(where: { fileType.conforms(to: $0) })
        } ?? false
    }
}


private extension URL {
    var fileEnumerationOptions: FileManager.DirectoryEnumerationOptions {
        var options: FileManager.DirectoryEnumerationOptions = []
        if !Settings.shared.showHiddenFiles {
            options.insert(.skipsHiddenFiles)
        }
        
        if !Settings.shared.showPackageContent {
            options.insert(.skipsPackageDescendants)
        }
        
        return options
    }
}

//@available(iOS 17.0, *)
//@Observable
final class Settings: Codable {
    var showHiddenFiles: Bool = false
    var showPackageContent: Bool = false
    
    static let shared: Settings = (try? UserDefaults.standard[UserDefaultsKeys(rawValue: "key")]) ?? Settings()
    private init() {}
}
