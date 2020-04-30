## Apa yang digunakan?

1. CRUD Operation
1. HTTP Request
1. Bloc pattern

## Langkah - langkah
- Model:
  - properties component
  - constructor
  - fromJson function
  - toJson function
  - JsonFormatList to model(decode)
  - modelList to JsonFormatList(encode)
- Provider:
  - properties baseUrl
  - function CRUD (each method)
- Repository:
  - properties api provider
  - function to defintion operation CRUD (each method)
- Bloc:
  - properties repository
  - StreamController (each method)
  - I/O to StreamSink for CRUD (each method)
  - Constructor
  - handle function CRUD (each method)
  - dispose
- UI:
  - StreamBuilder
  - ListView.builder
  - FloatingActionButton to route Add Page
  - condition for update or add new

## Screenshot
![Screenshot_2020-04-30-21-25-14-923_com example crudhttpbloc (1)](https://user-images.githubusercontent.com/53436238/80727508-ffd38f00-8b2f-11ea-9e16-bdb382d1c575.jpg)
![Screenshot_2020-04-30-21-25-54-647_com example crudhttpbloc (1)](https://user-images.githubusercontent.com/53436238/80727512-0235e900-8b30-11ea-8c0f-ad83e6154ee0.jpg)

![Screenshot_2020-04-30-21-26-09-082_com example crudhttpbloc (1)](https://user-images.githubusercontent.com/53436238/80727534-0530d980-8b30-11ea-88f7-181aeb457cd7.jpg)
![Screenshot_2020-04-30-21-26-15-914_com example crudhttpbloc (1)](https://user-images.githubusercontent.com/53436238/80727543-06fa9d00-8b30-11ea-86b5-e85967152c96.jpg)

