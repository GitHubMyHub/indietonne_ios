// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct ResendVerificationEmailMutation: GraphQLMutation {
    static let operationName: String = "ResendVerificationEmail"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation ResendVerificationEmail($email: String!) { resendVerificationEmail(email: $email) }"#
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
        .field("resendVerificationEmail", String.self, arguments: ["email": .variable("email")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        ResendVerificationEmailMutation.Data.self
      ] }

      var resendVerificationEmail: String { __data["resendVerificationEmail"] }

      init(
        resendVerificationEmail: String
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "resendVerificationEmail": resendVerificationEmail,
        ])
      }
    }
  }

}