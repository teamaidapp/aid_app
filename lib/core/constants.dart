import 'package:team_aid/core/entities/dropdown.model.dart';
import 'package:team_aid/core/entities/states.model.dart';

/// It's a class that contains all the constants used in the app
class TAConstants {
  /// accessToken constant
  static const String accessToken = 'accessToken';

  /// The key for the user's first name in shared preferences.
  static const String firstName = 'firstName';

  /// The key for the user's last name in shared preferences.
  static const String lastName = 'lastName';

  /// The key for the user's email address in shared preferences.
  static const String email = 'email';

  /// The key for the user's phone number in shared preferences.
  static const String phoneNumber = 'phoneNumber';

  /// The key for the user's address in shared preferences.
  static const String address = 'address';

  /// The key for the user's role in shared preferences.
  static const String role = 'role';

  /// A list of all the sports
  static final sportsList = <TADropdownModel>[
    TADropdownModel(
      item: 'Cheerleading',
      id: '',
    )
  ];

  /// A list of the genders
  static final genderList = <TADropdownModel>[
    TADropdownModel(item: 'Men', id: ''),
    TADropdownModel(item: 'Women', id: ''),
  ];

  /// A list of all the age groups
  static final ageGroupList = <TADropdownModel>[
    TADropdownModel(item: 'Elementary', id: ''),
    TADropdownModel(item: 'Middle School', id: ''),
    TADropdownModel(item: 'High School', id: ''),
  ];

