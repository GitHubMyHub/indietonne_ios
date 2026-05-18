//
//  Scalars.swift
//  apple
//
//  Custom Scalar Adapter für Apollo iOS.
//  Äquivalent zu Android `data/repository/Scalars.kt`.
//

import Foundation

#if canImport(ApolloAPI)
import ApolloAPI

// Apollo-Codegen erzeugt Aliase wie `UUID` und `Instant` für Custom Scalars.
// Hier können bei Bedarf eigene Decoder-Logik via `JSONDecodable` oder
// `OutputTypeConvertible` ergänzt werden.

extension Foundation.UUID: @retroactive JSONDecodable, @retroactive JSONEncodable {
    public init(_jsonValue value: AnyHashable) throws {
        guard let str = value as? String, let uuid = Foundation.UUID(uuidString: str) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Foundation.UUID.self)
        }
        self = uuid
    }

    public var _jsonValue: any Hashable { self.uuidString }
}

#endif
