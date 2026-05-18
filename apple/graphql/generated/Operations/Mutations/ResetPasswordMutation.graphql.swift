// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct ResetPasswordMutation: GraphQLMutation {
    static let operationName: String = "ResetPassword"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation ResetPassword($input: ResetPasswordInput!) { resetPassword(input: $input) }"#
      ))

    public var input: ResetPasswordInput

    public init(input: ResetPasswordInput) {
      self.input = input
    }

    @_spi(Unsafe) public var __variables: Variables? { ["input": input] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("resetPassword", String.self, arguments: ["input": .variable("input")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        ResetPasswordMutation.Data.self
      ] }

      var resetPassword: String { __data["resetPassword"] }

      init(
        resetPassword: String
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "resetPassword": resetPassword,
        ])
      }
    }
  }

}