// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct DeletePlatformUserPlacesMutation: GraphQLMutation {
    static let operationName: String = "DeletePlatformUserPlaces"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation DeletePlatformUserPlaces($platformUserPlaceIds: [UUID!]!) { deletePlatformUserPlaces(platformUserPlaceIds: $platformUserPlaceIds) { __typename id } }"#
      ))

    public var platformUserPlaceIds: [UUID]

    public init(platformUserPlaceIds: [UUID]) {
      self.platformUserPlaceIds = platformUserPlaceIds
    }

    @_spi(Unsafe) public var __variables: Variables? { ["platformUserPlaceIds": platformUserPlaceIds] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("deletePlatformUserPlaces", [DeletePlatformUserPlace].self, arguments: ["platformUserPlaceIds": .variable("platformUserPlaceIds")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        DeletePlatformUserPlacesMutation.Data.self
      ] }

      var deletePlatformUserPlaces: [DeletePlatformUserPlace] { __data["deletePlatformUserPlaces"] }

      init(
        deletePlatformUserPlaces: [DeletePlatformUserPlace]
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "deletePlatformUserPlaces": deletePlatformUserPlaces._fieldData,
        ])
      }

      /// DeletePlatformUserPlace
      ///
      /// Parent Type: `PlatformUserPlace`
      nonisolated struct DeletePlatformUserPlace: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.PlatformUserPlace }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", InDieTonneAPI.UUID.self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          DeletePlatformUserPlacesMutation.Data.DeletePlatformUserPlace.self
        ] }

        var id: InDieTonneAPI.UUID { __data["id"] }

        init(
          id: InDieTonneAPI.UUID
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.PlatformUserPlace.typename,
            "id": id,
          ])
        }
      }
    }
  }

}