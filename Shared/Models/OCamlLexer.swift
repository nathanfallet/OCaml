/*
*  Copyright (C) 2021 Groupe MINASTE
*
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along
* with this program; if not, write to the Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
*
*/

import Foundation
import Sourceful

class OCamlLexer: SourceCodeRegexLexer {

    public init() {}

    lazy var generators: [TokenGenerator] = {
        var generators = [TokenGenerator?]()

        let keywords = [
            "and",
            "as",
            "assert",
            "asr",
            "begin",
            "class",
            "constraint",
            "do",
            "done",
            "downto",
            "else",
            "end",
            "exception",
            "external",
            "for",
            "fun",
            "function",
            "functor",
            "if",
            "in",
            "include",
            "inherit!",
            "inherit",
            "initializer",
            "land",
            "lazy",
            "let",
            "lor",
            "lsl",
            "lsr",
            "lxor",
            "match",
            "method!",
            "method",
            "mod",
            "module",
            "mutable",
            "new",
            "object",
            "of",
            "open!",
            "open",
            "or",
            "private",
            "rec",
            "sig",
            "struct",
            "then",
            "to",
            "try",
            "type",
            "val!",
            "val",
            "virtual",
            "when",
            "while",
            "with",
            "parser",
            "value"
        ]
        generators.append(keywordGenerator(keywords, tokenType: .keyword))

        // Modules and variants
        generators.append(regexGenerator("\\b[A-Z$_][0-9a-zA-Z$_]*\\b", tokenType: .identifier))

        // Numbers
        // https://github.com/highlightjs/highlight.js/blob/master/src/languages/reasonml.js#L43
        generators.append(regexGenerator("\\b(0[xX][a-fA-F0-9_]+[Lln]?|0[oO][0-7_]+[Lln]?|0[bB][01_]+[Lln]?|[0-9][0-9_]*([Lln]|(\\.[0-9_]*)?([eE][-+]?[0-9_]+)?)?)", tokenType: .number))

        // Booleans
        let booleans = "true false".components(separatedBy: " ")
        generators.append(keywordGenerator(booleans, tokenType: .keyword))

        // Block comment
        generators.append(regexGenerator("(\\(\\*)(.*?)(\\*\\))", options: [.dotMatchesLineSeparators], tokenType: .comment))

        // Single-line string literal
        generators.append(regexGenerator("\"(\\\\\"|[^\"\\n])*\"", tokenType: .string))

        return generators.compactMap { $0 }
    }()

    public func generators(source: String) -> [TokenGenerator] {
        return generators
    }

}
