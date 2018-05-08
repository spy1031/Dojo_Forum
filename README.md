# API

##:Get all articles

*METHOD:GET
*URI: /api/v1/articles

##:Show the article 

*METHOD:GET
*URI: /api/v1/articles/:id

##:Create a article 

*METHOD:POST
*URI: /api/v1/articles/:id
*params: :title,:content,:category_ids,:authority,(:draft)

##:Update the article 

*METHOD:PATCH
*URI: /api/v1/articles/:id
*params: :title,:content,:category_ids,:authority,(:draft)

##:Delete the article 

*METHOD:DELETE
*URI: /api/v1/articles/:id