// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct SignUpMutation: GraphQLMutation {
    static let operationName: String = "SignUp"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation SignUp($loginUser: SignUpInput!) { signUp(loginUser: $loginUser) }"#
      ))

    public var loginUser: SignUpInput

    public init(loginUser: SignUpInput) {
      self.loginUser = loginUser
    }

    @_spi(Unsafe) public var __variables: Variables? { ["loginUser": loginUser] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("signUp", String.self, arguments: ["loginUser": .variable("loginUser")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        SignUpMutation.Data.self
      ] }

      var signUp: String { __data["signUp"] }

      init(
        signUp: String
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "signUp": signUp,
        ])
      }
    }
  }

}