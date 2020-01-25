# PluraPolit Web API

## Live Application

Staging can be found here: https://webapi-staging-lb-718828028.eu-central-1.elb.amazonaws.com </br>
Production can be found here: https://webapi-prod-lb-379596049.eu-central-1.elb.amazonaws.com

## Project Setup
1. Install "Ruby" and "Ruby Solargraph" VSCode extensions (VSCode only)
2. To log into the webapi in development mode, use the seeded admin `caspar@plurapolit.de` with PW `seedlog`

## API Enpoints

| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|POST| `/api/users/sign_in`  | Signs in the user  | | Should return 201 |
```
BODY:

{
	"user": {
        "email": "myemail@hotmail.de",
        "password": "secret"
    }
}
```

| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|POST| `/api/users/sign_up`  |  Registration for the user || Should return 201 |
```
BODY:

{
	"user": {
        "email": "myemail@hotmail.de",
        "password": "secret",
        "first_name": "Max",
        "last_name": "Müller"
    }
}
```
| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|POST|`/api/statements`|Creates a statement for a panel| Bearer token must be present in header | Should return 201 |
```
BODY:

{
	"statement": {
		"panel_id": "1",
		"quote": "This is the statement about"
	},
	
	"audio_file": {
		"file_link": "https://mysong.de/test.mp3",
		"duration_seconds": "99"
	}
}
```
| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|DELETE|`/api/statements/:id`|Deletes a statement  for a panel| Bearer token must be present in header | Should return 204 |
|POST|`/api/statements/:id/comments`|Creates a comment for a statement| Bearer token must be present in header | Should return 201 |
```
BODY:

  {
    "comment": {
      "quote": "This is a great comment"
    },
    "audio_file": {
      "file_link": "https://mysong.de/test.mp3",
      "duration_seconds": "99"
    }
  }
```
| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|DELETE|`/api/statements/:statement_id/comments/:comment_id`|Deletes a comment for a statement| Bearer token must be present in header | Should return 204 |
|GET|`/api/statements/:statement_id/comments/`|Get all comments for a statement| | Should return 200 |
|GET|`/api/panels/:id`|Get a specific panel with all statements and # of comments and likes| | Should return 200 |
|POST|`/api/statements/:statement_id/likes`|Likes a statement| Bearer token must be present in header | Should return 201 |
|DELETE|`/api/statements/:statement_id/likes`|Unlikes a statement| Bearer token must be present in header | Should return 204 |
|GET|`/api/slugs`|Get all slugs with corresponding panel id||Should return 200|