// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct SignInQuery: GraphQLQuery {
    static let operationName: String = "SignIn"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query SignIn($loginUser: LoginInput!) { signIn(loginUser: $loginUser) }"#
      ))

    public var loginUser: LoginInput

    public init(loginUser: LoginInput) {
      self.loginUser = loginUser
    }

    @_spi(Unsafe) public var __variables: Variables? { ["loginUser": loginUser] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("signIn", String.self, arguments: ["loginUser": .variable("loginUser")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        SignInQuery.Data.self
      ] }

      var signIn: String { __data["signIn"] }

      init(
        signIn: String
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "signIn": signIn,
        ])
      }
    }
  }

}