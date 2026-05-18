//
//  ApolloClientProvider.swift
//  apple
//
//  Erstellt zwei ApolloClients (unauthentifiziert + authentifiziert).
//  Äquivalent zu Android `AppModule` + `AppModuleAuthenticated`.
//
//  ⚠️ Voraussetzung: Das SPM-Paket `apollo-ios` muss in Xcode hinzugefügt sein
//     (https://github.com/apollographql/apollo-ios).
//     Solange das Paket nicht eingebunden ist, ist diese Datei in einem
//     `#if canImport(Apollo)` Block geschützt und führt nicht zu Build-Fehlern.
//

import Foundation

#if canImport(Apollo) && canImport(ApolloAPI)
import Apollo
import ApolloAPI

/// Liefert Apollo-Clients für authentifizierte und unauthentifizierte Requests.
final class ApolloClientProvider {
    private let tokenStore: TokenStore
    private let serverURL: URL

    init(tokenStore: TokenStore, serverURL: URL = Constants.baseURL) {
        self.tokenStore = tokenStore
        self.serverURL = serverURL
    }

    /// Unauthentifizierter Client – für Login/Register/Password-Reset/Verify.
    lazy var unauthenticated: ApolloClient = {
        let store = ApolloStore()
        let client = URLSessionClient()
        let provider = DefaultInterceptorProvider(client: client, store: store)
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: serverURL
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()

    /// Authentifizierter Client – Bearer-Token wird automatisch injiziert.
    lazy var authenticated: ApolloClient = {
        let store = ApolloStore()
        let client = URLSessionClient()
        let provider = AuthenticatedInterceptorProvider(
            client: client,
            store: store,
            tokenStore: tokenStore
        )
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: serverURL
        )
        return ApolloClient(networkTransport: transport, store: store)
    }()
}

// MARK: - Bearer-Token Interceptor

private final class AuthorizationInterceptor: ApolloInterceptor {
    var id: String = UUID().uuidString
    private let tokenStore: TokenStore

    init(tokenStore: TokenStore) {
        self.tokenStore = tokenStore
    }

    func interceptAsync<Operation: GraphQLOperation>(
        chain: any RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, any Error>) -> Void
    ) {
        Task { @MainActor in
            if let token = tokenStore.token, !token.isEmpty {
                request.addHeader(name: "Authorization", value: "Bearer \(token)")
            }
            chain.proceedAsync(
                request: request,
                response: response,
                interceptor: self,
                completion: completion
            )
        }
    }
}

private final class AuthenticatedInterceptorProvider: DefaultInterceptorProvider {
    private let tokenStore: TokenStore

    init(client: URLSessionClient, store: ApolloStore, tokenStore: TokenStore) {
        self.tokenStore = tokenStore
        super.init(client: client, store: store)
    }

    override func interceptors<Operation: GraphQLOperation>(
        for operation: Operation
    ) -> [any ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(AuthorizationInterceptor(tokenStore: tokenStore), at: 0)
        return interceptors
    }
}

#else

/// Stub-Implementation solange das Apollo-SPM-Paket nicht eingebunden ist.
/// Sobald `apollo-ios` als Dependency verfügbar ist, wird der echte Provider
/// (oben im `#if canImport(Apollo)` Block) verwendet.
final class ApolloClientProvider {
    init(tokenStore: TokenStore, serverURL: URL = Constants.baseURL) {
        // Intentionally empty
    }
}

#endif
