// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct StreetFiler: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      placeId: UUID,
      districtId: GraphQLNullable<UUID> = nil
    ) {
      __data = InputDict([
        "placeId": placeId,
        "districtId": districtId
      ])
    }

    var placeId: UUID {
      get { __data["placeId"] }
      set { __data["placeId"] = newValue }
    }

    var districtId: GraphQLNullable<UUID> {
      get { __data["districtId"] }
      set { __data["districtId"] = newValue }
    }
  }

}