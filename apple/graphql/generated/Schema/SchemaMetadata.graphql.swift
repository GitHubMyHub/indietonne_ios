// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

nonisolated protocol InDieTonneAPI_SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == InDieTonneAPI.SchemaMetadata {}

nonisolated protocol InDieTonneAPI_InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == InDieTonneAPI.SchemaMetadata {}

nonisolated protocol InDieTonneAPI_MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == InDieTonneAPI.SchemaMetadata {}

nonisolated protocol InDieTonneAPI_MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == InDieTonneAPI.SchemaMetadata {}

extension InDieTonneAPI {
  typealias SelectionSet = InDieTonneAPI_SelectionSet

  typealias InlineFragment = InDieTonneAPI_InlineFragment

  typealias MutableSelectionSet = InDieTonneAPI_MutableSelectionSet

  typealias MutableInlineFragment = InDieTonneAPI_MutableInlineFragment

  nonisolated enum SchemaMetadata: ApolloAPI.SchemaMetadata {
    static let configuration: any ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

    private static let objectTypeMap: [String: ApolloAPI.Object] = [
      "Appointment": InDieTonneAPI.Objects.Appointment,
      "Device": InDieTonneAPI.Objects.Device,
      "District": InDieTonneAPI.Objects.District,
      "DistrictPaginated": InDieTonneAPI.Objects.DistrictPaginated,
      "Fraction": InDieTonneAPI.Objects.Fraction,
      "ImageMetaData": InDieTonneAPI.Objects.ImageMetaData,
      "Mutation": InDieTonneAPI.Objects.Mutation,
      "Place": InDieTonneAPI.Objects.Place,
      "PlacePaginated": InDieTonneAPI.Objects.PlacePaginated,
      "PlatformUser": InDieTonneAPI.Objects.PlatformUser,
      "PlatformUserPlace": InDieTonneAPI.Objects.PlatformUserPlace,
      "PlatformUserPlacePaginated": InDieTonneAPI.Objects.PlatformUserPlacePaginated,
      "Query": InDieTonneAPI.Objects.Query,
      "Street": InDieTonneAPI.Objects.Street,
      "StreetPaginated": InDieTonneAPI.Objects.StreetPaginated,
      "UserPaginated": InDieTonneAPI.Objects.UserPaginated
    ]

    static func objectType(forTypename typename: String) -> ApolloAPI.Object? {
      objectTypeMap[typename]
    }
  }

  nonisolated enum Objects {}
  nonisolated enum Interfaces {}
  nonisolated enum Unions {}

}