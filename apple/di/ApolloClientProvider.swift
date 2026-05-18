//
//  ApolloClientProvider.swift
//  apple
//
//  Erstellt zwei ApolloClients (unauthentifiziert + authentifiziert).
//  Apollo iOS 2.x API.
//

import Foundation
import Apollo
import ApolloAPI

/// Thread-safe token holder – nonisolated bridge from @MainActor TokenStore.
final class TokenBox: @unchecked Sendable {
    private var _token: String?
    private let lock = NSLock()

    var token: String? {
        get { lock.withLock { _token } }
        set { lock.withLock { _token = newValue } }
    }
}

/// Liefert Apollo-Clients für authentifizierte und unauthentifizierte Requests.
final class ApolloClientProvider {
    private let tokenStore: TokenStore
    private let serverURL: URL
    let tokenBox = TokenBox()

    init(tokenStore: TokenStore, serverURL: URL = Constants.baseURL) {
        self.tokenStore = tokenStore
        self.serverURL = serverURL
        #if DEBUG
        print("[Apollo] endpoint = \(serverURL.absoluteString)")
        #endif
    }

    /// Unauthentifizierter Client – für Login/Register/Password-Reset/Verify.
    lazy var unauthenticated: ApolloClient = {
        let store = ApolloStore()
        let transport = RequestChainNetworkTransport(
            urlSession: URLSession.shared,
            interceptorProvider: DefaultInterceptorProvider.shared,
            store: store,
            endpointURL: serverURL
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()

    /// Authentifizierter Client – Bearer-Token wird automatisch injiziert.
    lazy var authenticated: ApolloClient = {
        let store = ApolloStore()
        let box = tokenBox
        let provider = AuthenticatedInterceptorProvider(tokenBox: box)
        let transport = RequestChainNetworkTransport(
            urlSession: URLSession.shared,
            interceptorProvider: provider,
            store: store,
            endpointURL: serverURL
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()

    /// Must be called from @MainActor when the token changes.
    @MainActor
    func syncToken() {
        tokenBox.token = tokenStore.token
    }
}

// MARK: - Bearer-Token Interceptor (Apollo 2.x GraphQLInterceptor)

private struct AuthorizationInterceptor: GraphQLInterceptor {
    let tokenBox: TokenBox

    func intercept<Request: GraphQLRequest>(
        request: Request,
        next: NextInterceptorFunction<Request>
    ) async throws -> InterceptorResultStream<Request> {
        var mutableRequest = request
        if let token = tokenBox.token, !token.isEmpty {
            mutableRequest.additionalHeaders["Authorization"] = "Bearer \(token)"
        }
        return await next(mutableRequest)
    }
}

private final class AuthenticatedInterceptorProvider: InterceptorProvider, Sendable {
    private let tokenBox: TokenBox

    init(tokenBox: TokenBox) {
        self.tokenBox = tokenBox
    }

    func graphQLInterceptors<Operation: GraphQLOperation>(
        for operation: Operation
    ) -> [any GraphQLInterceptor] {
        [AuthorizationInterceptor(tokenBox: tokenBox)] +
        DefaultInterceptorProvider.shared.graphQLInterceptors(for: operation)
    }
}