  /// A list of all the states in the US
  static final statesList = <StateModel>[
    StateModel(
      id: '0006c6652975-4dfb-a40a-c2bcb833cdb3',
      name: 'Vermont',
      stateCode: 'VT',
      latitude:
          '44.55880280                                                                                                                     ',
      longitude: '-72.57784150',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: '05d944cf-e4ac-4a04-8a63-4711768124db',
      name: 'Maryland',
      stateCode: 'MD',
      latitude:
          '39.04575490                                                                                                                     ',
      longitude: '-76.64127120',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '0b08512d-08ce-4792-96c9-eac62906aaa1',
      name: 'Johnston Atoll',
      stateCode: 'UM-67',
      latitude:
          '16.72950350                                                                                                                     ',
      longitude: '-169.53364770',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '0b82c1b6-cfd8-42de-abd7-d011fa5a923f',
      name: 'Delaware',
      stateCode: 'DE',
      latitude:
          '38.91083250                                                                                                                     ',
      longitude: '-75.52766990',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '0bafd08d-e93f-4025-9489-9a1c809f1dc5',
      name: 'Massachusetts',
      stateCode: 'MA',
      latitude:
          '42.40721070                                                                                                                     ',
      longitude: '-71.38243740',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '0c45df7c-904f-432e-ae62-820b4090306e',
      name: 'South Dakota',
      stateCode: 'SD',
      latitude:
          '43.96951480                                                                                                                     ',
      longitude: '-99.90181310',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '0cafc745-6a95-4041-8599-357a29168717',
      name: 'Wake Island',
      stateCode: 'UM-79',
      latitude:
          '19.27961900                                                                                                                     ',
      longitude: '166.64993480',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: '12e2244c-4b83-4efd-b79c-a496fbeeaf3a',
      name: 'Washington',
      stateCode: 'WA',
      latitude:
          '47.75107410                                                                                                                     ',
      longitude: '-120.74013850',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: '12fad261-21be-421a-881f-e226711c15da',
      name: 'Texas',
      stateCode: 'TX',
      latitude:
          '31.96859880                                                                                                                     ',
      longitude: '-99.90181310',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '1703914d-143b-400a-8ddf-69e6b7c47cad',
      name: 'United States Minor Outlying Islands',
      stateCode: 'UM',
      latitude:
          '19.28231920                                                                                                                     ',
      longitude: '166.64704700',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '1851ef0b-95f6-49c4-9edb-5ca7a6fe306a',
      name: 'Nebraska',
      stateCode: 'NE',
      latitude:
          '41.49253740                                                                                                                     ',
      longitude: '-99.90181310',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '1aa43315-f8e7-4019-91bf-a7b29f68cf81',
      name: 'Florida',
      stateCode: 'FL',
      latitude:
          '27.66482740                                                                                                                     ',
      longitude: '-81.51575350',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '1aa5d0f3-cdba-4457-a166-827db331c0a3',
      name: 'Mississippi',
      stateCode: 'MS',
      latitude:
          '32.35466790                                                                                                                     ',
      longitude: '-89.39852830',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '200a4f80-19e0-430e-bc84-d829b2dca9b7',
      name: 'Kansas',
      stateCode: 'KS',
      latitude:
          '39.01190200                                                                                                                     ',
      longitude: '-98.48424650',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '214dfbe3-b70b-4927-a66e-540e8bd89862',
      name: 'Louisiana',
      stateCode: 'LA',
      latitude:
          '30.98429770                                                                                                                     ',
      longitude: '-91.96233270',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '21c2bbd5-ab12-4297-84d4-25704190343f',
      name: 'Wyoming',
      stateCode: 'WY',
      latitude:
          '43.07596780                                                                                                                     ',
      longitude: '-107.29028390',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: '23842380-d89a-4b50-ada3-3635795358bc',
      name: 'New Mexico',
      stateCode: 'NM',
      latitude:
          '34.51994020                                                                                                                     ',
      longitude: '-105.87009010',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '2579c875-9c4e-4c9a-8043-72305f69b6f4',
      name: 'Oklahoma',
      stateCode: 'OK',
      latitude:
          '35.46756020                                                                                                                     ',
      longitude: '-97.51642760',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '2fc3e6be-8c0a-4e34-b87e-a63c3f853cfa',
      name: 'Palmyra Atoll',
      stateCode: 'UM-95',
      latitude:
          '5.88850260                                                                                                                      ',
      longitude: '-162.07866560',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '327ee44e-3c93-4aec-818c-b7319e59bff9',
      name: 'Pennsylvania',
      stateCode: 'PA',
      latitude:
          '41.20332160                                                                                                                     ',
      longitude: '-77.19452470',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '34bcba3d-f84f-4b2b-83cb-4a85e776d020',
      name: 'District of Columbia',
      stateCode: 'DC',
      latitude:
          '38.90719230                                                                                                                     ',
      longitude: '-77.03687070',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '44b69eca-59d8-4ee6-a23d-308bb86f52ea',
      name: 'Maine',
      stateCode: 'ME',
      latitude:
          '45.25378300                                                                                                                     ',
      longitude: '-69.44546890',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '460ecbdd-ffe5-4fe1-a86f-df867bef773f',
      name: 'Connecticut',
      stateCode: 'CT',
      latitude:
          '41.60322070                                                                                                                     ',
      longitude: '-73.08774900',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '4f03f1e8-2a6e-40bc-adc3-35b2d42544e4',
      name: 'Nevada',
      stateCode: 'NV',
      latitude:
          '38.80260970                                                                                                                     ',
      longitude: '-116.41938900',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '5402adcc-8f7f-4e32-bb49-fa079a3d28a4',
      name: 'American Samoa',
      stateCode: 'AS',
      latitude:
          '-14.27097200                                                                                                                    ',
      longitude: '-170.13221700',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '5e8531e3-59f2-482d-812e-e4e9b6035c1d',
      name: 'Idaho',
      stateCode: 'ID',
      latitude:
          '44.06820190                                                                                                                     ',
      longitude: '-114.74204080',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '64651134-8bef-43a6-a210-9ca86f94ff6a',
      name: 'Navassa Island',
      stateCode: 'UM-76',
      latitude:
          '18.41006890                                                                                                                     ',
      longitude: '-75.01146120',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '6a07680a-be36-41c4-bba7-4d3dac6cd39c',
      name: 'Hawaii',
      stateCode: 'HI',
      latitude:
          '19.89676620                                                                                                                     ',
      longitude: '-155.58278180',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '6ab5c291-fcf0-44e6-9752-f1c37e31c45b',
      name: 'Alabama',
      stateCode: 'AL',
      latitude:
          '32.31823140                                                                                                                     ',
      longitude: '-86.90229800',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '6e423670-0a4b-4d6d-bbdd-48f83368550f',
      name: 'United States Virgin Islands',
      stateCode: 'VI',
      latitude:
          '18.33576500                                                                                                                     ',
      longitude: '-64.89633500',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '6e67549d-2b80-4e54-94c3-33696626a20b',
      name: 'Howland Island',
      stateCode: 'UM-84',
      latitude:
          '0.81132190                                                                                                                      ',
      longitude: '-176.61827360',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '7db1ada1-0031-4c39-b70c-a2a30866e291',
      name: 'North Carolina',
      stateCode: 'NC',
      latitude:
          '35.75957310                                                                                                                     ',
      longitude: '-79.01929970',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '7f4a6b14-9afc-4cbe-87d9-47aac2d94f83',
      name: 'Ohio',
      stateCode: 'OH',
      latitude:
          '40.41728710                                                                                                                     ',
      longitude: '-82.90712300',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '87cd38f6-abd3-47f3-804a-03ded51b4163',
      name: 'Arizona',
      stateCode: 'AZ',
      latitude:
          '34.04892810                                                                                                                     ',
      longitude: '-111.09373110',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '8aecb653-3805-477e-9474-f0aa8a1ce118',
      name: 'Illinois',
      stateCode: 'IL',
      latitude:
          '40.63312490                                                                                                                     ',
      longitude: '-89.39852830',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '90e58f8f-c873-4689-b1ae-b50a08ce8bdc',
      name: 'Kingman Reef',
      stateCode: 'UM-89',
      latitude:
          '6.38333300                                                                                                                      ',
      longitude: '-162.41666700',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: '967bb263-1905-4dc8-a445-be45c0ca90be',
      name: 'Wisconsin',
      stateCode: 'WI',
      latitude:
          '43.78443970                                                                                                                     ',
      longitude: '-88.78786780',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: '97e7328d-e254-45cf-b82a-4e034e45cd3d',
      name: 'New Hampshire',
      stateCode: 'NH',
      latitude:
          '43.19385160                                                                                                                     ',
      longitude: '-71.57239530',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: '9971426c-28e2-4b63-8fa5-9a65ce51a8e8',
      name: 'Alaska',
      stateCode: 'AK',
      latitude:
          '64.20084130                                                                                                                     ',
      longitude: '-149.49367330',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: '9f7f8dda-3885-44ef-b508-627c29370922',
      name: 'Indiana',
      stateCode: 'IN',
      latitude:
          '40.26719410                                                                                                                     ',
      longitude: '-86.13490190',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'a3a99e42-c601-427c-a4f1-8a52e23ff6e1',
      name: 'Northern Mariana Islands',
      stateCode: 'MP',
      latitude:
          '15.09790000                                                                                                                     ',
      longitude: '145.67390000',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'a60ed5ae-525f-474d-b057-31df456c8da5',
      name: 'California',
      stateCode: 'CA',
      latitude:
          '36.77826100                                                                                                                     ',
      longitude: '-119.41793240',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: 'a9925da2-0889-4f44-9886-0e6d2078f162',
      name: 'Missouri',
      stateCode: 'MO',
      latitude:
          '37.96425290                                                                                                                     ',
      longitude: '-91.83183340',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'ab61b841-fc9c-40b9-bc30-3f7170081d0b',
      name: 'Utah',
      stateCode: 'UT',
      latitude:
          '39.32098010                                                                                                                     ',
      longitude: '-111.09373110',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: 'ae5af537-132f-4ae4-8d23-98560984044d',
      name: 'New York',
      stateCode: 'NY',
      latitude:
          '40.71277530                                                                                                                     ',
      longitude: '-74.00597280',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'af7b2bc6-d29d-4c0c-950d-59fd70b506b2',
      name: 'Rhode Island',
      stateCode: 'RI',
      latitude:
          '41.58009450                                                                                                                     ',
      longitude: '-71.47742910',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'b4cdae78-6cdf-4f4c-8afb-dbe0edfdb87e',
      name: 'Tennessee',
      stateCode: 'TN',
      latitude:
          '35.51749130                                                                                                                     ',
      longitude: '-86.58044730',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'bd6e5a5a-9ec7-4d93-9458-064a7545e188',
      name: 'Guam',
      stateCode: 'GU',
      latitude:
          '13.44430400                                                                                                                     ',
      longitude: '144.79373100',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: 'be6f774b-ce4d-43a9-96bc-16efad2e66e6',
      name: 'Iowa',
      stateCode: 'IA',
      latitude:
          '41.87800250                                                                                                                     ',
      longitude: '-93.09770200',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'be9dfdeb-bcb1-4160-ba37-020891803596',
      name: 'Baker Island',
      stateCode: 'UM-81',
      latitude:
          '0.19362660                                                                                                                      ',
      longitude: '-176.47690800',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: 'bf51bea8-de2a-42a3-bb5b-8e0ada9d2249',
      name: 'Oregon',
      stateCode: 'OR',
      latitude:
          '43.80413340                                                                                                                     ',
      longitude: '-120.55420120',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'ca7e3b21-3e88-46ed-89cf-cce7f6145b94',
      name: 'Kentucky',
      stateCode: 'KY',
      latitude:
          '37.83933320                                                                                                                     ',
      longitude: '-84.27001790',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'cec3f351-5147-490f-b93a-38689ccc2f26',
      name: 'Midway Atoll',
      stateCode: 'UM-71',
      latitude:
          '28.20721680                                                                                                                     ',
      longitude: '-177.37349260',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'd18fe0ca-6024-44ad-bddf-090f5c92f22b',
      name: 'North Dakota',
      stateCode: 'ND',
      latitude:
          '47.55149260                                                                                                                     ',
      longitude: '-101.00201190',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'd2a9645e-14c5-43d8-9c96-ca5f2d4dd74b',
      name: 'West Virginia',
      stateCode: 'WV',
      latitude:
          '38.59762620                                                                                                                     ',
      longitude: '-80.45490260',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: 'd2e8925e-3618-4689-ab21-6e4078a2f3b6',
      name: 'Puerto Rico',
      stateCode: 'PR',
      latitude:
          '18.22083300                                                                                                                     ',
      longitude: '-66.59014900',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'd31502ef-ffae-4d5d-b064-314afb5fa525',
      name: 'Colorado',
      stateCode: 'CO',
      latitude:
          '39.55005070                                                                                                                     ',
      longitude: '-105.78206740',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: 'dfe48b44-22e6-43c8-a00f-d00d532201cf',
      name: 'Virginia',
      stateCode: 'VA',
      latitude:
          '37.43157340                                                                                                                     ',
      longitude: '-78.65689420',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.467Z',
      updatedAt: '2022-03-17T17:54:12.467Z',
    ),
    StateModel(
      id: 'e1465d7d-91a5-4377-a68d-873838a93ece',
      name: 'New Jersey',
      stateCode: 'NJ',
      latitude:
          '40.05832380                                                                                                                     ',
      longitude: '-74.40566120',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'e6b19ee1-4d47-4d38-a14e-a108dd1baccf',
      name: 'Montana',
      stateCode: 'MT',
      latitude:
          '46.87968220                                                                                                                     ',
      longitude: '-110.36256580',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'edfc1f32-e1a3-4abc-a115-f85ca57b26bb',
      name: 'South Carolina',
      stateCode: 'SC',
      latitude:
          '33.83608100                                                                                                                     ',
      longitude: '-81.16372450',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.466Z',
      updatedAt: '2022-03-17T17:54:12.466Z',
    ),
    StateModel(
      id: 'eeb090af-8128-4c76-b4b2-dd913c4a6f64',
      name: 'Minnesota',
      stateCode: 'MN',
      latitude:
          '46.72955300                                                                                                                     ',
      longitude: '-94.68589980',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'ef86f533-c8b5-4d98-b6f3-6256b38997c1',
      name: 'Georgia',
      stateCode: 'GA',
      latitude:
          '32.16562210                                                                                                                     ',
      longitude: '-82.90007510',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
    StateModel(
      id: 'f7ea4014-772f-478c-a7b1-7992ae62ea49',
      name: 'Michigan',
      stateCode: 'MI',
      latitude:
          '44.31484430                                                                                                                     ',
      longitude: '-85.60236430',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'fd1237db-40ff-4f03-9a8f-fef1925f5179',
      name: 'Jarvis Island',
      stateCode: 'UM-86',
      latitude:
          '-0.37435030                                                                                                                     ',
      longitude: '-159.99672060',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54:12.465Z',
      updatedAt: '2022-03-17T17:54:12.465Z',
    ),
    StateModel(
      id: 'fddea57a-d835-4c72-969e-b689f24966df',
      name: 'Arkansas',
      stateCode: 'AR',
      latitude: '35.20105000',
      longitude: '-91.83183340',
      countryCode: 'US',
      countryName: 'United States',
      type: 'NULL',
      createdAt: '2022-03-17T17:54,:12.464Z',
      updatedAt: '2022-03-17T17:54:12.464Z',
    ),
  ];
}