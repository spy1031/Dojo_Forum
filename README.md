# API

## Get all articles

* METHOD:GET
* URI: /api/v1/articles

##Below action must login
* METHOD:POST
* URI: /api/v1/login/
* params: :email, :password
If login successfully, you will get an auth_token.

You also can use fb_token to login.
* params: :access_token

## Show the article 

* METHOD:GET
* URI: /api/v1/articles/:id
* params: :auth_token

## Create a article 

* METHOD:POST
* URI: /api/v1/articles/:id
* params: :title,:content,:category_ids,:authority,(:draft),:auth_token

## Update the article 

* METHOD:PATCH
* URI: /api/v1/articles/:id
* params: :title,:content,:category_ids,:authority,(:draft),:auth_token

## Delete the article 

* METHOD:DELETE
* URI: /api/v1/articles/:id
* params: :auth_token