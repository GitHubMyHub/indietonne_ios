// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct PaginationInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      page: GraphQLNullable<Int32> = nil,
      size: GraphQLNullable<Int32> = nil
    ) {
      __data = InputDict([
        "page": page,
        "size": size
      ])
    }

    var page: GraphQLNullable<Int32> {
      get { __data["page"] }
      set { __data["page"] = newValue }
    }

    var size: GraphQLNullable<Int32> {
      get { __data["size"] }
      set { __data["size"] = newValue }
    }
  }

}