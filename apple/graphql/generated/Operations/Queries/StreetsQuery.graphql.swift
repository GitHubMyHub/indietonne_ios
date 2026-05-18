// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct StreetsQuery: GraphQLQuery {
    static let operationName: String = "Streets"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Streets($pagination: PaginationInput!, $filter: StreetFiler!) { streets(pagination: $pagination, filter: $filter) { __typename number size totalElements totalPages content { __typename id name } } }"#
      ))

    public var pagination: PaginationInput
    public var filter: StreetFiler

    public init(
      pagination: PaginationInput,
      filter: StreetFiler
    ) {
      self.pagination = pagination
      self.filter = filter
    }

    @_spi(Unsafe) public var __variables: Variables? { [
      "pagination": pagination,
      "filter": filter
    ] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("streets", Streets.self, arguments: [
          "pagination": .variable("pagination"),
          "filter": .variable("filter")
        ]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        StreetsQuery.Data.self
      ] }

      var streets: Streets { __data["streets"] }

      init(
        streets: Streets
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "streets": streets._fieldData,
        ])
      }

      /// Streets
      ///
      /// Parent Type: `StreetPaginated`
      nonisolated struct Streets: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.StreetPaginated }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("number", Int?.self),
          .field("size", Int?.self),
          .field("totalElements", Int?.self),
          .field("totalPages", Int?.self),
          .field("content", [Content].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          StreetsQuery.Data.Streets.self
        ] }

        var number: Int? { __data["number"] }
        var size: Int? { __data["size"] }
        var totalElements: Int? { __data["totalElements"] }
        var totalPages: Int? { __data["totalPages"] }
        var content: [Content] { __data["content"] }

        init(
          number: Int? = nil,
          size: Int? = nil,
          totalElements: Int? = nil,
          totalPages: Int? = nil,
          content: [Content]
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.StreetPaginated.typename,
            "number": number,
            "size": size,
            "totalElements": totalElements,
            "totalPages": totalPages,
            "content": content._fieldData,
          ])
        }

        /// Streets.Content
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
            StreetsQuery.Data.Streets.Content.self
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