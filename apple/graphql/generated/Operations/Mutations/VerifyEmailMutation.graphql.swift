// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct VerifyEmailMutation: GraphQLMutation {
    static let operationName: String = "VerifyEmail"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation VerifyEmail($token: String!) { verifyEmail(token: $token) }"#
      ))

    public var token: String

    public init(token: String) {
      self.token = token
    }

    @_spi(Unsafe) public var __variables: Variables? { ["token": token] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("verifyEmail", String.self, arguments: ["token": .variable("token")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        VerifyEmailMutation.Data.self
      ] }

      var verifyEmail: String { __data["verifyEmail"] }

      init(
        verifyEmail: String
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "verifyEmail": verifyEmail,
        ])
      }
    }
  }

}