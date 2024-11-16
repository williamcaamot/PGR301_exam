<h1 style="text-align:center;">PGR301 EKSAMEN 2024</h1>
<h2 style="text-align:center;">Couch Explorers - Bærekraftig turisme fra sofakroken</h2>
<img width="1181" alt="image" src="img/header.png">

# Workflow status

[![Build Status](https://github.com/williamcaamot/PGR301_exam/actions/workflows/oppgave1_lambda_deploy.yml/badge.svg)](https://github.com/williamcaamot/PGR301_exam/actions/workflows/oppgave1_lambda_deploy.yml)
[![Test Status](https://github.com/williamcaamot/PGR301_exam/actions/workflows/oppgave2_terraform_deploy.yml/badge.svg)](https://github.com/williamcaamot/PGR301_exam/actions/workflows/oppgave2_terraform_deploy.yml)
[![Deploy Status](https://github.com/williamcaamot/PGR301_exam/actions/workflows/oppgave3_docker_publish.yml/badge.svg)](https://github.com/williamcaamot/PGR301_exam/actions/workflows/oppgave3_docker_publish.yml)



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

## Oppgave 2


### A Leveranse:
> aws sqs send-message --queue-url https://sqs.eu-west-1.amazonaws.com/244530008913/47-image-queue --message-body "Nice image"

### B Leveranse:
Pushe til main branch Workflow run:
> https://github.com/williamcaamot/PGR301_exam/actions/runs/11840387251

Pushe til annen branch Workfow run:
> https://github.com/williamcaamot/PGR301_exam/actions/runs/11856737263

- Jeg ønsker å skrive at denne oppgaven kunne vært løst på flere måter. For eksempel kunne man ha valgt å ha kun én job i workflowen og deretter avgjort hvilke steg som skulle kjøres basert på hvilken branch det var pushet til. Likevel valgte jeg å dele det opp i to separate jobber, for å få en litt mer oversiktlig struktur. Med to jobber er det lettere å identifisere hvilken job som kjører, fremfor å gå inn I jobben å se hvilke steg som ble gjort.
- Jeg lagde en TF modul for vise at jeg er kjent med dette også.

## Oppgave 3
Image navn:
`williamcaamot/oppgave3_java_sqs_client`

### Beskrivelse av taggestrategi
> Strategien jeg har valgt for tagging er å bruke commit-hashen fra hver commit til main som tag, samtidig som latest taggen alltid peker til den nyeste committen på main. Denne strategien passer godt med kravet om at teamet alltid skal ha tilgang til den nyeste versjonen av klienten (oppgavetekst). Strategien er også i tråd med hva som anses som god praksis for Continuous Deployment. Dette gjør det enkelt å alltid bruke siste versjon, samtidig som man enkelt kan bruke tidligere versjoner. Strategien gjør det også enkelt å koble commits i GitHub med imagetagger på DockerHub. En ulempe er at det raskt kan bli mange imagetagger. Hvis man har et fullt automatisert CI/CD-oppsett der commits til main utgir en ny versjon, kan dette være en passende strategi. Hvis man ønsker å kun release av og til, og commits til main ikke nødvendigvis betyr en ny release, kan denne strategien føre til unødvendig mange imageversjoner i Docker Hub.

### Docker-kommando:
`docker run -e AWS_ACCESS_KEY_ID=xxx -e AWS_SECRET_ACCESS_KEY=yyy -e SQS_QUEUE_URL=https://sqs.eu-west-1.amazonaws.com/244530008913/47-image-queue williamcaamot/oppgave3_java_sqs_client "me on top of a pyramid"`


## Oppgave 4
> E-post kan endres i variables.tf i oppgave2_infra mappen.
> Eval perioder = 1
> Period = 60
> Threshold = 45 
> 
Terskler er satt ganske aggresivt til å begynne med, men siden brukere allerede har klaget i App Store (oppgavetekst) er det bedre å begynne aggresivt, deretter prøve å løse problemet før man eventuelt setter mindre aggresive terskler.


## Oppgave 5

### Eierskap og ansvar

Ansvar og eierskap for applikasjonens ytelse, pålitelighet og kostnader I serverless vs. mikrotjenester vil avhenge av om man tenker på applikasjonsnivå eller infrastrukturnivå. Begge disse nivåene har stor innvirkning på hvordan DevOps-teamet har eierskap til applikasjonens ytelse, pålitelighet og kostnader.


Hvis vi tenker på infrastrukturnivå vil DevOps-teamet få mindre ansvar og eierskap til ytelse og pålitelighet ved overgang til serverless fra mikrotjenester. Infrastrukturen abstraheres bort i serverless, og skyleverandøren tar ansvar for drift, skalerbarhet, og oppetid. Dette reduserer behovet for å konfigurere og drifte servere manuelt, noe som igjen kan føre til indre ansvar og eierskap til ytelse og pålitelighet. I mikrotjenester har teamet større kontroll for infrastrukturen, og må selv ta ansvar for vedlikehold, konfigurasjon og drift. Dette kan gi større ansvar og eierskap til ytelse og pålitelighet


Videre, hvis vi ser på applikasjonsnivå vil teamet sannsynligvis få større eierskap til ytelse og pålitelighet ved en serverless-tilnærming. Dette er fordi serverless applikasjoner er mer fragmenterte, som gjør det enklere å se nøyaktig hva man jobber med, som igjen kan gjøre det enklere å få eierskap til individuelle tjenester. Det kan også være enklere å se hvem som er ansvarlig for en tjeneste I en serverless arkitektur, som igjen kan medvirke til mer ansvar og eierskap til de tjenestene et team jobber med. En ulempe ved serverless er at det kan bli  vanskeligere å se helheten av det man jobber med, og redusere ansvaret for ytelsen og påliteligheten til applikasjonen som en helhet. Ved mikrotjenester er tjenester typisk større og mer omfattende, noe som kan gjøre det vanskelig å få eierksap til individuelle deler. Likevel kan teamet også ha mye eierskap ved en mikrotjenestearkitektur fordi ansvaret og eierskapet til ytelse og pålitelighet er mer kollektivt som er I god tråd med devops prinsippet som handler om samarbeid og delt ansvar.


Når det gjelder kostnader, vil DevOps-teamet sannsynligvis få større eierskap til kostnader i serverless, fordi hver funksjon faktureres separat basert på bruk. Dette gjør det enklere å identifisere hvilke tjenester som driver kostnader, og deretter iverksette tiltak for å optimalisere bruk for å få ned kostnader. Mikrotjenester driftes vanligvis på ressurser som EC2 instanser som kan gjøre det vanskeligere å identifisere nøyaktig hvilke deler av applikasjonen som driver kostnad, som igjen kan redusere eierskap og ansvar knyttet til kostnader.
