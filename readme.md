<h1 style="text-align:center;">PGR301 EKSAMEN 2024</h1>
<h2 style="text-align:center;">Couch Explorers - Bærekraftig turisme fra sofakroken</h2>
<img width="1181" alt="image" src="img/header.png">

## Oppgave 1
### A Leveranse:
HTTP Endepunkt for Lambdafunksjonen som kan testes med Postman:  
> https://aq295t7f7k.execute-api.eu-west-1.amazonaws.com/Prod

Eksempel request body:
> {
> "prompt":"A nice dry martini on a beach"
> }

### B Leveranse:
Lenke til kjørt GitHub Actions workflow:
> https://github.com/williamcaamot/PGR301_exam/actions/runs/11839013074/job/32989460565

### To-do
- [ ] Should try run the python tests to see if they run as expected, Glenn might do this
- [ ] Could add logging to this function as a plus
- [ ] Could define SAM role/policy for this

## Oppgave 2


### A Leveranse:
> aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/47-image-queue --message-body "Nice image"

### B Leveranse:
Pushe til main branch Workflow run:
> https://github.com/williamcaamot/PGR301_exam/actions/runs/11840387251

Pushe til annen branch Workfow run:
> https://github.com/williamcaamot/PGR301_exam/actions/runs/11839387056

Ønsker å skrive her at denne oppgaven kunne vært løst på ulike måter (man kunne hatt kun en job i workflowen, og avgjort hvilke steps man kunne ha gjort), men jeg syns det ryddigste var å ha to jobs siden det er enklere å se hvilken job som kjører, enn hvilke steps inne i en job som kjører.


### To-do
- [ ] Should use modules
- [ ] Should use .env variables to extract necessary information and store them as .envs rather than in the text
- [ ] Should always use least privilege

## Oppgave 3
Image navn:
> williamcaamot/oppgave3_java_sqs_client

### Beskrivelse av taggestrategi
- Det er ulike måter å trigge en workflow, den kan trigges fra en push (som beskrevet i oppgaven), manuelt. 

- Kunne bruk en tag som f.eks. versjon, men det krever at man manuelt endrer tags, så for full automatisering har jeg valgt å bruke commit hashen som hver commit automatisk får. Dette gjør det også enkelt for utviklere å koble en image versjon mot en commit. Dette er likevel ikke en perfekt strategi, og én av ulempene med denne strategien er at det fort kan bli mange image versjoner i dockerhub. Hvis man har et helt automatisert oppsett med CI/CD der commits til main skal release en ny "versjon" kan dette være en passende strategi, men hvis man ønsker å kun release en gang i blandt og at commits til main ikke nødvendigvis betyr en ny release, kan denne strategien lage unødvendig mange image versjoner i dockerhub. Et "ekte" team hadde nok laget en tagge strategi som passet godt med deres egen release strategi.

## Oppgave 4

