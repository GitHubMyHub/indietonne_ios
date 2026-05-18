// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct FindStreetsQuery: GraphQLQuery {
    static let operationName: String = "FindStreets"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query FindStreets($pagination: PaginationInput!, $search: String!) { findStreets(pagination: $pagination, search: $search) { __typename content { __typename id name } } }"#
      ))

    public var pagination: PaginationInput
    public var search: String

    public init(
      pagination: PaginationInput,
      search: String
    ) {
      self.pagination = pagination
      self.search = search
    }

    @_spi(Unsafe) public var __variables: Variables? { [
      "pagination": pagination,
      "search": search
    ] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("findStreets", FindStreets.self, arguments: [
          "pagination": .variable("pagination"),
          "search": .variable("search")
        ]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        FindStreetsQuery.Data.self
      ] }

      var findStreets: FindStreets { __data["findStreets"] }

      init(
        findStreets: FindStreets
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "findStreets": findStreets._fieldData,
        ])
      }

      /// FindStreets
      ///
      /// Parent Type: `StreetPaginated`
      nonisolated struct FindStreets: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.StreetPaginated }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("content", [Content].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          FindStreetsQuery.Data.FindStreets.self
        ] }

        var content: [Content] { __data["content"] }

        init(
          content: [Content]
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.StreetPaginated.typename,
            "content": content._fieldData,
          ])
        }

        /// FindStreets.Content
        ///
        /// Parent Type: `Street`
        nonisolated struct Content: InDieTonneAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Street }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", InDieTonneAPI.UUID.self),
            .field("name", String.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            FindStreetsQuery.Data.FindStreets.Content.self
          ] }

          var id: InDieTonneAPI.UUID { __data["id"] }
          var name: String { __data["name"] }

          init(
            id: InDieTonneAPI.UUID,
            name: String
          ) {
            self.init(unsafelyWithData: [
              "__typename": InDieTonneAPI.Objects.Street.typename,
              "id": id,
              "name": name,
            ])
          }
        }
      }
    }
  }

}