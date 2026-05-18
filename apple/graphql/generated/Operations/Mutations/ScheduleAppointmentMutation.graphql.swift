// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI
@_spi(Execution) @_spi(Unsafe) import ApolloAPI

extension InDieTonneAPI {
  nonisolated struct ScheduleAppointmentMutation: GraphQLMutation {
    static let operationName: String = "ScheduleAppointment"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"mutation ScheduleAppointment($scheduleAppointment: ScheduleDataInput!) { schedule(scheduleAppointment: $scheduleAppointment) { __typename id fractions { __typename id name icon } } }"#
      ))

    public var scheduleAppointment: ScheduleDataInput

    public init(scheduleAppointment: ScheduleDataInput) {
      self.scheduleAppointment = scheduleAppointment
    }

    @_spi(Unsafe) public var __variables: Variables? { ["scheduleAppointment": scheduleAppointment] }

    nonisolated struct Data: InDieTonneAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.Mutation }
      static var __selections: [ApolloAPI.Selection] { [
        .field("schedule", Schedule.self, arguments: ["scheduleAppointment": .variable("scheduleAppointment")]),
      ] }
      static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
        ScheduleAppointmentMutation.Data.self
      ] }

      var schedule: Schedule { __data["schedule"] }

      init(
        schedule: Schedule
      ) {
        self.init(unsafelyWithData: [
          "__typename": InDieTonneAPI.Objects.Mutation.typename,
          "schedule": schedule._fieldData,
        ])
      }

      /// Schedule
      ///
      /// Parent Type: `PlatformUserPlace`
      nonisolated struct Schedule: InDieTonneAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { InDieTonneAPI.Objects.PlatformUserPlace }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", InDieTonneAPI.UUID.self),
          .field("fractions", [Fraction].self),
        ] }
        static var __fulfilledFragments: [any ApolloAPI.SelectionSet.Type] { [
          ScheduleAppointmentMutation.Data.Schedule.self
        ] }

        var id: InDieTonneAPI.UUID { __data["id"] }
        var fractions: [Fraction] { __data["fractions"] }

        init(
          id: InDieTonneAPI.UUID,
          fractions: [Fraction]
        ) {
          self.init(unsafelyWithData: [
            "__typename": InDieTonneAPI.Objects.PlatformUserPlace.typename,
            "id": id,
            "fractions": fractions._fieldData,
          ])
        }

        /// Schedule.Fraction
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
            ScheduleAppointmentMutation.Data.Schedule.Fraction.self
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