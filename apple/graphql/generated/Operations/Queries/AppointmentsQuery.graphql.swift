// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct AppointmentsQuery: GraphQLQuery {
    static let operationName: String = "Appointments"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query Appointments($pagination: PaginationInput!) { appointments(pagination: $pagination) { __typename number size totalElements totalPages content { __typename id reminderAlarm reminderNotify appointments { __typename id appointmentDate scheduledDate interval repetition alarm notify active fractions { __typename id name icon } } street { __typename id name districts { __typename id name } } place { __typename id zipCodes name images { __typename storedName origin } } } } }"#
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
        .field("appointments", Appointments.self, arguments: ["pagination": .variable("pagination")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        AppointmentsQuery.Data.self
      ] }

      var appointments: Appointments { __data["appointments"] }

      init(
        appointments: Appointments
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Query.typename,
          "appointments": appointments._fieldData,
        ])
      }

      /// Appointments
      ///
      /// Parent Type: `PlatformUserPlacePaginated`
      nonisolated struct Appointments: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.PlatformUserPlacePaginated }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("number", Int.self),
          .field("size", Int.self),
          .field("totalElements", Int.self),
          .field("totalPages", Int.self),
          .field("content", [Content].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          AppointmentsQuery.Data.Appointments.self
        ] }

        var number: Int { __data["number"] }
        var size: Int { __data["size"] }
        var totalElements: Int { __data["totalElements"] }
        var totalPages: Int { __data["totalPages"] }
        var content: [Content] { __data["content"] }

        init(
          number: Int,
          size: Int,
          totalElements: Int,
          totalPages: Int,
          content: [Content]
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.PlatformUserPlacePaginated.typename,
            "number": number,
            "size": size,
            "totalElements": totalElements,
            "totalPages": totalPages,
            "content": content._fieldData,
          ])
        }

        /// Appointments.Content
        ///
        /// Parent Type: `PlatformUserPlace`
        nonisolated struct Content: InDieTonneAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.PlatformUserPlace }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", InDieTonneAPI.UUID.self),
            .field("reminderAlarm", InDieTonneAPI.LocalTime.self),
            .field("reminderNotify", InDieTonneAPI.LocalTime.self),
            .field("appointments", [Appointment].self),
            .field("street", Street.self),
            .field("place", Place.self),
          ] }
          static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
            AppointmentsQuery.Data.Appointments.Content.self
          ] }

          var id: InDieTonneAPI.UUID { __data["id"] }
          var reminderAlarm: InDieTonneAPI.LocalTime { __data["reminderAlarm"] }
          var reminderNotify: InDieTonneAPI.LocalTime { __data["reminderNotify"] }
          var appointments: [Appointment] { __data["appointments"] }
          var street: Street { __data["street"] }
          var place: Place { __data["place"] }

          init(
            id: InDieTonneAPI.UUID,
            reminderAlarm: InDieTonneAPI.LocalTime,
            reminderNotify: InDieTonneAPI.LocalTime,
            appointments: [Appointment],
            street: Street,
            place: Place
          ) {
            self.init(unsafelyWithData: [
              "__typename": InDieTonneAPI.Objects.PlatformUserPlace.typename,
              "id": id,
              "reminderAlarm": reminderAlarm,
              "reminderNotify": reminderNotify,
              "appointments": appointments._fieldData,
              "street": street._fieldData,
              "place": place._fieldData,
            ])
          }

          /// Appointments.Content.Appointment
          ///
          /// Parent Type: `Appointment`
          nonisolated struct Appointment: InDieTonneAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Appointment }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", InDieTonneAPI.UUID.self),
              .field("appointmentDate", InDieTonneAPI.Instant.self),
              .field("scheduledDate", InDieTonneAPI.Instant.self),
              .field("interval", Int.self),
              .field("repetition", Int.self),
              .field("alarm", Bool.self),
              .field("notify", Bool.self),
              .field("active", Bool.self),
              .field("fractions", [Fraction].self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              AppointmentsQuery.Data.Appointments.Content.Appointment.self
            ] }

            var id: InDieTonneAPI.UUID { __data["id"] }
            var appointmentDate: InDieTonneAPI.Instant { __data["appointmentDate"] }
            var scheduledDate: InDieTonneAPI.Instant { __data["scheduledDate"] }
            var interval: Int { __data["interval"] }
            var repetition: Int { __data["repetition"] }
            var alarm: Bool { __data["alarm"] }
            var notify: Bool { __data["notify"] }
            var active: Bool { __data["active"] }
            var fractions: [Fraction] { __data["fractions"] }

            init(
              id: InDieTonneAPI.UUID,
              appointmentDate: InDieTonneAPI.Instant,
              scheduledDate: InDieTonneAPI.Instant,
              interval: Int,
              repetition: Int,
              alarm: Bool,
              notify: Bool,
              active: Bool,
              fractions: [Fraction]
            ) {
              self.init(unsafelyWithData: [
                "__typename": InDieTonneAPI.Objects.Appointment.typename,
                "id": id,
                "appointmentDate": appointmentDate,
                "scheduledDate": scheduledDate,
                "interval": interval,
                "repetition": repetition,
                "alarm": alarm,
                "notify": notify,
                "active": active,
                "fractions": fractions._fieldData,
              ])
            }

            /// Appointments.Content.Appointment.Fraction
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
                AppointmentsQuery.Data.Appointments.Content.Appointment.Fraction.self
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

          /// Appointments.Content.Street
          ///
          /// Parent Type: `Street`
          nonisolated struct Street: InDieTonneAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Street }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", InDieTonneAPI.UUID.self),
              .field("name", String.self),
              .field("districts", [District].self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              AppointmentsQuery.Data.Appointments.Content.Street.self
            ] }

            var id: InDieTonneAPI.UUID { __data["id"] }
            var name: String { __data["name"] }
            var districts: [District] { __data["districts"] }

            init(
              id: InDieTonneAPI.UUID,
              name: String,
              districts: [District]
            ) {
              self.init(unsafelyWithData: [
                "__typename": InDieTonneAPI.Objects.Street.typename,
                "id": id,
                "name": name,
                "districts": districts._fieldData,
              ])
            }

            /// Appointments.Content.Street.District
            ///
            /// Parent Type: `District`
            nonisolated struct District: InDieTonneAPI.SelectionSet {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.District }
              static var __selections: [ApolloAPI.Selection] { [
                .field("__typename", String.self),
                .field("id", InDieTonneAPI.UUID.self),
                .field("name", String?.self),
              ] }
              static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
                AppointmentsQuery.Data.Appointments.Content.Street.District.self
              ] }

              var id: InDieTonneAPI.UUID { __data["id"] }
              var name: String? { __data["name"] }

              init(
                id: InDieTonneAPI.UUID,
                name: String? = nil
              ) {
                self.init(unsafelyWithData: [
                  "__typename": InDieTonneAPI.Objects.District.typename,
                  "id": id,
                  "name": name,
                ])
              }
            }
          }

          /// Appointments.Content.Place
          ///
          /// Parent Type: `Place`
          nonisolated struct Place: InDieTonneAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Place }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", InDieTonneAPI.UUID.self),
              .field("zipCodes", [String].self),
              .field("name", String.self),
              .field("images", [Image].self),
            ] }
            static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
              AppointmentsQuery.Data.Appointments.Content.Place.self
            ] }

            var id: InDieTonneAPI.UUID { __data["id"] }
            var zipCodes: [String] { __data["zipCodes"] }
            var name: String { __data["name"] }
            var images: [Image] { __data["images"] }

            init(
              id: InDieTonneAPI.UUID,
              zipCodes: [String],
              name: String,
              images: [Image]
            ) {
              self.init(unsafelyWithData: [
                "__typename": InDieTonneAPI.Objects.Place.typename,
                "id": id,
                "zipCodes": zipCodes,
                "name": name,
                "images": images._fieldData,
              ])
            }

            /// Appointments.Content.Place.Image
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
                AppointmentsQuery.Data.Appointments.Content.Place.Image.self
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
          }
        }
      }
    }
  }

}