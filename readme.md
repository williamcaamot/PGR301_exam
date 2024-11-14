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
- [ ] Should always use the least privileges

## Oppgave 3
Image navn:
> williamcaamot/oppgave3_java_sqs_client

### Beskrivelse av taggestrategi
- Strategien jeg har valgt for tagging er å bruke commit-hashen fra hver commit til main som tag, samtidig som latest taggen alltid peker til den nyeste committen på main. Denne strategien er i tråd med hva som anses som god praksis innen Continuous Deployment. Dette gjør det enkelt å alltid bruke siste versjon, samtidig som man enkelt kan rulle tilbake til tidligere versjoner. Strategien gjør det også enkelt å koble commits i GitHub med imagetagger i Docker Hub. En ulempe er at det raskt kan bli mange imagetagger. Hvis man har et fullt automatisert CI/CD-oppsett der commits til main utløser en ny versjon, kan dette være en passende strategi. Men hvis man ønsker å kun release av og til, og commits til main ikke nødvendigvis betyr en ny release, kan denne strategien føre til unødvendig mange imageversjoner i Docker Hub. Et devops team ville sannsynligvis laget en taggestrategi som passer godt med deres egen releasestrategi. 

## Oppgave 4

