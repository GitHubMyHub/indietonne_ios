// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct ScheduleDataInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      placeId: UUID,
      streetId: UUID,
      previousDays: Int32,
      time: LocalTime,
      fractions: [String]
    ) {
      __data = InputDict([
        "placeId": placeId,
        "streetId": streetId,
        "previousDays": previousDays,
        "time": time,
        "fractions": fractions
      ])
    }

    var placeId: UUID {
      get { __data["placeId"] }
      set { __data["placeId"] = newValue }
    }

    var streetId: UUID {
      get { __data["streetId"] }
      set { __data["streetId"] = newValue }
    }

    var previousDays: Int32 {
      get { __data["previousDays"] }
      set { __data["previousDays"] = newValue }
    }

    var time: LocalTime {
      get { __data["time"] }
      set { __data["time"] = newValue }
    }

    var fractions: [String] {
      get { __data["fractions"] }
      set { __data["fractions"] = newValue }
    }
  }

}