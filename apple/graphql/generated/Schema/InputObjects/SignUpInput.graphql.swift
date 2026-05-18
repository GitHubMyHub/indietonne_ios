// @generated
// This file was automatically generated and should not be edited.

@_spi(Internal) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct SignUpInput: InputObject {
    private(set) var __data: InputDict

    init(_ data: InputDict) {
      __data = data
    }

    init(
      id: GraphQLNullable<String> = nil,
      username: String,
      password: String,
      firebaseToken: String,
      deviceInfo: String
    ) {
      __data = InputDict([
        "id": id,
        "username": username,
        "password": password,
        "firebaseToken": firebaseToken,
        "deviceInfo": deviceInfo
      ])
    }

    var id: GraphQLNullable<String> {
      get { __data["id"] }
      set { __data["id"] = newValue }
    }

    var username: String {
      get { __data["username"] }
      set { __data["username"] = newValue }
    }

    var password: String {
      get { __data["password"] }
      set { __data["password"] = newValue }
    }

    var firebaseToken: String {
      get { __data["firebaseToken"] }
      set { __data["firebaseToken"] = newValue }
    }

    var deviceInfo: String {
      get { __data["deviceInfo"] }
      set { __data["deviceInfo"] = newValue }
    }
  }

}