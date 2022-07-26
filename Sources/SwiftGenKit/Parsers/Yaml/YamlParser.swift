//
// SwiftGenKit
// Copyright © 2020 SwiftGen
// MIT Licence
//

import Foundation
import PathKit
import Yams

public enum Yaml {
  public enum ParserError: Error, CustomStringConvertible {
    case invalidFile(path: Path, reason: String)

    public var description: String {
      switch self {
      case .invalidFile(let path, let reason):
        return "Unable to parse file at \(path). \(reason)"
      }
    }
  }

  // MARK: Yaml File Parser

  public final class Parser: SwiftGenKit.Parser {
    private let options: ParserOptionValues
    var files: [File] = []
    public var warningHandler: Parser.MessageHandler?

    public required init(options: [String: Any] = [:], warningHandler: Parser.MessageHandler? = nil) throws {
      self.options = try ParserOptionValues(options: options, available: Self.allOptions)
      self.warningHandler = warningHandler
    }

    public static let defaultFilter = filterRegex(forExtensions: ["yaml", "yml"])

    public func parse(path: Path, relativeTo parent: Path) throws {
      files.append(try File(path: path, relativeTo: parent))
    }
  }
}
