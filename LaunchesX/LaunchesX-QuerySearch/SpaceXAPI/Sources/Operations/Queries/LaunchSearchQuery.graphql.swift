// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class LaunchSearchQuery: GraphQLQuery {
  public static let operationName: String = "LaunchSearch"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      #"""
      query LaunchSearch($find: LaunchFind, $offset: Int, $limit: Int) {
        launches(find: $find, offset: $offset, limit: $limit) {
          __typename
          id
          launch_date_local
          mission_name
          launch_success
          launch_site {
            __typename
            site_name
          }
          rocket {
            __typename
            rocket_name
            rocket {
              __typename
              description
              wikipedia
            }
          }
        }
      }
      """#
    ))

  public var find: GraphQLNullable<LaunchFind>
  public var offset: GraphQLNullable<Int>
  public var limit: GraphQLNullable<Int>

  public init(
    find: GraphQLNullable<LaunchFind>,
    offset: GraphQLNullable<Int>,
    limit: GraphQLNullable<Int>
  ) {
    self.find = find
    self.offset = offset
    self.limit = limit
  }

  public var __variables: Variables? { [
    "find": find,
    "offset": offset,
    "limit": limit
  ] }

  public struct Data: SpaceXAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("launches", [Launch?]?.self, arguments: [
        "find": .variable("find"),
        "offset": .variable("offset"),
        "limit": .variable("limit")
      ]),
    ] }

    public var launches: [Launch?]? { __data["launches"] }

    /// Launch
    ///
    /// Parent Type: `Launch`
    public struct Launch: SpaceXAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.Launch }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", SpaceXAPI.ID?.self),
        .field("launch_date_local", SpaceXAPI.Date?.self),
        .field("mission_name", String?.self),
        .field("launch_success", Bool?.self),
        .field("launch_site", Launch_site?.self),
        .field("rocket", Rocket?.self),
      ] }

      public var id: SpaceXAPI.ID? { __data["id"] }
      public var launch_date_local: SpaceXAPI.Date? { __data["launch_date_local"] }
      public var mission_name: String? { __data["mission_name"] }
      public var launch_success: Bool? { __data["launch_success"] }
      public var launch_site: Launch_site? { __data["launch_site"] }
      public var rocket: Rocket? { __data["rocket"] }

      /// Launch.Launch_site
      ///
      /// Parent Type: `LaunchSite`
      public struct Launch_site: SpaceXAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.LaunchSite }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("site_name", String?.self),
        ] }

        public var site_name: String? { __data["site_name"] }
      }

      /// Launch.Rocket
      ///
      /// Parent Type: `LaunchRocket`
      public struct Rocket: SpaceXAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.LaunchRocket }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("rocket_name", String?.self),
          .field("rocket", Rocket?.self),
        ] }

        public var rocket_name: String? { __data["rocket_name"] }
        public var rocket: Rocket? { __data["rocket"] }

        /// Launch.Rocket.Rocket
        ///
        /// Parent Type: `Rocket`
        public struct Rocket: SpaceXAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SpaceXAPI.Objects.Rocket }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("description", String?.self),
            .field("wikipedia", String?.self),
          ] }

          public var description: String? { __data["description"] }
          public var wikipedia: String? { __data["wikipedia"] }
        }
      }
    }
  }
}
