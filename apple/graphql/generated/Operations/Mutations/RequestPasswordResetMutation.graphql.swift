// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct RequestPasswordResetMutation: GraphQLMutation {
    static let operationName: String = "RequestPasswordReset"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation RequestPasswordReset($email: String!) { requestPasswordReset(email: $email) }"#
      ))

    public var email: String

    public init(email: String) {
      self.email = email
    }

    @_spi(Unsafe) public var __variables: Variables? { ["email": email] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("requestPasswordReset", String.self, arguments: ["email": .variable("email")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        RequestPasswordResetMutation.Data.self
      ] }

      var requestPasswordReset: String { __data["requestPasswordReset"] }

      init(
        requestPasswordReset: String
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "requestPasswordReset": requestPasswordReset,
        ])
      }
    }
  }

}