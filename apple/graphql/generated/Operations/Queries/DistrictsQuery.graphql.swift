// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct DistrictsQuery: GraphQLQuery {
    static let operationName: String = "Districts"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Districts($pagination: PaginationInput!, $placeId: String) { districts(pagination: $pagination, placeId: $placeId) { __typename content { __typename id name } } }"#
      ))

    public var pagination: PaginationInput
    public var placeId: GraphQLNullable<String>

    public init(
      pagination: PaginationInput,
      placeId: GraphQLNullable<String>
    ) {
      self.pagination = pagination
      self.placeId = placeId
    }

    @_spi(Unsafe) public var __variables: Variables? { [
      "pagination": pagination,
      "placeId": placeId
    ] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("districts", Districts.self, arguments: [
          "pagination": .variable("pagination"),
          "placeId": .variable("placeId")
        ]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        DistrictsQuery.Data.self
      ] }

      var districts: Districts { __data["districts"] }

      init(
        districts: Districts
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "districts": districts._fieldData,
        ])
      }

      /// Districts
      ///
      /// Parent Type: `DistrictPaginated`
      nonisolated struct Districts: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.DistrictPaginated }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("content", [Content].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          DistrictsQuery.Data.Districts.self
        ] }

        var content: [Content] { __data["content"] }

        init(
          content: [Content]
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.DistrictPaginated.typename,
            "content": content._fieldData,
          ])
        }

        /// Districts.Content
        ///
        /// Parent Type: `District`
        nonisolated struct Content: InDieTonneAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.District }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", InDieTonneAPI.UUID.self),
            .field("name", String?.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            DistrictsQuery.Data.Districts.Content.self
          ] }

          var id: InDieTonneAPI.UUID { __data["id"] }
          var name: String? { __data["name"] }

          init(
            id: InDieTonneAPI.UUID,
            name: String? = nil
          ) {
            self.init(unsafelyWithData: [
              "__typename": InDieTonneAPI.Objects.District.typename,
              "id": id,
              "name": name,
            ])
          }
        }
      }
    }
  }

}