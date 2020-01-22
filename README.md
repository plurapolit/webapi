# PluraPolit Web API

## Live Application

Staging can be found here: https://webapi-staging-lb-718828028.eu-central-1.elb.amazonaws.com </br>
Production can be found here: https://webapi-prod-lb-379596049.eu-central-1.elb.amazonaws.com

## Project Setup
1. Install "Ruby" and "Ruby Solargraph" VSCode extensions (VSCode only)
2. To log into the webapi in development mode, use the seeded admin `caspar@plurapolit.de` with PW `seedlog`

## API Enpoints

| HTTP Method | Endpoint  |  Description | Notes |
|---|---|---|---|
|POST| `/api/users/sign_in`  | Signs in the user  | 
```
BODY:

{
	"user": {
        "email": "myemail@hotmail.de",
        "password": "secret"
    }
}
```

|  |   |   |  |
|---|---|---|---|
|POST| `/api/users/sign_up`  |  Registration for the user ||
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
| |   |   | |
|---|---|---|---|
|POST|`/api/statements`|Creates a statement for a panel| Bearer token must be present in header |
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
| |   |   | |
|---|---|---|---|
|DELETE|`/api/statements/:id`|Deletes a statement  for a panel| Bearer token must be present in header |
|POST|`/api/statements/:id/comments`|Creates a comment for a statement| Bearer token must be present in header |
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
| |   |   | |
|---|---|---|---|
|DELETE|`/api/statements/:statement_id/comments/:comment_id`|Deletes a comment for a statement| Bearer token must be present in header |
|GET|`/api/statements/:statement_id/comments/`|Get all comments for a statement| |
|GET|`/api/panels/:id`|Get a specific panel with all statements and # of comments|