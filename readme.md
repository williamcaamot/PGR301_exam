## Oppgave 1 - AWS Lambda

#### Trinn 1: Opprett en SAM-applikasjon
- [ ] Opprett en ny mappe i repositoryet ditt for SAM-applikasjonen, for eksempel kalt `sam_lambda`.
- [ ] Sett opp infrastrukturen for Lambda-funksjonen på en av følgende måter:
    - [ ] Bruk `sam init` til å generere en ny SAM-applikasjon i Python.
  - [ ] Alternativt, bruk filer fra et eksisterende SAM-prosjekt som utgangspunkt, og tilpass dem etter behov for denne oppgaven.

#### Trinn 2: Skriv Lambda-funksjonen

- [ ] Implementer koden fra `generate_image.py` som en Lambda-funksjon. Funksjonen skal motta en forespørsel via et POST-endepunkt, generere et bilde-  og deretter lagre det i S3-bucketen `pgr301-couch-explorers`. Bruk kandidatnummeret ditt som prefix, slik at URI-en til bildene dine blir `s3://pgr301-couch-explorers/<kandidatnr>/*`. Bildets prompt skal sendes som en  HTTP body i forespørselen.

#### Trinn 3: Fjern hardkoding av bucket-navn fra koden
For å gjøre løsningen mer fleksibel og profesjonell, skal du fjerne hardkodingen av S3-bucket-navnet fra `generate_image.py`. Definer bucket-navnet i SAM-templatefilen og bruk en dynamisk måte for funksjonen å hente dette navnet på, slik at du unngår å legge bucket-navnet direkte inn i koden.

#### Trinn 4: Test og deploy SAM-applikasjonen

1. Bygg Lambda-funksjonen lokalt med SAM CLI for å sikre at den fungerer som forventet.
2. Deploy applikasjonen. Etter deploy bør du verifisere at POST-endepunktet fungerer, og at Lambda-funksjonen kan lagre filer i S3-bucketen `pgr301-couch-explorers`.

#### Tips og anbefalinger
- **Timeout**: Husk at Lambdafunksjoner har en konfigurerbar timeout
- **IAM-rolle**: Sørg for at Lambda-funksjonen har nødvendige tillatelser til å skrive til S3-bucketen, og kalle tjenesten AWS Bedrock
- **Regionkonfigurasjon**: Husk at regionen for infrastrukturen skal være `eu-west-1`, selv om ressurser som AWS Bedrock kan ligge i andre regioner.

#### Leveranser

* HTTP Endepunkt for Lambdafunksjonen som sensor kan teste med Postman