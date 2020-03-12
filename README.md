# PluraPolit Web API

## Live Application

Staging can be found here: https://webapi-staging-lb-718828028.eu-central-1.elb.amazonaws.com </br>
Production can be found here: https://webapi-prod-lb-379596049.eu-central-1.elb.amazonaws.com

## Project Setup
1. Install "Ruby" and "Ruby Solargraph" VSCode extensions (VSCode only)
2. If not done before, install mailcatcher: `gem install mailcatcher`
3. Then to use it just run `mailcatcher`
4. Now go to localhost:1080 to see all mails, that would be sent out
5. To seed the development environment run `rails db:seed`
6. To log into the webapi in development mode, use the seeded admin `caspar@plurapolit.de` with PW `seedlog`

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
|POST| `/api/users/`  |  Registration for the user || Should return 201 |
```
BODY:

{
    "user": {
	"email": "myemail@hotmail.de",
	"password": "secret",
	"first_name": "Max",
	"last_name": "Müller",
	"age_range_id: "2"
    }
}
```
See info about age range on bottom: [Age Ranges](#age-ranges) </br>

| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|DELETE|`/api/users/sign_out`|Signs the user out| Bearer token must be present in header | Should return 204 |
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
|POST|`/api/users/password`|Sends E-Mail to reset password| | Should return 201 |
```
BODY:

{
	"user": {
        "email": "foo@bar.com"
    }
}
```
| HTTP Method | Endpoint  |  Description | Notes | Desired status code |
|---|---|---|---|---|
|PATCH|`/api/users/password`|Resets the password| reset token is gotten from URL (sent by email) | Should return 204 |
```
BODY:

{
	"user": {
        "password": "seedlog",
        "password_confirmation": "seedlog",
        "reset_password_token": "aZQpjuuAzN8QbczqD-_x"
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
|GET|`/api/panels/`|Get all categories and panels| | Should return 200 |
|POST|`/api/statements/:statement_id/likes`|Likes a statement| Bearer token must be present in header | Should return 201 |
|DELETE|`/api/statements/:statement_id/likes`|Unlikes a statement| Bearer token must be present in header | Should return 204 |
|GET|`/api/slugs`|Get all slugs with corresponding panel id||Should return 200|
|GET|`/api/authenticate`|Check if token is still valid|Bearer token must be present in header|Should return 200|
|POST|`/api/feedbacks/`|Sends feedback| NO BEARER neccessary | Should return 201 |
```
BODY:
	{
		"feedback": {
			"description": "this is lit",
			"email": "me@robin.com"
		}
	}
```
|POST|`/api/user_audio_trackings/`|Sends user audio tracking| NO BEARER neccessary, user_id optional, is_intro only neccessary if it is an intro | Should return 201 |
```
BODY:
  {
    "user_id": 1,
    "statement_id": 1,
    "current_position_in_seconds": 80,
    "playtime_in_seconds": 80,
    "is_intro": true
  }
```
|PUT|`/api/user_audio_trackings/:id`|Updates user audio tracking| NO BEARER neccessary | Should return 204 |
```
BODY:
  {
    "current_position_in_seconds": 80,
    "playtime_in_seconds": 80
  }
```

## Age Ranges
| ID | Start Age  |  End Age |
|---|---|---|
|1|NULL|15|
|2|16|28|
|3|29|44|
|4|45|60|
|5|61|NULL|
