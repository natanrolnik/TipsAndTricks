import Foundation
import Ink

let fileManager = FileManager.default
let root = fileManager.currentDirectoryPath

func generate() throws {
    let indexPath = root.appending("/Index.md")
    let markdownData = try Data(contentsOf: URL(fileURLWithPath: indexPath))
    let templateData = try Data(contentsOf: URL(fileURLWithPath: root.appending("/IndexTemplate.html")))

    guard
        let indexMarkdown = String(data: markdownData, encoding: .utf8),
        let template = String(data: templateData, encoding: .utf8) else {
        print("Couldn't read markdown or template files")
        return
    }

    var toHTML = MarkdownParser().parse(indexMarkdown).html

    charactersMapping.forEach { key, value in
        toHTML = toHTML.replacingOccurrences(of: key, with: value)
    }

    let output = root.appending("/Build")
    if fileManager.fileExists(atPath: output) {
        try fileManager.removeItem(atPath: output)
    }

    try fileManager.createDirectory(atPath: output,
                                    withIntermediateDirectories: true,
                                    attributes: [:])

    let finalHtml = template.replacingOccurrences(of: "{{body}}", with: toHTML)
    try finalHtml.write(toFile: output.appending("/Index.html"), atomically: true, encoding: .utf8)
    try fileManager.copyItem(atPath: root.appending("/styles.css"), toPath: output.appending("/styles.css"))
    try fileManager.copyItem(atPath: root.appending("/img"), toPath: output.appending("/img"))
}

do {
    try generate()
} catch {
    print("Error: \(error)")
}

//css
//header
//images
