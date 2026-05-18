// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct PlaceDetailsQuery: GraphQLQuery {
    static let operationName: String = "PlaceDetails"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query PlaceDetails($placeId: UUID!) { place(placeId: $placeId) { __typename id name zipCodes images { __typename storedName origin } fractions { __typename id name icon } } }"#
      ))

    public var placeId: UUID

    public init(placeId: UUID) {
      self.placeId = placeId
    }

    @_spi(Unsafe) public var __variables: Variables? { ["placeId": placeId] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("place", Place.self, arguments: ["placeId": .variable("placeId")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        PlaceDetailsQuery.Data.self
      ] }

      var place: Place { __data["place"] }

      init(
        place: Place
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "place": place._fieldData,
        ])
      }

      /// Place
      ///
      /// Parent Type: `Place`
      nonisolated struct Place: InDieTonneAPI.SelectionSet {
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
          PlaceDetailsQuery.Data.Place.self
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

        /// Place.Image
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
            PlaceDetailsQuery.Data.Place.Image.self
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

        /// Place.Fraction
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
            PlaceDetailsQuery.Data.Place.Fraction.self
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