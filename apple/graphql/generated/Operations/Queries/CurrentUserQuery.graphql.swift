// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct CurrentUserQuery: GraphQLQuery {
    static let operationName: String = "CurrentUser"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query CurrentUser { users(pagination: { page: 0, size: 1 }) { __typename content { __typename id username devices { __typename id token agent createdAt updatedAt } } } }"#
      ))

    public init() {}

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("users", Users.self, arguments: ["pagination": [
          "page": 0,
          "size": 1
        ]]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        CurrentUserQuery.Data.self
      ] }

      var users: Users { __data["users"] }

      init(
        users: Users
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "users": users._fieldData,
        ])
      }

      /// Users
      ///
      /// Parent Type: `UserPaginated`
      nonisolated struct Users: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.UserPaginated }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("content", [Content].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          CurrentUserQuery.Data.Users.self
        ] }

        var content: [Content] { __data["content"] }

        init(
          content: [Content]
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.UserPaginated.typename,
            "content": content._fieldData,
          ])
        }

        /// Users.Content
        ///
        /// Parent Type: `PlatformUser`
        nonisolated struct Content: InDieTonneAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.PlatformUser }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", String.self),
            .field("username", String.self),
            .field("devices", [Device].self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            CurrentUserQuery.Data.Users.Content.self
          ] }

          var id: String { __data["id"] }
          var username: String { __data["username"] }
          var devices: [Device] { __data["devices"] }

          init(
            id: String,
            username: String,
            devices: [Device]
          ) {
            self.init(unsafelyWithData: [
              "__typename": InDieTonneAPI.Objects.PlatformUser.typename,
              "id": id,
              "username": username,
              "devices": devices._fieldData,
            ])
          }

          /// Users.Content.Device
          ///
          /// Parent Type: `Device`
          nonisolated struct Device: InDieTonneAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Device }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", String.self),
              .field("token", String.self),
              .field("agent", String.self),
              .field("createdAt", InDieTonneAPI.Instant.self),
              .field("updatedAt", InDieTonneAPI.Instant?.self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              CurrentUserQuery.Data.Users.Content.Device.self
            ] }

            var id: String { __data["id"] }
            var token: String { __data["token"] }
            var agent: String { __data["agent"] }
            var createdAt: InDieTonneAPI.Instant { __data["createdAt"] }
            var updatedAt: InDieTonneAPI.Instant? { __data["updatedAt"] }

            init(
              id: String,
              token: String,
              agent: String,
              createdAt: InDieTonneAPI.Instant,
              updatedAt: InDieTonneAPI.Instant? = nil
            ) {
              self.init(unsafelyWithData: [
                "__typename": InDieTonneAPI.Objects.Device.typename,
                "id": id,
                "token": token,
                "agent": agent,
                "createdAt": createdAt,
                "updatedAt": updatedAt,
              ])
            }
          }
        }
      }
    }
  }

}