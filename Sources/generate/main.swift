import Foundation
import Ink

let root = FileManager.default.currentDirectoryPath

func generate() throws {
    let indexPath = root.appending("/Index.md")
    let data = try Data(contentsOf: URL(fileURLWithPath: indexPath))

    guard let contents = String(data: data, encoding: .utf8) else {
        print("Couldn't read ")
        return
    }

    var toHTML = MarkdownParser().parse(contents).html

    charactersMapping.forEach { key, value in
        toHTML = toHTML.replacingOccurrences(of: key, with: value)
    }

    let output = root.appending("/Build")
    if FileManager.default.fileExists(atPath: output) {
        try FileManager.default.removeItem(atPath: output)
    }

    try FileManager.default.createDirectory(atPath: output, withIntermediateDirectories: true, attributes: [:])

    try toHTML.write(toFile: output.appending("/Index.html"), atomically: true, encoding: .utf8)
}

do {
    try generate()
} catch {
    print("Error: \(error)")
}

//css
//header
//images
