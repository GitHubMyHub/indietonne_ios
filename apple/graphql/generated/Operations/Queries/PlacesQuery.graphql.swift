// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct PlacesQuery: GraphQLQuery {
    static let operationName: String = "Places"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Places($pagination: PaginationInput!) { places(pagination: $pagination) { __typename number size totalElements totalPages content { __typename id name zipCodes images { __typename storedName origin } fractions { __typename id name icon } } } }"#
      ))

    public var pagination: PaginationInput

    public init(pagination: PaginationInput) {
      self.pagination = pagination
    }

    @_spi(Unsafe) public var __variables: Variables? { ["pagination": pagination] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("places", Places.self, arguments: ["pagination": .variable("pagination")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        PlacesQuery.Data.self
      ] }

      var places: Places { __data["places"] }

      init(
        places: Places
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "places": places._fieldData,
        ])
      }

      /// Places
      ///
      /// Parent Type: `PlacePaginated`
      nonisolated struct Places: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.PlacePaginated }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("number", Int?.self),
          .field("size", Int?.self),
          .field("totalElements", Int?.self),
          .field("totalPages", Int?.self),
          .field("content", [Content].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          PlacesQuery.Data.Places.self
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
            "__typename": InDieTonneAPI.Objects.PlacePaginated.typename,
            "number": number,
            "size": size,
            "totalElements": totalElements,
            "totalPages": totalPages,
            "content": content._fieldData,
          ])
        }

        /// Places.Content
        ///
        /// Parent Type: `Place`
        nonisolated struct Content: InDieTonneAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Place }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", InDieTonneAPI.UUID.self),
            .field("name", String.self),
            .field("zipCodes", [String].self),
            .field("images", [Image].self),
            .field("fractions", [Fraction].self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            PlacesQuery.Data.Places.Content.self
          ] }

          var id: InDieTonneAPI.UUID { __data["id"] }
          var name: String { __data["name"] }
          var zipCodes: [String] { __data["zipCodes"] }
          var images: [Image] { __data["images"] }
          var fractions: [Fraction] { __data["fractions"] }

          init(
            id: InDieTonneAPI.UUID,
            name: String,
            zipCodes: [String],
            images: [Image],
            fractions: [Fraction]
          ) {
            self.init(unsafelyWithData: [
              "__typename": InDieTonneAPI.Objects.Place.typename,
              "id": id,
              "name": name,
              "zipCodes": zipCodes,
              "images": images._fieldData,
              "fractions": fractions._fieldData,
            ])
          }

          /// Places.Content.Image
          ///
          /// Parent Type: `ImageMetaData`
          nonisolated struct Image: InDieTonneAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.ImageMetaData }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("storedName", String?.self),
              .field("origin", GraphQLEnum<InDieTonneAPI.Origin>.self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              PlacesQuery.Data.Places.Content.Image.self
            ] }

            var storedName: String? { __data["storedName"] }
            var origin: GraphQLEnum<InDieTonneAPI.Origin> { __data["origin"] }

            init(
              storedName: String? = nil,
              origin: GraphQLEnum<InDieTonneAPI.Origin>
            ) {
              self.init(unsafelyWithData: [
                "__typename": InDieTonneAPI.Objects.ImageMetaData.typename,
                "storedName": storedName,
                "origin": origin,
              ])
            }
          }

          /// Places.Content.Fraction
          ///
          /// Parent Type: `Fraction`
          nonisolated struct Fraction: InDieTonneAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Fraction }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", InDieTonneAPI.UUID.self),
              .field("name", String.self),
              .field("icon", String.self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              PlacesQuery.Data.Places.Content.Fraction.self
            ] }

            var id: InDieTonneAPI.UUID { __data["id"] }
            var name: String { __data["name"] }
            var icon: String { __data["icon"] }

            init(
              id: InDieTonneAPI.UUID,
              name: String,
              icon: String
            ) {
              self.init(unsafelyWithData: [
                "__typename": InDieTonneAPI.Objects.Fraction.typename,
                "id": id,
                "name": name,
                "icon": icon,
              ])
            }
          }
        }
      }
    }
  }

}