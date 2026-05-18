// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct ResetPasswordInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      token: String,
      newPassword: String
    ) {
      __data = InputDict([
        "token": token,
        "newPassword": newPassword
      ])
    }

    var token: String {
      get { __data["token"] }
      set { __data["token"] = newValue }
    }

    var newPassword: String {
      get { __data["newPassword"] }
      set { __data["newPassword"] = newValue }
    }
  }

}