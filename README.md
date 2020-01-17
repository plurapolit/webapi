# PluraPolit Web API

## Live Application

Staging can be found here: https://webapi-staging-lb-718828028.eu-central-1.elb.amazonaws.com
Production can be found here: https://webapi-prod-lb-379596049.eu-central-1.elb.amazonaws.com

## Project Setup
1. Install "Ruby" and "Ruby Solargraph" VSCode extensions (VSCode only)
2. To log into the webapi in development mode, use the seeded admin `caspar@plurapolit.de` with PW `seedlog`

## API Enpoints

| HTTP Method | Endpoint  |  Description |  Body |
|---|---|---|---|
|POST| `/api/users/sign_in`  | Signs in the user  | { "user": { "email": "email@email.de", "password": "secret"}} | 
|POST| `/api/users/sign_up`  |  Registration for the user | {"user": {"email": "email@email.de","password": "secret","first_name": "Foo","last_name": "Bar"}}
|   |   |   |

